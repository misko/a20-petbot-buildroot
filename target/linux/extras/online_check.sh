#!/bin/sh

snd_dir=/a20-petbot-firmware/sounds/
play() {
	fn=$1
	aplay ${snd_dir}/$fn
}

echo ONLINE CHECK 

if [ -e /dev/mmcblk1 ]; then
	echo "STARTING COPY FROM SD CARD"
	play flashing_petbot.wav 
	setup_to_emmc.sh
	if [ $? -eq 0 ]; then 
		test_led blink 6 &
		play flashing_complete.wav &
		sleep 3 
	else
		play flashing_failed.wav
	fi
	halt
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
