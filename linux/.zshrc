# Davinder's zsh config

# Set default editor
export EDITOR=vim

# Add doom emacs executable to path
export PATH="$HOME/.emacs.d/bin/:$PATH"

# Vim mode and backspace fix
set -o vi
bindkey "^?" backward-delete-char

# Open command in vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd ^X^E edit-command-line

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# Setting up version control prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' formats "%{$reset_color%}[%{$fg[blue]%}%b%{$reset_color%}] %{$fg[red]%}%u%c%m%{$reset_color%}"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='?'
  fi
}

# Setting up Aliases
alias xclip='xargs echo -n | xclip -selection clipboard'  # xclip fix

if command -v emacsclient &> /dev/null; then
    alias emacs="emacsclient -c -a 'emacs'"
fi

if command -v nvim &> /dev/null; then
    alias gvim=/usr/bin/env\ vim
    alias vim=nvim
fi

if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd=z
fi


if command -v lsd &> /dev/null; then
    alias ls=lsd
fi

if command -v batcat &> /dev/null; then
    alias cat=batcat\ --theme\ TwoDark
fi

# Load plugins.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
