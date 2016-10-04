#!/bin/sh
arm-linux-gst-launch-1.0 videotestsrc ! videoconvert ! cedarxh264enc ! rtph264pay pt=96 ! udpsink host=$1 port=$2
