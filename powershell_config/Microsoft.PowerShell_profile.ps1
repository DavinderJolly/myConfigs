# Set up the theme
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme slimfat

# Disable default venv prompt
$ENV:VIRTUAL_ENV_DISABLE_PROMPT = 1

# Start the ssh-agent
Start-Service ssh-agent

# Set up custom scripts
$CustomScripts = "C:\Users\DELL\Documents\PowerShell\CustomScripts"
New-Alias -Name Manage-Venv -Value "$CustomScripts\Manage-Venv.ps1"

# Set up Suggestions
Import-Module PSReadLine

# Shows navigable menu of all options when hitting Tab
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Autocompleteion for Arrow keys
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -PredictionSource History

#Set the color for Prediction (auto-suggestion)
Set-PSReadlineOption -Colors @{InlinePrediction = "DarkGray"}
