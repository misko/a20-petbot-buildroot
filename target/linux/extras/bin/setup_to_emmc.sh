#!/bin/bash

pushd /tmp/

# Set default values
MMC_DEVICE=${MMC:="/dev/mmcblk0"}
EMMC_DEVICE=${EMMC:="/dev/mmcblk1"}

if [ ! -e "${MMC_DEVICE}" ] ; then
	exit 1
fi

if [ ! -e "${EMMC_DEVICE}" ] ; then
	exit 1
fi

function format() {
	dev=$1
	fstype=$2
	echo "FORMAT $dev - $fstype"
	mkfs.$fstype $dev > /dev/null 2>&1
	if [ $? -ne 0 ]; then 
		echo "FAILED FORMAT"
		exit 1	
	fi	
}

function xmount() {
	dev=$1
	mp=$2
	opt=$3
	if [ -z $opt ] ; then
		mount $1 $2
	else
		mount -o $opt $1 $2
	fi
	if [ $? -ne 0 ]; then
		echo "FAILED MOUNT!"
		exit 1
	fi
}

function xdd() {
	src=$1
	dev=$2
	time dd bs=1M if=$src of=$dev
	time resize2fs $dev
}

function xcopy() {
	src=$1
	dev=$2
	opt=$3
	mkdir -p ./emmc
	echo "COPYING OVER SYSTEM $dev"
	xmount $dev ./emmc $opt
	time rsync -a --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/rootfs.ext4"} $src ./emmc
	if [ $? -ne 0 ] ; then
		echo "FAILED TO RSYNC"
		exit 1
	fi
	sync
	if [ $? -ne 0 ]; then 
		echo "FAILED TO SYNC"
		exit 1
	fi
	umount ./emmc
}

echo "Erasing eMMC partition table..."
for p in $(ls $EMMC_DEVICE*); do
    umount $p > /dev/null 2>&1
done
dd if="/dev/zero" of=$EMMC_DEVICE bs=1M count=20 > /dev/null 2>&1

# Copy bootloader
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
+1000M
w
__EOF__

echo "SETUP partition 3 - ${EMMC_DEVICE}p3"
end=`fdisk -l $EMMC_DEVICE | tail -n 1  | awk '{print $3+1}'`
            fdisk $EMMC_DEVICE > /dev/null 2>&1 << __EOF__
n
p
3
$end
+1000M
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

+50M
w
__EOF__
	    
echo "SETUP partition 6 - ${EMMC_DEVICE}p6"
	    fdisk $EMMC_DEVICE > /dev/null 2>&1 << __EOF__
n

+1000M
w
__EOF__

#format the EMMC device
format $EMMC_DEVICE"p"1 "vfat"
format $EMMC_DEVICE"p"2 "ext4"
format $EMMC_DEVICE"p"3 "ext4"
format $EMMC_DEVICE"p"5 "ext4"
format $EMMC_DEVICE"p"6 "ext4"

mkdir -p ./emmc
mkdir -p ./emmc2
mkdir -p ./mmc
mkdir -p ./config

# copy over the boot
xmount $MMC_DEVICE"p1" ./mmc
xcopy "./mmc/" $EMMC_DEVICE"p1" noatime
umount ./mmc

#echo "COPY ROOT TO p2"
#xcopy "/" $EMMC_DEVICE"p2" 
#
#echo "COPY p2 to p3"
#xmount $EMMC_DEVICE"p2" ./emmc2
#xcopy "./emmc2/" $EMMC_DEVICE"p3" noatime,discard
#touch ./emmc2/recovery_partition
#umount ./emmc2

echo "COPY ROOT TO p2 - dd"
xdd /rootfs.ext4 $EMMC_DEVICE"p2" 
xdd /rootfs.ext4 $EMMC_DEVICE"p3" 
xmount $EMMC_DEVICE"p3" ./emmc2

xcopy "./emmc2/a20-petbot-firmware/config/" $EMMC_DEVICE"p5" noatime
touch ./emmc2/recovery_partition
umount ./emmc2

exit 0 # success on exit
