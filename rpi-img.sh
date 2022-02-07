#!/bin/bash
set -e

IMG_SIZE="14GiB"
IMG_NAME="/data/rpi-img/base-rpi.img"
# The 'ArchLinuxARM-rpi-aarch64-latest.tar.gz' is the only one I could
# get to work, for the RPi 3, at least.
ARCH_TGZ="/data/big/ArchLinuxARM-rpi-armv7-latest.tar.gz"
MNT_POINT="/mnt"

rm -f "${IMG_NAME}"
fallocate -l ${IMG_SIZE} ${IMG_NAME}

loopdev=$(losetup --show -f ${IMG_NAME})

sfdisk $loopdev <<EOF
size=      409600, type=c
,
EOF

partprobe $loopdev

loopdev=$(losetup -P --show -f ${IMG_NAME})

mkfs.vfat -F32 ${loopdev}p1
mkfs.ext4 ${loopdev}p2

mount ${loopdev}p2 ${MNT_POINT}
mkdir ${MNT_POINT}/boot
mount ${loopdev}p1 ${MNT_POINT}/boot

echo "Copying ArchLinux image to image file"
tar xpf "$ARCH_TGZ" -C ${MNT_POINT}

# Setup base IP config
cat <<EOF >"${MNT_POINT}/etc/netctl/eth0-static"
Description='Initial base config'
Interface=eth0
Connection=ethernet
IP=static
Address=('10.135.155.42/16')
EOF

sync
umount ${MNT_POINT}/boot
umount ${MNT_POINT}

losetup -D
