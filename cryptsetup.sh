#!/mmc/bin/bash

set -e
set -x

mkdir -p /mmc/src/cryptsetup
SRC=/mmc/src/cryptsetup
MAKE="make -j`nproc`"

######## ####################################################################
# LVM2 # ####################################################################
######## ####################################################################

mkdir $SRC/lvm2 && cd $SRC/lvm2
wget ftp://sources.redhat.com/pub/lvm2/releases/LVM2.2.02.168.tgz
tar zxvf LVM2.2.02.168.tgz
cd LVM2.2.02.168

./configure \
--prefix=/mmc \
--sysconfdir=/mmc/etc \
--enable-static_link \
--disable-nls

$MAKE LIBS="-lm -lpthread -luuid"
make install

######## ####################################################################
# POPT # ####################################################################
######## ####################################################################

mkdir $SRC/popt && cd $SRC/popt
wget http://rpm5.org/files/popt/popt-1.16.tar.gz
tar zxvf popt-1.16.tar.gz
cd popt-1.16

./configure \
--prefix=/mmc \
--enable-static \
--disable-shared \
--disable-nls

$MAKE
make install

################ ############################################################
# LIBGPG-ERROR # ############################################################
################ ############################################################

mkdir $SRC/libgpg-error && cd $SRC/libgpg-error
wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.27.tar.bz2
tar xvjf libgpg-error-1.27.tar.bz2
cd libgpg-error-1.27

./configure \
--prefix=/mmc \
--enable-static \
--disable-shared \
--disable-nls

$MAKE
make install

########## ##################################################################
# GCRYPT # ##################################################################
########## ##################################################################

mkdir $SRC/gcrypt && cd $SRC/gcrypt
wget https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.7.6.tar.bz2
tar xvjf libgcrypt-1.7.6.tar.bz2
cd libgcrypt-1.7.6

./configure \
--prefix=/mmc \
--enable-static \
--disable-shared

$MAKE
make install

############## ##############################################################
# CRYPTSETUP # ##############################################################
############## ##############################################################

mkdir $SRC/cryptsetup && cd $SRC/cryptsetup
wget https://www.kernel.org/pub/linux/utils/cryptsetup/v1.7/cryptsetup-1.7.3.tar.xz
tar xvJf cryptsetup-1.7.3.tar.xz
cd cryptsetup-1.7.3

LIBS="-lpthread" \
./configure \
--prefix=/mmc \
--disable-kernel_crypto \
--disable-nls \
--enable-static \
--disable-shared \
--enable-static-cryptsetup

$MAKE
