curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
cd emacs.d && $HOME/.cask/bin/cask install

ln -s $PWD/emacs.d $HOME/.emacs.d
