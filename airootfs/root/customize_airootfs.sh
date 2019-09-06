#!/bin/bash

set -e -u
# defined by archiso
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service
systemctl set-default graphical.target

#Make a live user
  id -u liveuser &>/dev/null || useradd -m "liveuser" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" 
  passwd -d liveuser
#keep eye on floppy it will soon be gone

# enable DM
  systemctl enable gdm.service
# if we want to change to lightdm
# systemctl enable lightdm.service

#Enable Sudo
  chmod 750 /etc/sudoers.d
  chmod 440 /etc/sudoers.d/g_wheel
  chown -R root /etc/sudoers.d
  echo "Enabled Sudo"

#Setup Su
    sed -i /etc/pam.d/su -e 's/auth      sufficient  pam_wheel.so trust use_uid/#auth        sufficient  pam_wheel.so trust use_uid/'
#Try to do sudo again
    chmod -R 755 /etc/sudoers.d


#enable Networks
systemctl enable NetworkManager.service
