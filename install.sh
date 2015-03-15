git submodule update --init

ln -s $PWD/zshrc $HOME/.zshrc
ln -s $PWD/zsh/pure/pure.zsh $PWD/zsh/prompt_pure_setup
ln -s $PWD/vimrc $HOME/.vimrc
# curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
