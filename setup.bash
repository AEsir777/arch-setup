#!/bin/bash

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

# yay
sudo pacman -Syu
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si

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

# chinese keyboard
sudo pacman -S fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-chinese-addons manjaro-asian-input-support-fcitx5
sudo vim /etc/environment
# GTK_IM_MODULE=fcitx
# QT_IM_MODULE=fcitx
# XMODIFIERS=@im=fcitx

# TLP for battery performance
# sudo pacman -S TLP
# systemctl enable tlp.service

# oh my bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
echo ~/.bashrc-* >> ~/.bashrc
rm ~/.bashrc-*

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
sudo pacman -S extra/texlive-latex extra/texlive-latexextra extra/texlive-plaingeneric
sudo texconfig rehash
sudo mktexlsr

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
yay docker cmake

# Nvdia driver
sudo pacman -S linux69-nvidia nvidia-utils lib32-nvidia-utils nvidia-settings

# download wechat linux beta version
# downlaod amd64_login from 
# https://github.com/lovechoudoufu/wechat_for_linux/releases 
yay deptab
sudo deptap -u ~/Downloads/wechat-beta_1.0.0.238_amd64_login.deb
sudo debtap -u ~/Downloads/wechat-beta*
sudo pacman -U wechat*.pkg*
































