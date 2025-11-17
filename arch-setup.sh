# Command that I use to setup arch


# Install Arch
# Rufus to burn the arch linux ISO onto the USB
# Boot from USB
# Choose Arch Linux install medium (x86_64, UEFI)

########################
# WIFI set up
iwctl
device list
station wlan
station wlan0 scan
station wlan0 get-networks

station wlan0 connect <Network name of the wifi>
# enter password
exit

sudo pacman -S less


##########################
# systemd-boot add Windows from another ESP partition
# https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface#UEFI_Shell
# https://wiki.archlinux.org/title/Systemd-boot#Installation_using_XBOOTLDR
sudo pacman -S edk2-shell
sudo cp /usr/share/edk2-shell/x64/Shell.efi /boot/shellx64.efi

# configure windows.conf entry
# sudo vim ./loader/entries/windows.conf
