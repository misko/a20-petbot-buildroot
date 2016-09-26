#!/bin/bash

pushd /tmp/

mkdir -p ./emmc
# Set default values
EMMC_DEVICE=${EMMC:="/dev/mmcblk0"}

mkfs.ext4 $EMMC_DEVICE"p"2 > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "FAILED MKFS"
	exit 1
fi

#copy to the two system partitions
echo "COPYING OVER SYSTEM (1)"
mount $EMMC_DEVICE"p2" ./emmc
if [ $? -ne 0 ]; then
	echo "FAILED TO MOUNT"
	exit 1
fi

rsync -a --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / ./emmc
if [ $? -ne 0 ]; then
	echo "FAILED TO RSYNC"
	exit 1
fi

rm ./emmc/recovery_partition
sync
if [ $? -ne 0 ]; then
	echo "FAILED TO SYNC"
	exit 1
fi

umount ./emmc

exit 0
