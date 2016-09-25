#############################################################
#
# libjpcnn
#
#############################################################
LIBJPCNN_VERSION:=0.1
LIBJPCNN_SOURCE:=libjpcnn-$(LIBJPCNN_VERSION).tar.gz
LIBJPCNN_SITE:=http://www.foosoftware.org/downloads
#LIBJPCNN_DIR:=$(BUILD_DIR)/libjpcnn-$(LIBJPCNN_VERSION)
#LIBJPCNN_BINARY:=libjpcnn.so
#LIBJPCNN_TARGET_BINARY:=usr/lib/libjpcnn.so
LIBJPCNN_INSTALL_STAGING = YES


define LIBJPCNN_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D) GEMM=eigen
endef

define LIBJPCNN_INSTALL_STAGING_CMDS
    $(INSTALL) -D -m 0755 $(@D)/libjpcnn.so* $(STAGING_DIR)/usr/lib
    $(INSTALL) -D -m 0644 $(@D)/src/include/libjpcnn.h $(STAGING_DIR)/usr/include/libjpcnn.h
endef

define LIBJPCNN_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/libjpcnn.so* $(TARGET_DIR)/usr/lib
endef


#$(TARGET_DIR)/$(LIBJPCNN_TARGET_BINARY): 
#	$(MAKE) DESTDIR=$(TARGET_DIR) -C $(LIBJPCNN_DIR) GEMM=eigen


#$(LIBJPCNN_DIR)/.source: $(DL_DIR)/$(LIBJPCNN_SOURCE)
#	$(ZCAT) $(DL_DIR)/$(LIBJPCNN_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
#	touch $@


#$(LIBJPCNN_DIR)/.configured: $(LIBJPCNN_DIR)/.source
#	touch $(LIBJPCNN_DIR)/.configured


#libjpcnn: $(TARGET_DIR)/$(LIBJPCNN_TARGET_BINARY)

#############################################################
#
# Toplevel Makefile options
#
#############################################################
#ifeq ($(BR2_PACKAGE_LIBJPCNN),y)
#TARGETS+=libjpcnn
#endif

$(eval $(call GENTARGETS,package,libjpcnn))
