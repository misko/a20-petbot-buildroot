#############################################################
#
# which
#
#############################################################

DRAGONBOARD_VERSION = 0.2
DRAGONBOARD_SOURCE = dragonboard-$(DRAGONBOARD_VERSION).tar.gz
DRAGONBOARD_SITE = http://www.foosoftware.org/download
DRAGONBOARD_INSTALL_STAGING = YES
#DRAGONBOARD_DEPENDENCIES = host-libaaa libbbb
    #$(MAKE) CC=$(TARGET_CC) LD=$(TARGET_LD) -C $(@D) all

define DRAGONBOARD_BUILD_CMDS
    mkdir -p $(DRAGONBOARD_DIR)/output/bin
    $(MAKE) AR="$(TARGET_AR)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C "$(@D)" all
endef

#define DRAGONBOARD_INSTALL_STAGING_CMDS
#    $(INSTALL) -D -m 0755 $(@D)/dragonboard.a $(STAGING_DIR)/usr/lib/dragonboard.a
#    $(INSTALL) -D -m 0644 $(@D)/foo.h $(STAGING_DIR)/usr/include/foo.h
#    $(INSTALL) -D -m 0755 $(@D)/dragonboard.so* $(STAGING_DIR)/usr/lib
#endef
#
#define DRAGONBOARD_INSTALL_TARGET_CMDS
#    $(INSTALL) -D -m 0755 $(@D)/dragonboard.so* $(TARGET_DIR)/usr/lib
#    $(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/foo.d
#endef

$(eval $(call GENTARGETS,package,dragonboard))

