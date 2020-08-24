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

------------------------------------------------------------------------------------------------------------------------------------------------------------
Arch Installation
fdisk /dev/sdX
:t :1 # EFI partition
mkfs.ext4 /dev/sdaX # root
mkfs.fat -F32 /dev/sdaX # boot
mount /dev/sdaX /mnt
mkdir /mnt/boot
mount /dev/sdaX /mnt/boot
vim /etc/pacnman.d/mirrorlist
pacstrap /mnt base base-devel linux linux-firmware 
vim networkmanager grub efibootmgr os-prober bash-completion
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash
systemctl enable NetworkManager
mount /dev/sdaX (EFI Win) /mnt2
os-prober
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
vim /etc/locale.gen
locale-gen
echo “LANG=en_GB.UTF-8” > /etc/locale.conf
ln -sf /usr/share/zoneinfo/...  /etc/localtime
passwd
vim /etc/hostname
exit
umount -R /mnt

Adding user
useradd -m -g wheel {name}
vim /etc/sudoers

Yay install

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ && echo keyserver pool.sks-keyservers.net >>  ~/.gnupg/gpg.conf

Graphical environment
sudo pacman -S xorg xorg-xinit xorg-server

Time
timedatectl set-local-rtc 1 --adjust-system-clock

Fonts
noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-opensans 

pacman -S connman-runit connman-gtk (or cmst for Qt-based DEs)
ln -s /etc/runit/sv/connmand /etc/runit/runsvdir/default

Remove unused packages
pacman -Rns $(pacman -Qtdq)

Remove everything but essential packages
pacman -D --asdeps $(pacman -Qqe)
pacman -D --asexplicit base base-devel linux linux-firmware nvim networkmanager firefox grub efibootmgr os-prober zsh zsh-syntax-highlighting

Search history with arrows 
bindkey "^[[A" history-beginning-search-backward 
bindkey "^[[B" history-beginning-search-forward 

Discover Backend
packagekit-qt5 

Directories in /home
xdg-user-dirs-update

Previews in Dolphin
ffmpegthumbs

Change GDM Theme
sudo cp -av /usr/share/gnome-shell/gnome-shell-theme.gresource{,~}

GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | sed "s/'//g")
cd /usr/share/themes/${GTK_THEME}/gnome-shell
sudo glib-compile-resources --target=/usr/share/gnome-shell/gnome-shell-theme.gresource gnome-shell-theme.gresource.xml

sudo mv -v /usr/share/gnome-shell/gnome-shell-theme.gresource{~,}

Import Key
gpg --keyserver keys.gnupg.net --recv-keys

Hide application
/usr/share/applications/app-name.desktopNoDisplay=true




Remap Keyboard
setxkbmap -layout us,ru -option grp:alt_shift_toggle -option caps:swapescape

/etc/X11/xorg.conf.d/00-keyboard.conf
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us,ru"
        Option "XkbOptions" "grp:alt_shift_toggle"
EndSection


Suckless
git clone git://git.suckless.org/{dwm/dwmstatus/st/dmenu}

Add dwm as an entry

sudo vim /usr/share/xsessions/dwm.desktop

[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=dwm window manager
Exec=/usr/local/bin/dwm
Type=Application







