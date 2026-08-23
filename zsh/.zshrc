# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/zshrc.pre.zsh"

# Suppress Powerlevel10k instant prompt console output warnings
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

eval "$(mise activate zsh)"

# Gitlab env variables
export GITLAB_TOKEN="glpat-H0QRNUv9-zF0XO4tfutkHm86MQp1OjFjCA.01.0y1h8lbi7"
export GITLAB_VIM_URL="https://gitlab.e-sky.ca"
export GITLAB_INSTANCE_URL="https://gitlab.e-sky.ca"
export GITLAB_BASE_URL="https://gitlab.e-sky.ca"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f ~/.local/share/zinit/zinit.git/plugins/romkatv---powerlevel10k/powerlevel10k.zsh-theme ]]; then
  # Zinit installation
  zinit ice depth=1; zinit light romkatv/powerlevel10k
fi

# Load Zinit (plugin manager)
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    mkdir -p "$HOME/.local/share/zinit"
    git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

# Load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors
autoload -Uz run-help

source ~/.config/blackdovah_zsh_configs/rc

# Completion opts
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33
zstyle ':completion:*' file-list true
zstyle ':completion:*' squeeze-slashes false

# Main opts
setopt extended_glob
setopt vi
setopt autocd
setopt extendedhistory

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=200000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY


# Prompt (fallback if powerlevel10k fails)
PROMPT="${debian_chroot:+($debian_chroot)}%F{yellow}%D{%d-%m-%Y} %*%f %F{green}%n@%m%f:%F{cyan}%~%f
%F{white}%#%f "

# XTerm title
case "$TERM" in
  xterm*|rxvt*|ghostty)  # Added ghostty support
    precmd() { print -Pn "\e]0;%n@%m: %~\a" }
    ;;
esac


# Color support for ls and grep
if command -v dircolors >/dev/null; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi


# Use eza if available (Ubuntu 24.04), fallback to exa, then ls
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --color=auto --icons'
  alias exa='eza --icons'
elif command -v exa >/dev/null 2>&1; then
  alias ls='exa --color=auto --icons'
  alias exa='exa --icons'
else
  alias ls='ls --color=auto'
fi

# Process viewer - procs might not be available
if command -v procs >/dev/null 2>&1; then
  alias ps='procs'
fi

# Other aliases
if command -v lazydocker >/dev/null 2>&1; then
  alias lzd='lazydocker'
fi


# NVM (with existence check)
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# PNPM (with existence check)
if [[ -d "$HOME/.local/share/pnpm" ]]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  [[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"
fi


# Homebrew (with existence check)
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Cargo (with existence check)
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ZSH plugins - check if homebrew versions exist, fallback to system packages
if command -v brew >/dev/null 2>&1 && [[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [[ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if command -v brew >/dev/null 2>&1 && [[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [[ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Powerlevel10k (with existence check)
if command -v brew >/dev/null 2>&1 && [[ -f "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
fi

# Pyenv (with existence check)
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)" 2>/dev/null
  eval "$(pyenv virtualenv-init -)" 2>/dev/null
fi

# Starship (with existence check)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# P10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/zshrc.post.zsh"
export PATH="$HOME/.local/share/omarchy/bin:$PATH"
eval $(keychain --eval --quiet GH_id_rsa)
# shellcheck shell=bash


# Add to path
export PATH=/home/$USER/Documents/bib/:$PATH

# Created by `pipx` on 2025-12-01 15:03:45
export PATH="$PATH:/home/blackdovah/.local/bin"
# Turso
export PATH="$PATH:/home/blackdovah/.turso/env"
# opencode
export PATH=/home/blackdovah/.opencode/bin:$PATH

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/blackdovah/Work and Education/bootdev/CICD/google-cloud-cli-linux-x86_64/google-cloud-sdk/path.zsh.inc' ]; then . '/home/blackdovah/Work and Education/bootdev/CICD/google-cloud-cli-linux-x86_64/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/blackdovah/Work and Education/bootdev/CICD/google-cloud-cli-linux-x86_64/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/blackdovah/Work and Education/bootdev/CICD/google-cloud-cli-linux-x86_64/google-cloud-sdk/completion.zsh.inc'; fi


# SDKMAN (with existence check)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
