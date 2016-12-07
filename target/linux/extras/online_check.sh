#!/bin/sh

snd_dir=/a20-petbot-firmware/sounds/
play() {
	fn=$1
	aplay ${snd_dir}/$fn
}

echo ONLINE CHECK 

if [ -e /dev/mmcblk1 ]; then
	#echo "IN DEV MODE NO FLASH"
	#exit
	echo "STARTING COPY FROM SD CARD"
	play flashing_petbot.wav &
	setup_to_emmc.sh
	sync
	if [ $? -eq 0 ]; then 
		test_led blink 6 &
		play flashing_complete.wav &
		sleep 3 
	else
		play flashing_failed.wav
	fi
	halt
else
	echo "TESTING UPDATE AND CONFIG PARTITIONS"
	mkdir -p /update
	mkdir -p /config
	#try to mount and format if necessary
	mount /dev/mmcblk0p5 /config
	if [ $? -ne 0 ]; then
		echo "FAILED TO MOUNT CONFIG, formatting..."
		mkfs.ext4 /dev/mmcblk0p5
	fi
	mount /dev/mmcblk0p6 /update
	if [ $? -ne 0 ]; then
		echo "FAILED TO MOUNT UPDATE, formatting..."
		mkfs.ext4 /dev/mmcblk0p6
	fi
		
fi

if [ -e /recovery_partition ]; then 
	echo "STARTING RECOVERY"
	play recovery_start.wav 
	recover_from_emmc.sh	
	if [ $? -eq 0 ]; then
		test_led blink 6 &
		play recovery_complete.wav &
		sleep 3
		reboot
	else
		play recovery_failed.wav
		halt
	fi
fi




