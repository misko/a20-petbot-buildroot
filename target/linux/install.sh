#!/bin/sh
root=$1
chmod g-w ${root}/root
chmod 700 ${root}/root/.ssh
rm -rf ${root}/usr/share/gtk-doc
rm -f ${root}/bin/CedarXPlayerTest
rm -f ${root}/root/test1.mp4
rm -rf ${root}/a20-petbot-firmware/networks/history
rm -fr ${root}/a20-petbot-firmware/nodist
rm -f ${root}/a20-petbot-firmware/config/device_sid
rm -f ${root}/a20-petbot-firmware/config/petbotid
rm -f ${root}/a20-petbot-firmware/config/wifi.conf
rm -f ${root}/a20-petbot-firmware/config.log
rm -f ${root}/a20-petbot-firmware/config.status
rm -f ${root}/a20-petbot-firmware/.*swp
rm -f ${root}/a20-petbot-firmware/Makefile
chmod 600 ${root}/a20-petbot-firmware/update_key

rm -f ${root}/root/.bash_history
echo ulimit -c unlimited >> ${root}/root/.bashrc
echo ulimit -c unlimited >> ${root}/root/.bash_profile

rm -f ${root}/etc/dhcp/dhclient.conf 
ln -s /config/dhclient.conf /etc/dhcp/dhclient.conf

#sed -i 's@root::@root:$1$cXBljHI.$l5yZaoPXhCYnDXUbwsS3L0:@g' ${root}/etc/shadow
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
