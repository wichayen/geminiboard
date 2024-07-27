chmod -R 777 uImage
mount /dev/mmcblk0p1 /mnt/FAT/
cp -rf ~/uImage /mnt/FAT/
sync
umount /mnt/FAT