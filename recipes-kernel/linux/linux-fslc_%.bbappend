# modified from https://github.com/resin-os/resin-raspberrypi/blob/master/layers/meta-resin-raspberrypi/recipes-kernel/linux/linux-raspberrypi_%25.bbappend
inherit kernel-resin

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Set console accordingly to build type
DEBUG_CMDLINE = "dwc_otg.lpm_enable=0 console=tty1 console=serial0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait"
PRODUCTION_CMDLINE = "dwc_otg.lpm_enable=0 console=null root=/dev/mmcblk0p2 rootfstype=ext4 rootwait vt.global_cursor_default=0"
CMDLINE = "${@bb.utils.contains('DISTRO_FEATURES','development-image',"${DEBUG_CMDLINE}","${PRODUCTION_CMDLINE}",d)}"
CMDLINE_DEBUG = ""

