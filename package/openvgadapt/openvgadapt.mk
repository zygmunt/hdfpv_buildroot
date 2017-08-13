################################################################################
#
# OpenVG
#
################################################################################

#OPENVGADAPT_VERSION = 1.0
OPENVGADAPT_VERSION = ca5c54220bf07af604a34ab13131f8378ddff89d
#OPENVGADAPT_SOURCE = libfoo-$(OPENVGADAPT_VERSION).tar.gz
#OPENVGADAPT_SITE = http://www.foosoftware.org/download
OPENVGADAPT_SITE = https://github.com/zygmunt/openvgadapt.git
OPENVGADAPT_SITE_METHOD = git
#OPENVGADAPT_GIT_SUBMODULES = YES 
OPENVGADAPT_LICENSE = MIT
OPENVGADAPT_LICENSE_FILES = LICENSE
OPENVGADAPT_INSTALL_STAGING = YES
#OPENVGADAPT_CONFIG_SCRIPTS = libfoo-config
OPENVGADAPT_DEPENDENCIES = rpi-userland jpeg 

### todo depends host: ttf-dejavu

_OPENVGADAPT_PREFIX = /opt/hdfpv
_OPENVGADAPT_INSTALL_OPTS = DESTDIR=$(TARGET_DIR) PREFIX=$(_OPENVGADAPT_PREFIX)
_OPENVGADAPT_VC = VC_LIBDIR=$(STAGING_DIR)/usr/lib VC_INCDIR=$(STAGING_DIR)/usr/include
_OPENVGADAPT_SYSROOT = SYSROOT=$(TARGET_DIR)

define OPENVGADAPT_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) $(_OPENVGADAPT_VC)
endef

define OPENVGADAPT_INSTALL_STAGING_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(STAGING_DIR) -C $(@D) install_headers 
endef

define OPENVGADAPT_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(_OPENVGADAPT_INSTALL_OPTS) -C $(@D) install_library 
endef

$(eval $(generic-package))
 
