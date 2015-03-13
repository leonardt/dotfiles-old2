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

source /usr/local/bin/virtualenvwrapper.sh

export PATH=/usr/local/cuda/bin:$PATH
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
