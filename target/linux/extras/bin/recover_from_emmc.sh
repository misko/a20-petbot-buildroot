#!/bin/bash

pushd /tmp/

# Set default values
EMMC_DEVICE=${EMMC:="/dev/mmcblk1"}

echo "FORMAT partition 2 - ${EMMC_DEVICE}p1 - ext4"
mkfs.ext4 $EMMC_DEVICE"p"2 > /dev/null 2>&1

#copy to the two system partitions
echo "COPYING OVER SYSTEM (1)"
mount $EMMC_DEVICE"p2" ./emmc
rsync -a --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / ./emmc
rm ./emmc/recovery_partition
sync
umount ./emmc

