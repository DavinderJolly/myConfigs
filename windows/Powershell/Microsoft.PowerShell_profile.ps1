# NameSpaces Required for custom binds
using namespace System.Management.Automation
using namespace System.Management.Automation.Language


### Dependencies ###

# For older shell prompt
# winget install oh-my-posh

# For faste cross-platform starship shell prompt
# cargo install starship --locked

# Install-Module -Name Terminal-Icons -Repository PSGallery
# Install-Module -Name posh-git -Scope CurrentUser
# curl.exe -A "MS" https://webinstall.dev/zoxide | powershell
# cargo install fd-find
# (install fzf from git or package manager)
# Install-Module -Name PSFzf -Scope CurrentUser

# Get newer PSReadLine to get better completions
# Install-Module -Name PSReadLine -Scope CurrentUser -Force

# Nice to have things
# cargo install ripgrep
# winget install Neovim.Neovim

# Set up the theme
Import-Module posh-git

# Set oh my posh theme # Old slower prompt
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression

# Set starship prompt
Invoke-Expression (&starship init powershell)

# Set Terminal Icons
Import-Module Terminal-Icons

# Disable default venv prompt
$ENV:VIRTUAL_ENV_DISABLE_PROMPT = 1

# Start the ssh-agent
Start-Service ssh-agent

# Set up custom scripts
$CustomScripts = "C:\\Users\\DELL\\Documents\\PowerShell\\CustomScripts"
(Get-Alias Manage-Venv -ErrorAction Ignore || New-Alias -Name Manage-Venv -Value "$CustomScripts\\Manage-Venv.ps1") > NUL

# Set aliases
Set-Alias less 'C:\\Program Files\\Git\\usr\\bin\\less.exe'
Set-Alias tig 'C:\\Program Files\\Git\\usr\\bin\\tig.exe'

# Set gvim to be gitbash's vim while replacing windows vim with nvim
Set-Alias gvim 'C:\\Program Files\\Git\\usr\\bin\\vim.exe'

if (Get-Command nvim -ErrorAction SilentlyContinue) {
  # Set vim to open neovim
  Set-Alias vim nvim
  # Set Vim as Visual and Editor
  $ENV:VISUAL = "nvim"
  $ENV:EDITOR = "nvim"
}

# Set up Suggestions
Import-Module PSReadLine


# Set vim mode
Set-PSReadLineOption -EditMode Vi


# Making sure history doesn't have duplicates
Set-PSReadLineOption -HistoryNoDuplicates


# Autocompleteion for Arrow keys
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key Ctrl-p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl-n -Function HistorySearchForward
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -BellStyle None

# Set the color for Prediction (auto-suggestion)
Set-PSReadlineOption -Colors @{InlinePrediction = "DarkGray" }

# Fzf setup


if (Get-Module -ListAvailable -Name PSFzf)
{
  $ENV:FZF_DEFAULT_COMMAND='fd --type f --hidden --color=always --exclude node_modules --exclude .git --exclude .venv'
  $ENV:FZF_DEFAULT_OPTS="--ansi"
  $ENV:FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  $ENV:FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"
  $ENV:FZF_ALT_C_COMMAND="fd --type d --hidden --color=always --exclude node_modules --exclude .git --exclude .venv"
  $ENV:FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS"
  Import-Module PSFzf

  # Override PSReadLine's history search
  Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
                  -PSReadlineChordReverseHistory 'Ctrl+r'

  # Override default tab completion
  Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

  # Allow alias
  Set-PsFzfOption -EnableAliasFuzzyKillProcess
  Set-PsFzfOption -EnableAliasFuzzyEdit

} else {
  # Shows navigable menu of all options when hitting Tab
  Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
}

# Zoxide setup
if (Get-Command zoxide -ErrorAction SilentlyContinue)
{
  Invoke-Expression (& {
      $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
      (zoxide init --hook $hook powershell | Out-String)
  })

  # Set cd to use z
  Remove-Alias cd -errorAction SilentlyContinue
  Set-Alias cd z

  Remove-Alias cdi -errorAction SilentlyContinue
  Set-Alias cdi zi
}

# ---- Key Handlers ----


# The next four key handlers are designed to make entering matched quotes
# parens, and braces a nicer experience.

Set-PSReadLineKeyHandler -Key '"',"'" `
  -BriefDescription SmartInsertQuote `
  -LongDescription "Insert paired quotes if not already on a quote" `
  -ScriptBlock {
  param($key, $arg)

  $quote = $key.KeyChar

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  # If text is selected, just quote it without any smarts
  if ($selectionStart -ne -1)
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $quote + $line.SubString($selectionStart, $selectionLength) + $quote)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
    return
  }

  $ast = $null
  $tokens = $null
  $parseErrors = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$parseErrors, [ref]$null)

  function FindToken
  {
    param($tokens, $cursor)

    foreach ($token in $tokens)
    {
      if ($cursor -lt $token.Extent.StartOffset)
      { continue
      }
      if ($cursor -lt $token.Extent.EndOffset)
      {
        $result = $token
        $token = $token -as [StringExpandableToken]
        if ($token)
        {
          $nested = FindToken $token.NestedTokens $cursor
          if ($nested)
          { $result = $nested
          }
        }

        return $result
      }
    }
    return $null
  }

  $token = FindToken $tokens $cursor

  # If we're on or inside a **quoted** string token (so not generic), we need to be smarter
  if ($token -is [StringToken] -and $token.Kind -ne [TokenKind]::Generic)
  {
    # If we're at the start of the string, assume we're inserting a new string
    if ($token.Extent.StartOffset -eq $cursor)
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote ")
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
      return
    }

    # If we're at the end of the string, move over the closing quote if present.
    if ($token.Extent.EndOffset -eq ($cursor + 1) -and $line[$cursor] -eq $quote)
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
      return
    }
  }

  if ($null -eq $token -or
    $token.Kind -eq [TokenKind]::RParen -or $token.Kind -eq [TokenKind]::RCurly -or $token.Kind -eq [TokenKind]::RBracket)
  {
    if ($line[0..$cursor].Where{$_ -eq $quote}.Count % 2 -eq 1)
    {
      # Odd number of quotes before the cursor, insert a single quote
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
    } else
    {
      # Insert matching quotes, move cursor to be in between the quotes
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote")
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
    }
    return
  }

  # If cursor is at the start of a token, enclose it in quotes.
  if ($token.Extent.StartOffset -eq $cursor)
  {
    if ($token.Kind -eq [TokenKind]::Generic -or $token.Kind -eq [TokenKind]::Identifier -or
      $token.Kind -eq [TokenKind]::Variable -or $token.TokenFlags.hasFlag([TokenFlags]::Keyword))
    {
      $end = $token.Extent.EndOffset
      $len = $end - $cursor
      [Microsoft.PowerShell.PSConsoleReadLine]::Replace($cursor, $len, $quote + $line.SubString($cursor, $len) + $quote)
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($end + 2)
      return
    }
  }

  # We failed to be smart, so just insert a single quote
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
}

Set-PSReadLineKeyHandler -Key '(','{','[' `
  -BriefDescription InsertPairedBraces `
  -LongDescription "Insert matching braces" `
  -ScriptBlock {
  param($key, $arg)

  $closeChar = switch ($key.KeyChar)
  {
    <#case#> '('
    { [char]')'; break
    }
    <#case#> '{'
    { [char]'}'; break
    }
    <#case#> '['
    { [char]']'; break
    }
  }

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($selectionStart -ne -1)
  {
    # Text is selected, wrap it in brackets
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $key.KeyChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
  } else
  {
    # No text is selected, insert a pair
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)$closeChar")
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  }
}

Set-PSReadLineKeyHandler -Key ')',']','}' `
  -BriefDescription SmartCloseBraces `
  -LongDescription "Insert closing brace or skip" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($line[$cursor] -eq $key.KeyChar)
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  } else
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)")
  }
}

Set-PSReadLineKeyHandler -Key Backspace `
  -BriefDescription SmartBackspace `
  -LongDescription "Delete previous character or matching quotes/parens/braces" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -gt 0)
  {
    $toMatch = $null
    if ($cursor -lt $line.Length)
    {
      switch ($line[$cursor])
      {
        <#case#> '"'
        { $toMatch = '"'; break
        }
        <#case#> "'"
        { $toMatch = "'"; break
        }
        <#case#> ')'
        { $toMatch = '('; break
        }
        <#case#> ']'
        { $toMatch = '['; break
        }
        <#case#> '}'
        { $toMatch = '{'; break
        }
      }
    }

    if ($toMatch -ne $null -and $line[$cursor-1] -eq $toMatch)
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor - 1, 2)
    } else
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteChar($key, $arg)
    }
  }
}

# Insert text from the clipboard as a here string
Set-PSReadLineKeyHandler -Chord Ctrl+Alt+v `
  -BriefDescription PasteAsHereString `
  -LongDescription "Paste the clipboard text as a here string" `
  -ScriptBlock {
  param($key, $arg)

  Add-Type -Assembly PresentationCore
  if ([System.Windows.Clipboard]::ContainsText())
  {
    # Get clipboard text - remove trailing spaces, convert \r\n to \n, and remove the final \n.
    $text = ([System.Windows.Clipboard]::GetText() -replace "\p{Zs}*`r?`n","`n").TrimEnd()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("@'`n$text`n'@")
  } else
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
  }
}


# Sometimes you want to get a property of invoke a member on what you've entered so far
# but you need parens to do that.  This binding will help by putting parens around the current selection,
# or if nothing is selected, the whole line.
Set-PSReadLineKeyHandler -Chord 'Alt+(' `
  -BriefDescription ParenthesizeSelection `
  -LongDescription "Put parenthesis around the selection or entire line and move the cursor to after the closing parenthesis" `
  -ScriptBlock {
  param($key, $arg)

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  if ($selectionStart -ne -1)
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, '(' + $line.SubString($selectionStart, $selectionLength) + ')')
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
  } else
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, '(' + $line + ')')
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
  }
}


# This example will replace any aliases on the command line with the resolved commands.
Set-PSReadLineKeyHandler -Chord "Alt+L" `
  -BriefDescription ExpandAliases `
  -LongDescription "Replace all aliases with the full command" `
  -ScriptBlock {
  param($key, $arg)

  $ast = $null
  $tokens = $null
  $errors = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

  $startAdjustment = 0
  foreach ($token in $tokens)
  {
    if ($token.TokenFlags -band [TokenFlags]::CommandName)
    {
      $alias = $ExecutionContext.InvokeCommand.GetCommand($token.Extent.Text, 'Alias')
      if ($alias -ne $null)
      {
        $resolvedCommand = $alias.ResolvedCommandName
        if ($resolvedCommand -ne $null)
        {
          $extent = $token.Extent
          $length = $extent.EndOffset - $extent.StartOffset
          [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
            $extent.StartOffset + $startAdjustment,
            $length,
            $resolvedCommand)

          # Our copy of the tokens won't have been updated, so we need to
          # adjust by the difference in length
          $startAdjustment += ($resolvedCommand.Length - $length)
        }
      }
    }
  }
}

# ---- Utility commands ----

function which($command) {
    <#
    .SYNOPSIS
    which [<-]<command> similar to which in bash

    .DESCRIPTION
    Returns the full path of the command if it is found in the PATH.

    .PARAMETER <command>
    The command to search for.
    #>
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function tree {
    <#
    .SYNOPSIS
    Prints a directory's subtree structure, optionally with exclusions.                        #'

    .DESCRIPTION
    Prints a given directory's subdirectory structure recursively in tree form,
    so as to visualize the directory hierarchy similar to cmd.exe's built-in
    'tree' command, but with the added ability to exclude subtrees by directory
    names.

    NOTE: Symlinks to directories are not followed; a warning to that effect is
        issued.

    .PARAMETER Path
    The target directory path; defaults to the current directory.
    You may specify a wildcard pattern, but it must resolve to a single directory.

    .PARAMETER Exclude
    One or more directory names that should be excluded from the output; wildcards
    are permitted. Any directory that matches anywhere in the target hierarchy
    is excluded, along with its subtree.
    If -IncludeFiles is also specified, the exclusions are applied to the files'
    names as well.

    .PARAMETER IncludeFiles
    By default, only directories are printed; use this switch to print files
    as well.

    .PARAMETER Ascii
    Uses ASCII characters to visualize the tree structure; by default, graphical
    characters from the OEM character set are used.

    .PARAMETER IndentCount
    Specifies how many characters to use to represent each level of the hierarchy.
    Defaults to 4.

    .PARAMETER Force
    Includes hidden items in the output; by default, they're ignored.

    .NOTES
    Directory symlinks are NOT followed, and a warning to that effect is issued.

    .EXAMPLE
    tree

    Prints the current directory's subdirectory hierarchy.

    .EXAMPLE
    tree ~/Projects -Ascii -Force -Exclude node_modules, .git

    Prints the specified directory's subdirectory hierarchy using ASCII characters
    for visualization, including hidden subdirectories, but excluding the
    subtrees of any directories named 'node_modules' or '.git'.

    #>

    [cmdletbinding(PositionalBinding = $false)]
    param(
        [parameter(Position = 0)]
        [string] $Path = '.',
        [string[]] $Exclude,
        [ValidateRange(1, [int]::maxvalue)]
        [int] $IndentCount = 4,
        [switch] $Ascii,
        [switch] $Force,
        [switch] $IncludeFiles
    )

    # Embedded recursive helper function for drawing the tree.
    function _tree_helper {

        param(
            [string] $literalPath,
            [string] $prefix
        )

        # Get all subdirs. and, if requested, also files.
        $items = Get-ChildItem -Directory:(-not $IncludeFiles) -LiteralPath $LiteralPath -Force:$Force

        # Apply exclusion filter(s), if specified.
        if ($Exclude -and $items) {
            $items = $items.Where({ $name = $_.Name; -not $Exclude.Where({ $name -like $_ }, 'First') })
        }

        if (-not $items) { return } # no subdirs. / files, we're done

        $i = 0
        foreach ($item in $items) {
            $isLastSibling = ++$i -eq $items.Count
            # Print this dir.
            $prefix + $(if ($isLastSibling) { $chars.last } else { $chars.interior }) + $chars.hline * ($indentCount - 1) + $item.Name
            # Recurse, if it's a subdir (rather than a file).
            if ($item.PSIsContainer) {
                if ($item.LinkType) { Write-Warning "Not following dir. symlink: $item"; continue }
                $subPrefix = $prefix + $(if ($isLastSibling) { $chars.space * $indentCount } else { $chars.vline + $chars.space * ($indentCount - 1) })
                _tree_helper $item.FullName $subPrefix
            }
        }
    } # function _tree_helper

    # Hashtable of characters used to draw the structure
    $ndx = [bool] $Ascii
    $chars = @{
        interior = ('+', '+')[$ndx]
        last     = ('+', '\\')[$ndx]                                                                #'
        hline    = ('-', '-')[$ndx]
        vline    = ('?', '|')[$ndx]
        space    = ' '
    }

    # Resolve the path to a full path and verify its existence and expected type.
    $literalPath = (Resolve-Path $Path).Path
    if (-not $literalPath -or -not (Test-Path -PathType Container -LiteralPath $literalPath) -or $literalPath.count -gt 1) { throw "'$Path' must resolve to a single, existing directory." }

    # Print the target path.
    $literalPath

    # Invoke the helper function to draw the tree.
    _tree_helper $literalPath

}
