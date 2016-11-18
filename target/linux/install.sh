#!/bin/sh
root=$1
chmod g-w ${root}/root
chmod 700 ${root}/root/.ssh
rm -rf ${root}/usr/share/gtk-doc
rm -f ${root}/bin/CedarXPlayerTest
rm -f ${root}/root/test1.mp4
rm -rf ${root}/a20-petbot-firmware/networks/history
#rm -f ${root}/a20-petbot-firmware/update_key #copied in part of mkcmd.sh
#set it up so things boot
#grep '::sysinit:/a20-petbot-firmware/scripts/load_all.sh' ${root}/etc/inittab
#if [ $? -ne 0 ]; then
#	echo '::sysinit:/a20-petbot-firmware/scripts/load_all.sh' >> ${root}/etc/inittab
#fi
#grep '::sysinit:/button_test.sh &' ${root}/etc/inittab
#if [ $? -ne 0 ]; then
#	echo '::sysinit:/button_test.sh &' >> ${root}/etc/inittab
#fi
