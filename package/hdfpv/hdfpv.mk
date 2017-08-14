################################################################################
#
# hdfpv
#
################################################################################

#HDFPV_VERSION = 1.0
HDFPV_VERSION = 34aa3284daa4c7cf2bf94012202f9c44f46a1925
#HDFPV_SOURCE = libfoo-$(HDFPV_VERSION).tar.gz
#HDFPV_SITE = http://www.foosoftware.org/download
HDFPV_SITE = https://github.com/zygmunt/hdfpv.git
HDFPV_SITE_METHOD = git
HDFPV_GIT_SUBMODULES = YES 
#HDFPV_LICENSE = GPL-3.0+
#HDFPV_LICENSE_FILES = COPYING
#HDFPV_INSTALL_STAGING = YES
#HDFPV_CONFIG_SCRIPTS = libfoo-config
HDFPV_DEPENDENCIES = rpi-userland rpi-firmware libpcap openvgadapt

### depends host: ttf-dejavu

_HDFPV_PREFIX = /opt/hdfpv
_HDFPV_INSTALL_OPTS = DESTDIR=$(TARGET_DIR) PREFIX=$(_HDFPV_PREFIX)
_HDFPV_VC = VC_LIBDIR=$(STAGING_DIR)/usr/lib VC_INCDIR=$(STAGING_DIR)/usr/include
_HDFPV_SYSROOT = SYSROOT=$(TARGET_DIR)

define HDFPV_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/tee 
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/mmormota $(_HDFPV_INSTALL_OPTS) $(_HDFPV_VC) HOST_DIR=$(STAGING_DIR)
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/EZ-WifiBroadcast/wifibroadcast 
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/EZ-WifiBroadcast/wifibroadcast_status $(_HDFPV_INSTALL_OPTS) $(_HDFPV_SYSROOT)
endef

#define HDFPV_INSTALL_STAGING_CMDS
#	echo "STAGING"
#endef

define HDFPV_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(_HDFPV_INSTALL_OPTS) -C $(@D)/tee install
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(_HDFPV_INSTALL_OPTS) -C $(@D)/mmormota $(_HDFPV_INSTALL_OPTS) $(_HDFPV_SYSROOT) install
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(_HDFPV_INSTALL_OPTS) -C $(@D)/EZ-WifiBroadcast/wifibroadcast install
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(_HDFPV_INSTALL_OPTS) -C $(@D)/EZ-WifiBroadcast/wifibroadcast_status $(_HDFPV_INSTALL_OPTS) $(_HDFPV_SYSROOT) install
	
	install -D -m 0755 -d $(TARGET_DIR)/etc/modprobe.d
	$(foreach conf,$(wildcard $(@D)/modprobe.d/*.conf),install -D -m 0644 $(conf) $(TARGET_DIR)/etc/modprobe.d;)
	
	# Overwrite config.txt and cmdline.txt
	$(INSTALL) -D -m 0644 $(@D)/boot/config.txt $(BINARIES_DIR)/rpi-firmware/config.txt
	$(INSTALL) -D -m 0644 $(@D)/boot/cmdline.txt $(BINARIES_DIR)/rpi-firmware/cmdline.txt
	
	$(INSTALL) -D -m 0644 $(@D)/boot/wifibroadcast.txt $(BINARIES_DIR)/wifibroadcast.txt
	$(INSTALL) -D -m 0644 $(@D)/boot/osdconfig.txt $(BINARIES_DIR)/osdconfig.txt
	
	$(INSTALL) -D -m 0755 $(@D)/scripts/S50wifibroadcast $(TARGET_DIR)$(_HDFPV_PREFIX)/S50wifibroadcast
	$(INSTALL) -D -m 0644 $(@D)/scripts/hdfpv_functions.sh $(TARGET_DIR)$(_HDFPV_PREFIX)/hdfpv_functions.sh
	$(INSTALL) -D -m 0644 $(@D)/scripts/hdfpv_functions_other.sh $(TARGET_DIR)$(_HDFPV_PREFIX)/hdfpv_functions_other.sh
	$(INSTALL) -D -m 0644 $(@D)/scripts/hdfpv_settings.sh $(TARGET_DIR)$(_HDFPV_PREFIX)/hdfpv_settings.sh
endef

$(eval $(generic-package))
