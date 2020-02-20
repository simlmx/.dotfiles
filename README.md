dotfiles
========

My dot files!

installation
============

    # a few dependencies
    sudo apt-get install vim exuberant-ctags
    curl https://pyenv.run | bash

    # cloning
    cd ~
    git clone git@github.com:simlmx/.dotfiles.git
    cd .dotfiles
    git submodule update --init --recursive
    
    # proper install
    ./install_dotfiles all

    # Don't forget to update the .gitconfig file, it contains placeholders
