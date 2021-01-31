# Copy the machine-specific grub file
CopyFileTo "/etc/default/grub-$HOSTNAME" /etc/default/grub

CopyFile /etc/bash.bashrc
CopyFile /etc/issue
CopyFile /etc/makepkg.conf
CopyFile /etc/pacman.conf
CopyFile /etc/pam.d/login
CopyFile /etc/pacman.d/mirrorlist
CopyFile /etc/sudoers
CopyFile /etc/xdg/user-dirs.defaults
CopyFile /etc/zsh/zshenv
CopyFile /etc/nsswitch.conf

# Zsh
CopyFile /etc/zsh/zshrc
InstallZshPlugin() {
	CopyFileTo "/zsh/$1" "/etc/zsh/plugin/$1"
}
InstallZshPlugin git.zsh
InstallZshPlugin theme.zsh
