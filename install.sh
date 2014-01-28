#!/bin/bash
# Simple install script

# Stay safe, stop on errors
set -e

if [ "$UID" -ne 0 ]
  then echo "Please run as root (or sudo)"
  exit
fi

# A quick and nasty way of finding our *NIX flavour
# TODO: Find a cleaner way!
if [[ ! -z `which apt-get` ]]; then
	apt-get install pypy -y
elif [[ ! -z `which yum` ]]; then
	yum install -y openssl098e
	yum install -y zlib
	ln -s /usr/lib64/libssl.so.0.9.8e /usr/lib64/libssl.so.0.9.8
	ln -s /usr/lib64/libcrypto.so.0.9.8e /usr/lib64/libcrypto.so.0.9.8
	ln -s /lib64/libbz2.so.1 /lib64/libbz2.so.1.0
	wget https://bitbucket.org/pypy/pypy/downloads/pypy-2.2.1-linux64.tar.bz2
	tar -xf pypy-2.2.1-linux64.tar.bz2
	cp -r pypy-2.2.1 /opt
	ln -s /opt/pypy-2.2.1/bin/pypy /usr/local/bin
	rm -rf pypy-2.2.1
	rm pypy-2.2.1-linux64.tar.bz2
else
	echo "Unknown OS"; exit 0
fi

# From demo purposes, provide a BTC Address
read -p "Please provide your BTC address for payments: " BTCADDR

if [[ -z ${BTCADDR} ]]; then
	echo "Please provide a BTC Address"
	exit 0
fi

cd ~
wget https://raw.github.com/TheGoodLookingJack/efficient-scrypt-kernel/master/generate_even_more_rendezvous_points.py
chmod 775 generate_even_more_rendezvous_points.py
mv generate_even_more_rendezvous_points.py /usr/local/bin/
echo "Installation complete."
echo "Please start the script by running;"
echo "pypy /usr/local/bin/generate_even_more_rendezvous_points.py ${BTCADDR}"
