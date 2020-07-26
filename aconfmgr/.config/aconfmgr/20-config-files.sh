CopyFileTo "/etc/default/grub-$HOSTNAME" /etc/default/grub

CopyFile /etc/bash.bashrc
CopyFile /etc/issue
CopyFile /etc/makepkg.conf
CopyFile /etc/pacman.conf
CopyFile /etc/pacman.d/mirrorlist
CopyFile /etc/sudoers
CopyFile /etc/xdg/user-dirs.defaults
CopyFile /etc/zsh/zshenv
