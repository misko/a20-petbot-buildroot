#!/bin/bash

pushd /tmp/

# Set default values
MMC_DEVICE=${MMC:="/dev/mmcblk0"}
EMMC_DEVICE=${EMMC:="/dev/mmcblk1"}

# Make sure partition table on eMMC is not mounted and erased
print_with_color "Erasing eMMC partition table..."
for p in $(ls $EMMC_DEVICE*); do
    umount $p > /dev/null 2>&1
done
dd if="/dev/zero" of=$EMMC_DEVICE bs=1M count=20 > /dev/null 2>&1

# Copy bootloader
print_with_color "Copying bootloader..."
dd if=$MMC_DEVICE of=$EMMC_DEVICE skip=16 seek=16 count=2032 > /dev/null 2>&1

#setup the target partitions
echo "SETUP partition 1 - ${EMMC_DEVICE}p1"
            fdisk $EMMC_DEVICE > /dev/null 2>&1 << __EOF__
n
p
1
33
544
t
1
b
w
__EOF__

echo "SETUP partition 2 - ${EMMC_DEVICE}p2"
end=`fdisk -l $EMMC_DEVICE | tail -n 1  | awk '{print $3+1}'`
            fdisk $EMMC_DEVICE > /dev/null 2>&1 << __EOF__
n
p
2
$end
+2000M
w
__EOF__

echo "SETUP partition 3 - ${EMMC_DEVICE}p3"
end=`fdisk -l $EMMC_DEVICE | tail -n 1  | awk '{print $3+1}'`
            fdisk $EMMC_DEVICE > /dev/null 2>&1 << __EOF__
n
p
3
$end
+2000M
w
__EOF__

echo "SETUP partition 4 - extended - ${EMMC_DEVICE}p4"
end=`fdisk -l $EMMC_DEVICE | tail -n 1  | awk '{print $3+1}'`
	    fdisk $EMMC_DEVICE > /dev/null 2>&1 << __EOF__
n
e
$end

w
__EOF__
	    
echo "SETUP partition 5 - ${EMMC_DEVICE}p5"
	    fdisk $EMMC_DEVICE > /dev/null 2>&1 << __EOF__
n

+100M
w
__EOF__
	    
echo "SETUP partition 6 - ${EMMC_DEVICE}p6"
	    fdisk $EMMC_DEVICE > /dev/null 2>&1 << __EOF__
n

+2000M
w
__EOF__
echo "FORMAT partition 1 - ${EMMC_DEVICE}p1 - vfat"
mkfs.vfat $EMMC_DEVICE"p"1 > /dev/null 2>&1
echo "FORMAT partition 2 - ${EMMC_DEVICE}p1 - ext4"
mkfs.ext4 $EMMC_DEVICE"p"2 > /dev/null 2>&1
echo "FORMAT partition 3 - ${EMMC_DEVICE}p1 - ext4"
mkfs.ext4 $EMMC_DEVICE"p"3 > /dev/null 2>&1
echo "FORMAT partition 5 - ${EMMC_DEVICE}p1 - ext4"
mkfs.ext4 $EMMC_DEVICE"p"5 > /dev/null 2>&1
echo "FORMAT partition 6 - ${EMMC_DEVICE}p1 - ext4"
mkfs.ext4 $EMMC_DEVICE"p"6 > /dev/null 2>&1


mkdir ./emmc
mkdir ./mmc
#copy to the boot partition
echo "COPYING OVER BOOT PARTITION"
mount $MMC_DEVICE"p1" ./mmc
mount $EMMC_DEVICE"p1" ./emmc
rsync -a --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} ./mmc/ ./emmc
sync
umount ./mmc
umount ./emmc

#copy to the two system partitions
echo "COPYING OVER SYSTEM (1)"
mount $EMMC_DEVICE"p2" ./emmc
rsync -a --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / ./emmc
sync
umount ./emmc
echo "COPYING OVER SYSTEM (2)"
mount $EMMC_DEVICE"p3" ./emmc
rsync -a --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / ./emmc
touch ./emmc/recovery_partition
sync
umount ./emmc

