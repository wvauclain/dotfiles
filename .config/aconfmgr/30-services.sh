# My custom lock service
CopyFile /etc/systemd/system/lock.service '' will will
CreateLink /etc/systemd/system/hibernate.target.wants/lock.service /etc/systemd/system/lock.service
CreateLink /etc/systemd/system/suspend.target.wants/lock.service /etc/systemd/system/lock.service

# NetworkManager
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service

# NTP
CreateLink /etc/systemd/system/dbus-org.freedesktop.timesync1.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service

# XDG user directories
CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service

# Docker
CreateLink /etc/systemd/system/multi-user.target.wants/docker.service /usr/lib/systemd/system/docker.service
CopyFile /etc/pacman.conf

# SSHD
if [ "$(hostname)" = novastorm ]; then
    CreateLink /etc/systemd/system/multi-user.target.wants/sshd.service /usr/lib/systemd/system/sshd.service
fi
