# Core packages
AddPackage base # Minimal package set to define a basic Arch Linux installation
AddPackage efibootmgr # Linux user-space application to modify the EFI Boot Manager
AddPackage fwupd # Simple daemon to allow session software to update firmware
AddPackage grub # GNU GRand Unified Bootloader (2)
AddPackage linux # The Linux kernel and modules
AddPackage linux-firmware # Firmware files for Linux
AddPackage man-db # A utility for reading man pages
AddPackage man-pages # Linux man pages
AddPackage networkmanager # Network connection manager and user applications
AddPackage ntp # Network Time Protocol reference implementation
AddPackage openssh # Premier connectivity tool for remote login with the SSH protocol
AddPackage posix-user-portability # metapackage providing the POSIX shell and utilities
AddPackageGroup base-devel

# System-specific drivers
if [ "$HOSTNAME" = howlback ]; then
    AddPackage acpilight # a backward-compatible xbacklight replacement based on ACPI
    AddPackage intel-ucode # Microcode update files for Intel CPUs
    AddPackage mesa # An open-source implementation of the OpenGL specification
    AddPackage vulkan-intel # Intel's Vulkan mesa driver
    AddPackage xf86-video-vesa # X.org vesa video driver
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
AddPackage cmake # A cross-platform open-source make system
AddPackage git # the fast distributed version control system
AddPackage go # Core compiler tools for the Go programming language
AddPackage go-tools # Developer tools for the Go programming language
AddPackage llvm # Collection of modular and reusable compiler and toolchain technologies
AddPackage nodejs # Evented I/O for V8 javascript
AddPackage npm # A package manager for javascript
AddPackage pandoc # Conversion between markup formats
AddPackage python-dbus # Python bindings for DBUS
AddPackage python-pip # The PyPA recommended tool for installing Python packages
AddPackage rust # Systems programming language focused on safety, speed and concurrency
AddPackage shellcheck # Shell script analysis tool
AddPackage yarn # Fast, reliable, and secure dependency management

# Editors
AddPackage code # The Open Source build of Visual Studio Code (vscode) editor
AddPackage emacs # The extensible, customizable, self-documenting real-time display editor
AddPackage neovim # Fork of Vim aiming to improve user experience, plugins, and GUIs
AddPackage vim # Vi Improved, a highly configurable, improved version of the vi text editor

# PER
AddPackage bazel # Correct, reproducible, and fast builds for everyone
AddPackage moserial # Clean, friendly GTK+-based serial terminal for the GNOME desktop
AddPackage python-protobuf # Python 3 bindings for Google Protocol Buffers
AddPackage python-pyserial # Multiplatform Serial Port Module for Python

# QMK
AddPackage arm-none-eabi-binutils # A set of programs to assemble and manipulate binary and object files for the ARM EABI (bare-metal) target
AddPackage arm-none-eabi-gcc # The GNU Compiler Collection - cross compiler for ARM EABI (bare-metal) target
AddPackage arm-none-eabi-newlib # A C standard library implementation intended for use on embedded systems (ARM bare metal)
AddPackage avr-binutils # A set of programs to assemble and manipulate binary and object files for the AVR architecture
AddPackage avr-gcc # The GNU AVR Compiler Collection
AddPackage avr-libc # The C runtime library for the AVR family of microcontrollers
AddPackage avrdude # Download/upload/manipulate the ROM and EEPROM contents of AVR microcontrollers
AddPackage dfu-programmer # Programmer for Atmel chips with a USB bootloader
AddPackage dfu-util # Tool intended to download and upload firmware using DFU protocol to devices connected over USB

# X.org
AddPackage xorg-server # Xorg X server
AddPackage xorg-setxkbmap # Set the keyboard using the X Keyboard Extension
AddPackage xorg-xev # Print contents of X events
AddPackage xorg-xinit # X.Org initialisation program
AddPackage xorg-xinput # Small commandline tool to configure devices
AddPackage xorg-xmodmap # Utility for modifying keymaps and button mappings
AddPackage xorg-xrandr # Primitive command line interface to RandR extension
AddPackage xorg-xrdb # X server resource database utility
AddPackage xorg-xset # User preference utility for X

# WM
AddPackage bspwm # Tiling window manager based on binary space partitioning
AddPackage dunst # Customizable and lightweight notification-daemon
AddPackage feh # Fast and light imlib2-based image viewer
AddPackage i3lock # Improved screenlocker based upon XCB and PAM
AddPackage picom # X compositor that may fix tearing issues
AddPackage rofi # A window switcher, application launcher and dmenu replacement
AddPackage scrot # Simple command-line screenshot utility for X
AddPackage sxhkd # Simple X hotkey daemon
AddPackage --foreign polybar # A fast and easy-to-use status bar

# GUI Apps
AddPackage alacritty # A cross-platform, GPU-accelerated terminal emulator
AddPackage arandr # Provide a simple visual front end for XRandR 1.2.
AddPackage caja # File manager for the MATE desktop
AddPackage calibre # Ebook management application (python2 build)
AddPackage chromium # A web browser built for speed, simplicity, and security
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage gimp # GNU Image Manipulation Program
AddPackage gvfs-afc # Virtual filesystem implementation for GIO (AFC backend; Apple mobile devices)
AddPackage gvfs-mtp # Virtual filesystem implementation for GIO (MTP backend; Android, media player)
AddPackage gvfs-smb # Virtual filesystem implementation for GIO (SMB/CIFS backend; Windows client)
AddPackage keepassxc # Cross-platform community-driven port of Keepass password manager
AddPackage libreoffice-fresh # LibreOffice branch which contains new features and program enhancements
AddPackage mate-system-monitor # A system monitor for MATE
AddPackage sxiv # Simple X Image Viewer
AddPackage syncthing # Open Source Continuous Replication / Cluster Synchronization Thing
AddPackage vlc # Multi-platform MPEG, VCD/DVD, and DivX player
AddPackage zathura # Minimalistic document viewer
AddPackage zathura-pdf-mupdf # PDF support for Zathura (MuPDF backend) (Supports PDF, ePub, and OpenXPS)
AddPackage --foreign qdirstat # Qt-based directory statistics (KDirStat/K4DirStat without any KDE - from the original KDirStat author)
AddPackage --foreign slack-desktop # Slack Desktop (Beta) for Linux

# 3D Printing
AddPackage cura # A software solution for 3D printing aimed at RepRaps and the Ultimaker.

# LaTeX
AddPackage texlive-core # TeX Live core distribution
AddPackage texlive-latexextra # TeX Live - Large collection of add-on packages for LaTeX
AddPackage texlive-science # TeX Live - Typesetting for mathematics, natural and computer sciences

# Pulseaudio
AddPackage ponymix # CLI PulseAudio Volume Control
AddPackage pulseaudio # A featureful, general-purpose sound server
AddPackage pulsemixer # CLI and curses mixer for pulseaudio

# CLI Utilities
AddPackage aria2 # Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink
AddPackage bat # Cat clone with syntax highlighting and git integration
AddPackage fzf # Command-line fuzzy finder
AddPackage htop # Interactive process viewer
AddPackage pdftk # Command-line tool for working with PDFs
AddPackage ranger # Simple, vim-like file manager
AddPackage rclone # Sync files to and from Google Drive, S3, Swift, Cloudfiles, Dropbox and Google Cloud Storage
AddPackage ripgrep # A search tool that combines the usability of ag with the raw speed of grep
AddPackage rsync # A file transfer program to keep remote files in sync
AddPackage screen # Full-screen window manager that multiplexes a physical terminal
AddPackage stow # Manage installation of multiple softwares in the same directory tree
AddPackage the_silver_searcher # Code searching tool similar to Ack, but faster
AddPackage trash-cli # Command line trashcan (recycle bin) interface
AddPackage unzip # For extracting and viewing files in .zip archives
AddPackage wget # Network utility to retrieve files from the Web
AddPackage xclip # Command line interface to the X11 clipboard
AddPackage youtube-dl # A small command-line program to download videos from YouTube.com and a few more sites
AddPackage zsh # A very advanced and programmable command interpreter (shell) for UNIX
AddPackage zsh-completions # Additional completion definitions for Zsh
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign trizen # Trizen AUR Package Manager

# Fonts
AddPackage noto-fonts-cjk # Google Noto CJK fonts
AddPackage noto-fonts-emoji # Google Noto emoji fonts
AddPackage ttf-dejavu # Font family based on the Bitstream Vera Fonts with a wider range of characters
AddPackage --foreign nerd-fonts-iosevka # Patched Iosevka font from the nerd-fonts library

# Optional dependencies for added features
AddPackage highlight # Syntax highlighting for ranger and trizen

# System-specific apps and utilities
if [ "$HOSTNAME" = howlback ]; then
    # Install and enable tlp
    AddPackage tlp # Linux Advanced Power Management
    CopyFile /etc/tlp.conf
    CreateLink /etc/systemd/system/multi-user.target.wants/tlp.service /usr/lib/systemd/system/tlp.service
    CreateLink /etc/systemd/system/sleep.target.wants/tlp-sleep.service /usr/lib/systemd/system/tlp-sleep.service

    # Install batt
    which batt > /dev/null 2>&1 || (
        cd $(mktemp -d batt.XXX)
        wget "https://raw.githubusercontent.com/wvauclain/batt/master/PKGBUILD"
        makepkg -si PKGBUILD
    )
    IgnorePackage --foreign batt

elif [ "$HOSTNAME" = novastorm ]; then
    AddPackage dosbox # Emulator with builtin DOS for running DOS Games
    AddPackage handbrake # Multithreaded video transcoder
    AddPackage libdvdcss # Portable abstraction library for DVD decryption
    AddPackage sound-juicer # A lean and friendly audio CD extractor for GNOME
    AddPackage steam # Valve's digital software delivery system
    AddPackage --foreign makemkv # DVD and Blu-ray to MKV converter and network streamer
fi
