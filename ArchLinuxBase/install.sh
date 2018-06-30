#! /bin/bash

## Set password for root user
passwd

# System configuration, like hostname, locale, etc
echo ThinkPad > /etc/hostname
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
cat << EOF >> /etc/locale.gen
LANG=en_US.UTF-8
EOF
locale-gen
cat << EOF >> /etc/locale.conf
LANG=en_US.UTF-8
EOF

# install packages
pacman -S - < ./pkgList.txt

# Configuring user nilesh
useradd -m -G wheel nilesh
usermod -c "Nilesh" nilesh
passwd nilesh
cat << EOF >> /etc/sudoer

%wheel ALL=(ALL) ALL

EOF

bash addYaourat

# Enable TLP
systemctl enable tlp.service tlp-sleep.service

# Enable NetworkManager
systemctl enable lightdm.service NetworkManager.service NetworkManager-wait-online.service

# Create a service for slock to support locking while using suspend
cat << EOF >> /etc/systemd/system/slock@.service
[Unit]
Description=Lock X session using slock for user %i
Before=sleep.target

[Service]
User=%i
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xset dpms force suspend
ExecStart=/usr/bin/slock

[Install]
WantedBy=sleep.target
EOF

# Enable lock while suspending system using slock.
systemctl enable slock@nilesh.service

# Install grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
