################################################################################
#
# raspi2png
#
################################################################################

#RASPI2PNG_VERSION = 1.0
RASPI2PNG_VERSION = e5d16036daa5affb4cf8eeecbced5ac36f76c237
#RASPI2PNG_SOURCE = libfoo-$(RASPI2PNG_VERSION).tar.gz
#RASPI2PNG_SITE = http://www.foosoftware.org/download
RASPI2PNG_SITE = https://github.com/zygmunt/raspi2png.git
RASPI2PNG_SITE_METHOD = git
#RASPI2PNG_GIT_SUBMODULES = YES 
RASPI2PNG_LICENSE = MIT
RASPI2PNG_LICENSE_FILES = LICENSE
#RASPI2PNG_INSTALL_STAGING = YES
#RASPI2PNG_CONFIG_SCRIPTS = libfoo-config
RASPI2PNG_DEPENDENCIES = rpi-userland libpng

_RASPI2PNG_PREFIX = /opt/hdfpv
_RASPI2PNG_INSTALL_OPTS = DESTDIR=$(TARGET_DIR) PREFIX=$(_RASPI2PNG_PREFIX)
_RASPI2PNG_VC = VC_LIBDIR=$(STAGING_DIR)/usr/lib VC_INCDIR=$(STAGING_DIR)/usr/include
_RASPI2PNG_SYSROOT = SYSROOT=$(TARGET_DIR)

define RASPI2PNG_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) $(_RASPI2PNG_VC)
endef

define RASPI2PNG_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(_RASPI2PNG_INSTALL_OPTS) -C $(@D) install
endef

$(eval $(generic-package))
 
