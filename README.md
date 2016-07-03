dotfiles
========

My dot files!

installation
============

    # a few dependencies
    sudo apt-get install vim exuberant-ctags

    # cloning
    cd ~
    git clone git@github.com:simlmx/.dotfiles.git
    cd .dotfiles
    git submodule update --init
    
    # proper install
    ./install_dotfiles all
