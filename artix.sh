#!/bin/bash

PKGS="base base-devel linux linux-firmware runit elogind-runit connman-runit nvim grub efibootmgr os-prober bash-completion git xorg xorg-server xorg-xinit firefox noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-opensans ttf-hack"

ln -s /etc/runit/sv/connmand /etc/runit/runsvdir/default
pacman -S $PKGS --needed 
mkdir /mnt/winboot
mount /dev/sdc1 /mnt/winboot
os-prober
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
#vim /etc/locale.gen
#locale-gen
echo “LANG=en_GB.UTF-8” > /etc/locale.conf
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
echo artix > /etc/hostname
useradd -m -g wheel dm
cd /home/dm
mkdir .gnupg
cp /etc/pacman.d/gnupg/gpg.conf .gnupg/ && echo keyserver pool.sks-keyservers.net >> .gnupg/gpg.conf
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm yay

git clone git://git.suckless.org/st
cd st && make; sudo make install

git clone git://git.suckless.org/dwm/
cd ../dwm && make; sudo make install

git clone git://git.suckless.org/dmenu
cd ../dmenu && make; sudo make install

git clone git://git.suckless.org/dwm/dwmstatus
cd ../dwmstatus && make; sudo make install







