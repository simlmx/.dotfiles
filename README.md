dotfiles
========

My dot files!

installation
============

    # cloning
    cd ~
    git clone git@github.com:simlmx/.dotfiles.git
    cd .dotfiles
    git submodule update --init --recursive
    
    # proper install (note this assumes `python` is actually python 2!)
    ./install_dotfiles all

    # Don't forget to update the .gitconfig file, it contains placeholders
