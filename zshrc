fpath=( "$HOME/dotfiles/zsh" $fpath )

autoload -U promptinit && promptinit
prompt pure

source $HOME/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

export PATH=/usr/local/cuda/bin:$PATH
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -d /usr/local/share/zsh-completions ] && fpath=(/usr/local/share/zsh-completions $fpath)

# Completion
autoload -Uz compinit
compinit

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

export C_INCLUDE_PATH=/opt/intel/lib:$C_INCLUDE_PATH

[ -f $HOME/.zshrc.ext ] && source ~/.zshrc.ext

export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

export PATH="$HOME/.cask/bin:$PATH"
