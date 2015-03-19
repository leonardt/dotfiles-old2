curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
cd emacs.d && cask init

ln -s $PWD/emacs.d $HOME/.emacs.d
