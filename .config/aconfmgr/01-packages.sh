# Core packages
AddPackage base # Minimal package set to define a basic Arch Linux installation
AddPackage efibootmgr # Linux user-space application to modify the EFI Boot Manager
AddPackage fwupd # Simple daemon to allow session software to update firmware
AddPackage grub # GNU GRand Unified Bootloader (2)
AddPackage linux # The Linux kernel and modules
AddPackage linux-firmware # Firmware files for Linux
AddPackage linux-headers # Headers and scripts for building modules for the Linux kernel
AddPackage man-db # A utility for reading man pages
AddPackage man-pages # Linux man pages
AddPackage networkmanager # Network connection manager and user applications
AddPackage nss-mdns # glibc plugin providing host name resolution via mDNS
AddPackage openssh # Premier connectivity tool for remote login with the SSH protocol
AddPackage unzip # For extracting and viewing files in .zip archives
AddPackage wget # Network utility to retrieve files from the Web
AddPackage zsh # A very advanced and programmable command interpreter (shell) for UNIX
AddPackage zsh-completions # Additional completion definitions for Zsh
AddPackageGroup base-devel

# System-specific drivers
if [ "$HOSTNAME" = howlback ]; then
    AddPackage acpilight # a backward-compatible xbacklight replacement based on ACPI
    AddPackage intel-ucode # Microcode update files for Intel CPUs
    AddPackage mesa # An open-source implementation of the OpenGL specification
    AddPackage vulkan-intel # Intel's Vulkan mesa driver
elif [ "$HOSTNAME" = novastorm ]; then
    AddPackage amd-ucode # Microcode update files for AMD CPUs
    AddPackage lib32-nvidia-utils # NVIDIA drivers utilities (32-bit)
    AddPackage nvidia # NVIDIA drivers for linux
    AddPackage nvidia-settings # Tool for configuring the NVIDIA graphics driver
    AddPackage nvidia-utils # NVIDIA drivers utilities

    CopyFile /etc/X11/xorg.conf.d/20-nvidia.conf
else
    echo "error: add microcode and graphics drivers for system $HOSTNAME" >&2
    exit 1
fi

# Development
AddPackage clang # C language family frontend for LLVM
AddPackage gdb # The GNU Debugger
AddPackage git # the fast distributed version control system
AddPackage go # Core compiler tools for the Go programming language
AddPackage go-tools # Developer tools for the Go programming language
AddPackage nodejs # Evented I/O for V8 javascript
AddPackage npm # A package manager for javascript
AddPackage rust # Systems programming language focused on safety, speed and concurrency
AddPackage valgrind # Tool to help find memory-management problems in programs
AddPackage yarn # Fast, reliable, and secure dependency management
AddPackage --foreign pandoc-bin # Pandoc - executable only, without 750MB Haskell depends/makedepends
AddPackage --foreign shellcheck-bin # Shell script analysis tool (binary release)

# Vim
AddPackage neovim # Fork of Vim aiming to improve user experience, plugins, and GUIs
AddPackage python-pynvim # Python client for Neovim
AddPackage python-black # Uncompromising Python code formatter
AddPackage --foreign neovim-symlinks # Runs neovim if vi or vim is called
AddPackage --foreign vim-gruvbox-community # gruvbox color scheme for vim
AddPackage tmux # A terminal multiplexer

# PER
AddPackage bazel # Correct, reproducible, and fast builds for everyone
AddPackage doxygen # Documentation system for C++, C, Java, IDL and PHP
AddPackage moserial # Clean, friendly GTK+-based serial terminal for the GNOME desktop
AddPackage python-protobuf # Python 3 bindings for Google Protocol Buffers
AddPackage python-pyserial # Multiplatform Serial Port Module for Python
AddPackage arm-none-eabi-gdb # The GNU Debugger for the ARM EABI (bare-metal) target
AddPackage --foreign jlink-software-and-documentation # Segger JLink software & documentation pack for Linux

# QMK
# AddPackage arm-none-eabi-binutils # A set of programs to assemble and manipulate binary and object files for the ARM EABI (bare-metal) target
# AddPackage arm-none-eabi-gcc # The GNU Compiler Collection - cross compiler for ARM EABI (bare-metal) target
# AddPackage arm-none-eabi-newlib # A C standard library implementation intended for use on embedded systems (ARM bare metal)
# AddPackage avr-binutils # A set of programs to assemble and manipulate binary and object files for the AVR architecture
# AddPackage avr-gcc # The GNU AVR Compiler Collection
# AddPackage avr-libc # The C runtime library for the AVR family of microcontrollers
# AddPackage avrdude # Download/upload/manipulate the ROM and EEPROM contents of AVR microcontrollers
# AddPackage dfu-programmer # Programmer for Atmel chips with a USB bootloader
# AddPackage dfu-util # Tool intended to download and upload firmware using DFU protocol to devices connected over USB

# X.org
AddPackage arandr # Provide a simple visual front end for XRandR 1.2.
AddPackage xorg-server # Xorg X server
AddPackage xorg-xinit # X.Org initialisation program

# WM
AddPackage bspwm # Tiling window manager based on binary space partitioning
AddPackage dunst # Customizable and lightweight notification-daemon
AddPackage feh # Fast and light imlib2-based image viewer
AddPackage gnome-keyring # Stores passwords and encryption keys
AddPackage i3lock # Improved screenlocker based upon XCB and PAM
AddPackage picom # X compositor that may fix tearing issues
AddPackage rofi # A window switcher, application launcher and dmenu replacement
AddPackage scrot # Simple command-line screenshot utility for X
AddPackage sxhkd # Simple X hotkey daemon
AddPackage xdg-user-dirs # Manage user directories like ~/Desktop and ~/Music
AddPackage xdo # Utility for performing actions on windows in X
AddPackage --foreign polybar # A fast and easy-to-use status bar

# GUI Apps
AddPackage alacritty # A cross-platform, GPU-accelerated terminal emulator
AddPackage calibre # Ebook management application (python2 build)
AddPackage chromium # A web browser built for speed, simplicity, and security
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage gimp # GNU Image Manipulation Program
AddPackage keepassxc # Cross-platform community-driven port of Keepass password manager
AddPackage libreoffice-fresh # LibreOffice branch which contains new features and program enhancements
AddPackage mpv # a free, open source, and cross-platform media player
AddPackage nextcloud-client # Nextcloud desktop client
AddPackage steam # Valve's digital software delivery system
AddPackage sxiv # Simple X Image Viewer
AddPackage zathura # Minimalistic document viewer
AddPackage zathura-pdf-mupdf # PDF support for Zathura (MuPDF backend) (Supports PDF, ePub, and OpenXPS)
AddPackage --foreign slack-desktop # Slack Desktop (Beta) for Linux
AddPackage --foreign zoom # Zoom, #1 Video Conferencing and Web Conferencing Service

# LaTeX
AddPackage biber # A Unicode-capable BibTeX replacement for biblatex users
AddPackage texlive-core # TeX Live core distribution
AddPackage texlive-fontsextra # TeX Live - all sorts of extra fonts
AddPackage texlive-latexextra # TeX Live - Large collection of add-on packages for LaTeX
AddPackage texlive-science # TeX Live - Typesetting for mathematics, natural and computer sciences

# Pulseaudio
AddPackage ponymix # CLI PulseAudio Volume Control
AddPackage pulseaudio # A featureful, general-purpose sound server
AddPackage pulsemixer # CLI and curses mixer for pulseaudio

# CLI Utilities
AddPackage aria2 # Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink
AddPackage bat # Cat clone with syntax highlighting and git integration
AddPackage docker # Pack, ship and run any application as a lightweight container
AddPackage fd # Simple, fast and user-friendly alternative to find
AddPackage fzf # Command-line fuzzy finder
AddPackage jq # Command-line JSON processor
AddPackage moreutils # A growing collection of the unix tools that nobody thought to write thirty years ago
AddPackage ncdu # Disk usage analyzer with an ncurses interface
AddPackage nmap # Utility for network discovery and security auditing
AddPackage pacman-contrib # Contributed scripts and tools for pacman systems
AddPackage plan9port # Ports of applications from Plan 9
AddPackage python-eyed3 # A Python module and program for processing information about mp3 files
AddPackage qpdf # QPDF
AddPackage ripgrep # A search tool that combines the usability of ag with the raw speed of grep
AddPackage rsync # A fast and versatile file copying tool for remote and local files
AddPackage shfmt # Format shell programs
AddPackage trash-cli # Command line trashcan (recycle bin) interface
AddPackage ueberzug # Command line util which allows to display images in combination with X11
AddPackage xclip # Command line interface to the X11 clipboard
AddPackage youtube-dl # A small command-line program to download videos from YouTube.com and a few more sites
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign bottom # A cross-platform graphical process/system monitor with a customizable interface and a multitude of features.
AddPackage --foreign lf # A terminal file manager inspred by ranger written in Go
AddPackage --foreign ripgrep-all # rga
AddPackage --foreign trizen # Trizen AUR Package Manager

# Ranger
AddPackage ranger # Simple, vim-like file manager
AddPackage ghostscript # An interpreter for the PostScript language
AddPackage imagemagick # An image viewing/manipulation program
AddPackage mediainfo # Supplies technical and tag information about a video or audio file (CLI interface)

# Fonts
AddPackage noto-fonts # Google Noto TTF fonts
AddPackage noto-fonts-cjk # Google Noto CJK fonts
AddPackage noto-fonts-emoji # Google Noto emoji fonts
AddPackage ttf-dejavu # Font family based on the Bitstream Vera Fonts with a wider range of characters
AddPackage --foreign nerd-fonts-iosevka # Patched Iosevka font from the nerd-fonts library

# Needed to connect to the Penn wifi
# AddPackage python-dbus # Python bindings for DBUS

# System-specific apps and utilities
if [ "$HOSTNAME" = howlback ]; then
    # Install and enable tlp
    AddPackage tlp # Linux Advanced Power Management
    CopyFile /etc/tlp.conf
    CreateLink /etc/systemd/system/multi-user.target.wants/tlp.service /usr/lib/systemd/system/tlp.service
    CreateLink /etc/systemd/system/sleep.target.wants/tlp-sleep.service /usr/lib/systemd/system/tlp-sleep.service

    # Install and enable powertop
    AddPackage powertop # A tool to diagnose issues with power consumption and power management
    CreateLink /etc/systemd/system/multi-user.target.wants/powertop.service /etc/systemd/system/powertop.service
    CopyFile /etc/systemd/system/powertop.service

    # Install batt
    AddPKGBUILD batt

elif [ "$HOSTNAME" = novastorm ]; then
    AddPackage cura # A software solution for 3D printing aimed at RepRaps and the Ultimaker.
    AddPackage dosbox # Emulator with builtin DOS for running DOS Games
    AddPackage handbrake # Multithreaded video transcoder
    AddPackage libdvdcss # Portable abstraction library for DVD decryption
    AddPackage jre8-openjdk # OpenJDK Java 8 full runtime environment (needed for minecraft)
    AddPackage sound-juicer # A lean and friendly audio CD extractor for GNOME
    AddPackage --foreign chocolate-doom # Historically-accurate Doom, Heretic, Hexen, and Strife ports.
    AddPackage --foreign makemkv # DVD and Blu-ray to MKV converter and network streamer
    AddPackage --foreign vmware-workstation # The industry standard for running multiple operating systems as virtual machines on a single Linux PC.


    AddPackage inkscape # Professional vector graphics editor
    AddPackage virtualbox # Powerful x86 virtualization for enterprise as well as home use
    AddPackage virtualbox-guest-iso # The official VirtualBox Guest Additions ISO image
    AddPackage virtualbox-host-modules-arch # Virtualbox host kernel modules for Arch Kernel
    AddPackage --foreign v4l2ucp # A universal control panel for Video for Linux Two (V4L2) devices
fi
