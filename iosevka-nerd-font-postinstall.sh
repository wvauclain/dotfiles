if [ "$1" = "pacman" ]; then
    trizen -S nerd-fonts-iosevka
else
    mkdir -p tmp
    cd tmp
    git clone https://github.com/ryanoasis/nerd-fonts.git
    cd nerd-fonts
    ./install.sh Iosevka
fi
