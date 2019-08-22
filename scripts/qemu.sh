#!/bin/bash
#set -x


#    -bios ${BUILD}/qemu-4.0.0/roms/u-boot/u-boot.bin \
#    -kernel ${DISTRO}/Image \
#    -initrd ${DISTRO}/ramdisk.cpio.gz \
#    -append "root=/dev/ram rdinit=/init console=ttyAMA0"

#    -bios ${DISTRO}/qemu-u-boot.bin \
#    -drive if=none,file=${DISTRO}/qemu-boot.img,media=disk,id=boot \
#    -device virtio-blk-device,drive=boot

${QEMU}/aarch64-softmmu/qemu-system-aarch64 \
    -monitor none -serial stdio -no-reboot -nographic \
    -machine virt,virtualization=true,gic-version=3 \
    -cpu cortex-a57 -smp 4 \
    -m 2G,slots=2,maxmem=4G \
    -bios ${DISTRO}/qemu-u-boot.bin \
    -drive if=none,file=${DISTRO}/qemu-boot.img,id=hd0 \
    -device virtio-blk-device,drive=hd0
