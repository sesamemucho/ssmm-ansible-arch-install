#!/bin/bash
set -e
set -x
IMG_SIZE="4GiB"
IMG_NAME="gubber.dat"

fallocate -l ${IMG_SIZE} ${IMG_NAME}

loopdev=$(losetup --show -f ${IMG_NAME})

sfdisk $loopdev <<EOF
size=      122880, type=c
,
EOF
partprobe $loopdev

losetup -D
loopdev=$(losetup -P --show -f ${IMG_NAME})

mkfs.vfat ${loopdev}p1
mkfs.ext4 ${loopdev}p2
