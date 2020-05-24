# Ignore system-specific and automatically-generated files
IgnorePath '/boot/*'
IgnorePath /etc/.updated
IgnorePath /var/.updated
IgnorePath /etc/adjtime
IgnorePath '/etc/NetworkManager/*'
IgnorePath '/etc/ca-certificates/*'
IgnorePath '/etc/ssl/*'
IgnorePath '/var/lib/*'
IgnorePath '/usr/lib/*'
IgnorePath '/usr/lib32/*'
IgnorePath '/usr/share/*'
IgnorePath '/etc/pacman.d/gnupg/*'
IgnorePath '/var/db/sudo/*'
IgnorePath /etc/shells
IgnorePath /etc/fstab
IgnorePath /etc/hostname
IgnorePath /etc/hosts
IgnorePath /etc/ld.so.cache
IgnorePath /etc/machine-id
IgnorePath /etc/resolv.conf
IgnorePath '/etc/texmf/*'
IgnorePath /lost+found
IgnorePath '/etc/xml/catalog/*'
IgnorePath /etc/locale.conf
IgnorePath /etc/locale.gen
IgnorePath /etc/locale.gen.pacnew
IgnorePath /etc/localtime
IgnorePath /etc/os-release
IgnorePath /etc/.pwd.lock
IgnorePath /etc/arch-release
IgnorePath /etc/xml/catalog
IgnorePath /usr/bin/newgidmap
IgnorePath /usr/bin/newuidmap

# Ignore configs I don't care about
IgnorePath /etc/fuse.conf
IgnorePath /etc/security/limits.d/10-gcr.conf
IgnorePath /etc/mkinitcpio.conf
IgnorePath /etc/mkinitcpio.d/linux.preset
IgnorePath '/etc/udev/rules.d/*'

# Automatically installed services
IgnorePath /etc/systemd/system/multi-user.target.wants/remote-fs.target
IgnorePath /etc/systemd/system/getty.target.wants/getty@tty1.service
IgnorePath /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service
IgnorePath /etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service
IgnorePath '/etc/systemd/user/sockets.target.wants/*'

# Don't worry about logs
IgnorePath '/var/log/*'

# Ignore temporary directories
IgnorePath '/var/tmp/*'

# Don't sync private information
IgnorePath '/etc/ssh/*'
IgnorePath /etc/shadow
IgnorePath /etc/shadow-
IgnorePath /etc/passwd
IgnorePath /etc/passwd-
IgnorePath /etc/group
IgnorePath /etc/group-
IgnorePath /etc/gshadow
IgnorePath /etc/gshadow-

# Ignore paths that don't actually have system config
IgnorePath '/bulk/*'