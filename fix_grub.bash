# https://wiki.manjaro.org/index.php/GRUB/Restore_the_GRUB_Bootloader
su                                                                                                                                                  ✔ 
manjaro-chroot -a 

# Reinstall grub
 grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck 


# Update the grub configuration
 grub-mkconfig -o /boot/grub/grub.cfg 



# EFI grub install messagesEFI variables are not supported on this system.
# Verify the existance of an EFI system partition
 lsblk -o PATH,PTTYPE,PARTTYPE,FSTYPE,PARTTYPENAME 


# Verify the efi filesystem is loaded
 ls /sys/firmware/efi 


# Exit chroot
 exit 


# Try loading the efi filesystem
 modprobe efivarfs 


# Re-enter chroot
 manjaro-chroot /mnt /bin/bash 


# Then mount the efi filesystem
 mount -t efivarfs efivarfs /sys/firmware/efi/efivars 


# Verify the efi filesystem is loaded
 ls /sys/firmware/efi 
