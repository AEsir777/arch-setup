#!/bin/bash

# disable sudo
sudo visudo
# add kebing ALL=(ALL:ALL) NOPASSWD: ALL


# start tools
pamac build google-chrome
sudo pacman -S tmux nodejs-lts-iron asusctl supergfxctl rog-control-center vim
pamac build visual-studio-code-bin

# using supergfxctl for GPU passthrough VFIO
# /etc/supergfxd.conf
# {
# "vfio_enable": true,
# "hotplug_type": "Asus"
# }

# sound
sudo pacman -S sof-firmware alsa-ucm-conf mosh
sudo echo "options snd-intel-dspcfg dsp_driver=1" >>  /etc/modprobe.d/soundfix.conf
# audio quality
# turn the sensitive of audio down

# display
xrandr --dpi 150x150
# x11 applications
# -forcedesktopscaling 1.25
# verify which version x11 is running
ps -o user= -C Xorg

# install wayland
sudo yay plasma-workspace 
# fix fcitx5 in wayland
# Set virtual keyboard as fcitx5
# https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
unset QT_IM_MODULE
unset SDL_IM_MODULE
unset GTK_IM_MODULE

# yay
sudo pacman -Syu
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si
yay testdisk

# razor
yay -S polychromatic
yay openrazer-driver-dkms
sudo pacman -S linux-headers
sudo modprobe razerkbd
sudo gpasswd -a $USER plugdev
reboot
openrazer-daemon -Fv

# Open razer CLI
# sudo pacman -S python-setuptools
# git clone https://github.com/LoLei/razer-cli.git
# cd razer-cli
# sudo python setup.py install

# wechat - electron (not work for me)
# yay snapd
# sudo systemctl enable --now snapd.socket
# sudo systemctl enable --now snapd.socket
# sudo ln -s /var/lib/snapd/snap /snap
# yay wechat-uos-qt


# set up vimrc and tmux
ln -sf ~/linux-config/.tmux.conf ~/.tmux.conf
ln -sf ~/linux-config/.vimrc ~/.vimrc

# discord
sudo pacman -S discord
# update version
file $(which discord)
# edit /opt/discord/resources/build_info.json

# chinese keyboard
sudo pacman -S fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-chinese-addons manjaro-asian-input-support-fcitx5
sudo vim /etc/environment
# GTK_IM_MODULE=fcitx
# QT_IM_MODULE=fcitx
# XMODIFIERS=@im=fcitx

# performance
asusctl -c 80
# sudo pacman -S TLP
# systemctl enable tlp.service

# oh my bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
echo ~/.bashrc-* >> ~/.bashrc
rm ~/.bashrc-*

# oh my posh for theme
curl -s https://ohmyposh.dev/install.sh | bash -so
# configure ~/.bashrc
# eval "$(oh-my-posh init bash --config ~/linux-config/catppuccin_mocha.omp.json)"
# override oh my bash theme
exec bash


# fix discord update version
file $(which discord)
cd /opt/discord/Discord
sudo vim resources/build_info.json

# git config
git config --global user.email "lkb2438834817@gmail.com"
git config --global core.editor "vim"

# ssh keys
# download ssh keys from one drive
sudo pacman -S zip unzip
mkdir ~/.ssh
unzip ssh_keys.zip -d ~
mv ~/ssh_keys ~/.ssh
chmod -R 600 ~/.ssh/*

# vim latex bindings
sudo pacman -S zathura zathura-pdf-mupdf
sudo pacman -S extra/texlive-latex extra/texlive-latexextra extra/texlive-plaingeneric texlive-binextra
sudo texconfig rehash
sudo mktexlsr

# latex lsp
yay nodejs npm cmake
wget https://raw.githubusercontent.com/astoff/digestif/master/scripts/digestif -P ~/.local/bin
# :CocInstall coc-texlab
# C++
# :CocCommand clangd.install
# :CocInstall coc-clangd coc-json

# tmux copy
yay xsel

# install wechat
yay Wine
cd ${WINEPREFIX:-~/.wine}/drive_c/windows/Fonts && for i in /usr/share/fonts/**/*.{ttf,otf}; do ln -s "$i"; done
FREETYPE_PROPERTIES="truetype:interpreter-version=35"

# load chinese in wine
# download at https://pc.weixin.qq.com/?lang=en_US
wine ~/Downloads/WeChatSetup.exe
# copy all the fonts from windows to wine
scp k322liu@linux.student.cs.uwaterloo.ca:~/Fonts/* ~/.wine/drive_c/windows/Fonts/

sudo pacman -S winetricks kdialog
winetricks fakeChinese 
# install a bunch of fonts

# docker
yay docker docker-compose

# Nvidia driver
sudo pacman -S linux69-nvidia nvidia-utils lib32-nvidia-utils nvidia-settings
# Nvidia drm
sudo vim /etc/default/grub
# add nvidia-drm.modeset=1
# Early loading
sudo vim /etc/mkinitcpio.conf
# MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
# HOOKS=() line, find the word kms inside the parenthesis and remove it
sudo mkinitcpio -P

# download wechat linux beta version
# downlaod amd64_login from 
# https://github.com/lovechoudoufu/wechat_for_linux/releases 
yay deptab
sudo deptap -u ~/Downloads/wechat-beta_1.0.0.238_amd64_login.deb
sudo debtap -u ~/Downloads/wechat-beta*
sudo pacman -U wechat*.pkg*

# set up NTFS
pamac install ntfs-3g


###########################
# allow ssh
sudo pacman -S openssh
sudo systemctl status sshd.service
# set ssh configurations
sudo vim /etc/ssh/sshd_config
# change ListenAddress to private ip, Port, password disable and only allow key
# add ssh key in Authorized key
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
# cat pub key into it

# enable and run
sudo systemctl enable sshd.service 
sudo systemctl enable --now sshd
sshd -t # for debug


##########################
# set up server
# set up swap
sudo mkswap /dev/nvme0n1p4
sudo swapon /dev/nvme0n1p4
sudo bash -c "echo UUID=$(lsblk -no UUID /dev/nvme0n1p4) swap swap defaults 0 0 >> /etc/fstab"
mkinitcpio -P
sudo update-grub
sudo reboot

# change mount point for external drive
yay ntfs-3g
lsblk
sudo blkid /dev/sda2
sudo ntfs-3g /dev/sda2 /mnt/drive


# start docker service
sudo systemctl start docker
# plex docker image
mkdir docker
# plex docker file 
# https://hub.docker.com/r/linuxserver/plex 
# qbit torrent file
# https://hub.docker.com/r/linuxserver/qbittorrent
# sonarr
# https://hub.docker.com/r/linuxserver/sonarr
docker pull linuxserver/sonarr

# hibernation
# in /etc/deafult/grub add resume=UUID=<> to LINUX_DEFAULT
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo vim /etc/mkinitcpio.conf
# add resume in hooks after udev

# Configure ProntonVPN
sudo pacman -S wireguard-tools
# Download configure files
sudo move ~/Downloads/*.conf /etc/wireguard
# https://protonvpn.com/support/wireguard-manual-linux/ 

# Configure domain name
yay bind
# Host ssh server on Cloudflared
yay cloudflared
# https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/use-cases/ssh/ 

##################################
## other applications
yay musescore



















