#!/bin/sh

#load module
#modprobe gpio_sunxi

#set pin to input
#echo 9 > /sys/class/gpio/export

snd_dir=/a20-petbot-firmware/sounds/
play() {
	fn=$1
	aplay ${snd_dir}/$fn
}

echo TEST VERSION V`grep VERSION /config/pb_config | awk '{print $2}'`

#run the tests
#LED test
echo TEST LED In_progress...
play start_led.wav
test_led blink 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
	play passed_led.wav
	echo TEST LED PASS
else
	play failed_led.wav
	echo TEST LED FAIL
fi

#motor test
echo TEST MOTOR In_progress...
play start_motor.wav
test_send_cookie 10 1 5 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
	play passed_motor.wav
	echo TEST MOTOR PASS
else
	play failed_motor.wav
	echo TEST MOTOR FAIL
fi

#wifi test
echo TEST WIFI In_progress...
play start_wifi.wav
# do wifi test here
ifconfig wlan0 up
wifi=`iwlist scan | grep ESSID`
wifix=`iwlist scan | grep "Signal level" | tr "=" ' ' | awk '{print $5}' | sort -k 1,1n | head -n 1`
if [ -z "$wifi" ]  ; then
	play failed_wifi.wav
	echo TEST WIFI FAIL
else
	play passed_wifi.wav
	echo TEST WIFI PASS_${wifix}db
fi

echo TEST SIGNAL `iwconfig | grep Signal | sed 's@.*Signal.*level=\(.*\) \(dBm\) .*@\1\2@g'`

#microphone test
echo TEST MICROPHONE In_progress...
play start_microphone.wav
#do microphone test
w1=`arecord -d 1 | md5sum`
w2=`arecord -d 1 | md5sum`
if [ "$w1" = "$w2" ] ; then
	play failed_microphone.wav
	echo TEST MICROPHONE FAIL
else
	play passed_microphone.wav
	echo TEST MICROPHONE PASS
fi


echo TEST MICROPHONE PASS/PLAYBACK
arecord -d 3 > /tmp/out.wav
aplay /tmp/out.wav
rm /tmp/out.wav
echo TEST MICROPHONE PASS

