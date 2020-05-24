# TODO: fix "resume" parameter to work for multiple machines
CopyFileTo "/etc/default/grub-$HOSTNAME" /etc/default/grub

CopyFile /etc/pacman.conf
CopyFile /etc/pacman.d/mirrorlist
CopyFile /etc/sudoers
CopyFile /etc/tlp.conf
