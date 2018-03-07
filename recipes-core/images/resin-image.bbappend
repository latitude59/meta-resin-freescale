# modified from https://github.com/resin-os/resin-raspberrypi/blob/master/layers/meta-resin-raspberrypi/recipes-core/images/resin-image.bbappend
IMAGE_FSTYPES_append_imx7d-pico = " resinos-img"

RESIN_BOOT_PARTITION_FILES_imx7d-pico = " \
    ${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin:/${SDIMG_KERNELIMAGE} \
    "

