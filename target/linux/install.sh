#!/bin/sh
root=$1
#set it up so things boot
grep '::sysinit:/a20-petbot-firmware/scripts/load_all.sh' ${root}/etc/inittab
if [ $? -ne 0 ]; then
	echo '::sysinit:/a20-petbot-firmware/scripts/load_all.sh' >> ${root}/etc/inittab
fi
grep '::sysinit:/button_test.sh &' ${root}/etc/inittab
if [ $? -ne 0 ]; then
	echo '::sysinit:/button_test.sh &' >> ${root}/etc/inittab
fi
