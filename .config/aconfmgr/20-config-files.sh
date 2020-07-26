# Copy the machine-specific grub file
CopyFileTo "/etc/default/grub-$HOSTNAME" /etc/default/grub

CopyFile /etc/bash.bashrc
CopyFile /etc/issue
CopyFile /etc/makepkg.conf
CopyFile /etc/pacman.conf
CopyFile /etc/pacman.d/mirrorlist
CopyFile /etc/sudoers
CopyFile /etc/xdg/user-dirs.defaults
CopyFile /etc/zsh/zshenv

# Neovim
InstallNVimPlugin() {
	CopyFileTo "/nvim/plugin/$1" "/usr/share/nvim/runtime/plugin/$1"
}
InstallNVimPlugin colorscheme.vim
InstallNVimPlugin statusline.vim
InstallNVimPlugin settings.vim

# Zsh
CopyFile /etc/zsh/zshrc
InstallZshPlugin() {
	CopyFileTo "/zsh/$1" "/etc/zsh/plugin/$1"
}
InstallZshPlugin git.zsh
InstallZshPlugin theme.zsh
