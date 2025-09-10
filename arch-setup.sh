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
