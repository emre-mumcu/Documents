



diskutil list

diskutil unmountDisk /dev/diskX

sudo dd if=Fedora-Workstation.iso of=/dev/rdiskX bs=1m status=progress conv=fsync

diskutil eject /dev/diskX