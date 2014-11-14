#!/bin/sh
set -e

### Todo: Add uninstall portion, or make this packageable or something.

INSTALL_DIR=/usr/sbin
CONFIG_DIR=/etc/pax-flags

if [ `whoami` != "root" ];then
	echo "Whoa buddy, you need to run this with sudo.\n\nExiting..\n";
	exit 4;
fi

echo "This will automatically install ubuntu-pax-flags, check that ruby is installed and update fstab to support xattr."

echo "Continue? [Y/n] "
read cont
case $cont in
	[Yy]* )break;;
	[Nn]* )echo "Exiting";exit;;
esac

apt-get install attr ruby -y
# Update fstab to support user_xattr, original fstab is backed up as /etc/fstab.old
sudo sed -i.old -r '/[ \t]\/[ \t]/{s/(ext4[\t ]*)([^\t ]*)/\1\2,user_xattr/}' /etc/fstab

mkdir $CONFIG_DIR
cp ./linux-pax-flags.* $INSTALL_DIR
cp *.conf $CONFIG_DIR
cp 99-grsec /etc/apt/apt.conf.d/

#install man file for linux-pax-flags and pax-flags
cp linux-pax-flags.8 /usr/share/man/man8/linux-pax-flags.8
ln -s /usr/share/man/man8/linux-pax-flags.8 /usr/share/man/man8/pax-flags.8
