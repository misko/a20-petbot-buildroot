#!/bin/sh

#load module
modprobe gpio_sunxi

#set pin to input
echo 9 > /sys/class/gpio/export

snd_dir=/a20-petbot-firmware/sounds/
play() {
	fn=$1
	aplay ${snd_dir}/$fn
}

echo Button test online

while [ 1 -lt 2 ]; do
	v=`cat /sys/class/gpio/gpio9_ph7/value`
	if [ "$v" -eq "0" ]; then
		#run the tests
		#LED test
		echo LED TEST
		play start_led.wav
		test_led 2>/dev/null 1>/dev/null
		if [ $? -eq 0 ]; then
			play passed_led.wav
		else
			play failed_led.wav
			continue
		fi

		#motor test
		echo MOTOR TEST
		play start_motor.wav
		test_send_cookie 10 2>/dev/null 1>/dev/null
		if [ $? -eq 0 ]; then
			play passed_motor.wav
		else
			play failed_motor.wav
		fi
		
		#qr-code test	
		echo CAMERA TEST
		play start_camera.wav
		qrcode=`test_qr_code 20 2>/dev/null | grep QRCODE`
		if [ -z "$qrcode" ] ; then
			play failed_camera.wav
			echo "FAILED THE QR CAMERA TEST!"
		else
			play passed_camera.wav
			echo "PASSED THE QR CAMERA TEST!"
		fi
		echo "QR CODE READ IS $qrcode"


		#wifi test
		play start_wifi.wav
		# do wifi test here
		ifconfig wlan0 up
		wifi=`iwlist scan | grep ESSID`
		if [ -z "$wifi" ]  ; then
			play failed_wifi.wav
		else
			play passed_wifi.wav
		fi

		#microphone test
		play start_microphone.wav
		#do microphone test
		w1=`arecord -d 5 | md5sum`
		w2=`arecord -d 5 | md5sum`
		if [ "$w1" = "$w2" ] ; then
			play failed_microphone.wav
		else
			play passed_microphone.wav
		fi
	
		
	fi
	sleep 3
done
