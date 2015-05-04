fpath=( "$HOME/dotfiles/zsh" $fpath )

source "${HOME}/dotfiles/zsh/zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save"

  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/virtualenvwrapper
  zgen oh-my-zsh plugins/sudo

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-completions src
  zgen load sindresorhus/pure

  zgen save
fi


# autoload -U colors && colors
# [[ "$SSH_CONNECTION" != '' ]] && prompt_username=' %n@%m'
# # ─
# function precmd {
#     [[ "$SSH_CONNECTION" != '' ]] && print `whoami`@`hostname -s`
#     print " "`pwd`
# }
# PROMPT=" %{$fg[cyan]%}%(! %{$fg[red]%} )─%{$fg[cyan]%}%(1j %{$fg[green]%} )─%{$fg[cyan]%}%(?  %{$fg[red]%})─%{$reset_color%} "
# RPROMPT="%{$fg[green]%}$prompt_username"
# autoload -U promptinit
# promptinit
# autoload -U promptinit && promptinit
# prompt pure

# source $HOME/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ $(uname -s) == 'Darwin' ]]; then
  alias ls='ls -G' # Mac OSX support
else
  alias ls='ls --color' #I like color
fi

export PATH=/usr/texbin:"$PATH"
export WORKON_HOME=$HOME/.envs

if [ -z $HOME/.envs ]; then
  mkdir $HOME/.envs
fi

[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -d /usr/local/share/zsh-completions ] && fpath=(/usr/local/share/zsh-completions $fpath)

# Completion
autoload -Uz compinit
compinit
setopt completealiases


setopt HIST_IGNORE_DUPS  # Ignore duplicate lines in history
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

export EDITOR='vim'

# git
alias gst='git status'
alias gpl='git pull'
alias gps='git push'
alias gco='git checkout'
alias gc='git commit'
alias ga='git add'


export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export NVIM_TUI_ENABLE_TRUE_COLOR=1

[ -f $HOME/.zshrc.ext ] && source ~/.zshrc.ext

export PATH=/usr/local/cuda/bin:$PATH
export C_INCLUDE_PATH=/opt/intel/lib:$C_INCLUDE_PATH
export PATH="$HOME/.cask/bin:$PATH"

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
