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
wget http://http.debian.net/debian/pool/main/l/lvm2/lvm2_2.02.142.orig.tar.xz
tar xvJf lvm2_2.02.142.orig.tar.xz
cd lvm2-2.02.142

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
wget https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.21.tar.bz2
tar xvjf libgpg-error-1.21.tar.bz2
cd libgpg-error-1.21

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
wget https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.6.4.tar.bz2
tar xvjf libgcrypt-1.6.4.tar.bz2
cd libgcrypt-1.6.4

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
wget https://www.kernel.org/pub/linux/utils/cryptsetup/v1.7/cryptsetup-1.7.0.tar.xz
tar xvJf cryptsetup-1.7.0.tar.xz
cd cryptsetup-1.7.0

LIBS="-lpthread" \
./configure \
--prefix=/mmc \
--disable-kernel_crypto \
--disable-nls \
--enable-static \
--disable-shared \
--enable-static-cryptsetup

$MAKE
