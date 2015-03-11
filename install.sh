git submodule update --init

ln -s $PWD/zshrc $HOME/.zshrc
ln -s "$PWD/zsh/pure/pure.zsh" $PWD/zsh/prompt_pure_setup
ln -s $PWD/vimrc $HOME/.vimrc
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
