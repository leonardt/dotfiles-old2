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
