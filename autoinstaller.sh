#! /bin/bash

if [ "$ROOT" = "" ]
then
    echo "Please set \$ROOT to the gentoo-linux install directory first."
    exit
fi

. ${ROOT}/etc/rc.d/config/functions
. ${ROOT}/etc/rc.d/config/runlevels
. $1

  cp $1 ${ROOT}/var/db/pkg/install.config

if [ -z "$NODEV" ] ; then
  einfo "Now setting up $OSNAME..."
  einfo "Creating device nodes (this takes a minute or so)..."
  cd ${ROOT}/dev
  ${ROOT}/usr/sbin/MAKEDEV generic-i386
  ${ROOT}/usr/sbin/MAKEDEV sg
  ${ROOT}/usr/sbin/MAKEDEV scd
  ${ROOT}/usr/sbin/MAKEDEV rtc
fi
echo
einfo "Setting osname and architecture"
cp ${ROOT}/etc/rc.d/config/runlevels ${ROOT}/etc/rc.d/config/runlevels.orig
sed -e "s:##OSNAME##:$OSNAME:" -e "s:##ARCH##:$ARCH:" \
	${ROOT}/etc/rc.d/config/runlevels.orig > ${ROOT}/etc/rc.d/config/runlevels
echo "OSNAME: $OSNAME"
echo "ARCH: $ARCH"
echo
einfo "Now, we are getting ${ROOT}/etc/fstab set up for your root and swap partitions..."
cp ${ROOT}/etc/fstab ${ROOT}/etc/fstab.orig


echo "Root partition in /dev/$MYROOTPART"
echo "Swap partition in /dev/$MYSWAPPART"

sed -e "s/#ROOT#/${MYROOTPART}/" -e "s/#SWAP#/${MYSWAPPART}/" ${ROOT}/etc/fstab.orig > ${ROOT}/etc/fstab

einfo "Generating library links and cache..."
ldconfig -r ${ROOT}

case "$GMT" in
  n|N|No|no)
	echo "Your BIOS clock is set to localtime"
 	;;
  y|Y|Yes|yes)
	echo "Your BIOS clock is set to GMT"
	mv ${ROOT}/etc/rc.d/config/basic ${ROOT}/etc/rc.d/config/basic.bak
	sed -e "s/GMT=no/GMT=yes/" ${ROOT}/etc/rc.d/config/basic.bak > ${ROOT}/etc/rc.d/config/basic
	rm ${ROOT}/etc/rc.d/config/basic.bak
esac


echo "Keymap: $keymap"
mv ${ROOT}/etc/rc.d/config/basic ${ROOT}/etc/rc.d/config/basic.bak
sed -e "s/KEYMAP=.*/KEYMAP=\"$keymap\"/" ${ROOT}/etc/rc.d/config/basic.bak > ${ROOT}/etc/rc.d/config/basic
mv ${ROOT}/etc/rc.d/config/basic ${ROOT}/etc/rc.d/config/basic.bak
sed -e "s/TIMED=.*/TIMED=\"$timed\"/" ${ROOT}/etc/rc.d/config/basic.bak > ${ROOT}/etc/rc.d/config/basic


myzone="${ROOT}/usr/share/zoneinfo/$timezone"
echo "Timezone: $timezone"


cp ${myzone##${ROOT}} ${ROOT}/etc/localtime

echo "Hostname: $hostname"

echo "$hostname" > ${ROOT}/etc/hostname
echo -n "domain " > ${ROOT}/etc/resolv.conf
echo "$hostname" | cut -f2- -d. >> ${ROOT}/etc/resolv.conf
echo "127.0.0.1 localhost ${hostname%%.*} ${hostname}" >> ${ROOT}/etc/hosts

echo "nameserver $nameserver" >> ${ROOT}/etc/resolv.conf

if [ -n $eth0 ] ; then
  cp ${ROOT}/etc/rc.d/config/modules ${ROOT}/etc/rc.d/config/modules.orig
  sed -e "s/\#eth0/$eth0/" ${ROOT}/etc/rc.d/config/modules.orig > ${ROOT}/etc/rc.d/config/modules
  sed -e "s/IPNUM=.*/IPNUM=$eth0_ip/" -e "s/BCAST=.*/BCAST=$eth0_bcast/" \
      -e "s/NMASK=.*/NMASK=$eth0_mask/" -e "s/NETWK=.*/NETWK=$eth0_net/" \
      -e "s/GTWAY=.*/GTWAY=$eth0_gw/" \
	${ROOT}/etc/rc.d/config/OFF_inet.eth0 > ${ROOT}/etc/rc.d/config/inet.eth0
fi

${ROOT}/etc/rc.d/init.d/initscripts-install









