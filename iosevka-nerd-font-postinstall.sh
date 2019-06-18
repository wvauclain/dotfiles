( fc-list | grep "Iosevka Nerd" > /dev/null && ! $UPDATE ) && exit 0

if [ "$1" = "pacman" ]; then
    trizen -S --noconfirm nerd-fonts-iosevka
else
    mkdir -p tmp
    cd tmp
    git clone https://github.com/ryanoasis/nerd-fonts.git
    cd nerd-fonts
    ./install.sh Iosevka
fi
