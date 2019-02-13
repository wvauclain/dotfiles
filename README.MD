# Dotfiles

Here are my current dotfiles. This is for my laptop, which is currently running bspwm on Arch Linux.

## Installation

My dotfiles are created using [GNU Stow](https://www.gnu.org/software/stow/).
Stow creates symlinks from this directory to the proper place in the home directory.
This directory should be a child of `~` for stow to work properly.
To install the dotfiles for a specific program, run `stow $PROGNAME`.
