# My custom lock service
CopyFile /etc/systemd/system/lock.service '' will will
CreateLink /etc/systemd/system/hibernate.target.wants/lock.service /etc/systemd/system/lock.service
CreateLink /etc/systemd/system/suspend.target.wants/lock.service /etc/systemd/system/lock.service

# NetworkManager
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service

# TLP
CreateLink /etc/systemd/system/multi-user.target.wants/tlp.service /usr/lib/systemd/system/tlp.service
CreateLink /etc/systemd/system/sleep.target.wants/tlp-sleep.service /usr/lib/systemd/system/tlp-sleep.service

# NTP
CreateLink /etc/systemd/system/multi-user.target.wants/ntpd.service /usr/lib/systemd/system/ntpd.service
