# Adapted from https://github.com/resin-os/resin-fsl-arm/blob/master/layers/meta-resin-fsl-arm/recipes-core/images/resin-image.bbappend
# with info from https://github.com/resin-os/meta-resin/blob/master/meta-resin-common/classes/image_types_resin.bbclass

IMAGE_FSTYPES_append_imx7d-pico = " resinos-img"

RESIN_IMAGE_BOOTLOADER_imx7d-pico = "u-boot"

# Copy zImage and imx7d-pico.dtb to the FAT boot partition
RESIN_BOOT_PARTITION_FILES_imx7d-pico = " \
  ${KERNEL_IMAGETYPE}-${MACHINE}.bin:/${KERNEL_IMAGETYPE} \
  zImage-imx7d-pico.dtb:/imx7d-pico.dtb \
"

# Copy u-boot to image offset 0x00000400
IMAGE_CMD_resinos-img_append_imx7d-pico () {
    dd if=${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.imx of=${RESIN_RAW_IMG} conv=notrunc seek=2 bs=512
}

