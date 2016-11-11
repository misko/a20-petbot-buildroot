#!/bin/bash

killall wpa_supplicant
killall dhclient

wpa_passphrase TECATE4 bobsburgers > /tmp/wifi.conf
ifconfig wlan0 down
ifconfig wlan0 up
wpa_supplicant -Dwext -iwlan0 -c /tmp/wifi.conf &
dhclient wlan0 &
