#!/bin/sh
set -e

INSTALL_DIR=/usr/bin
CONFIG_DIR=/etc/pax-flags

if [ `whoami` != "root" ];then
	echo "Whoa buddy, you need to run this with sudo.\n\nExiting..\n";
	exit 4;
fi

echo "This will automatically install ubuntu-pax-flags and check that ruby is installed."

echo "Continue? [Y/n] "
