################################################################################
#
# gupnp
#
################################################################################
#
#GUPNP_VERSION_MAJOR = 0.20
#GUPNP_VERSION = $(GUPNP_VERSION_MAJOR).18
#GUPNP_SOURCE = gupnp-$(GUPNP_VERSION).tar.gz
#GUPNP_SITE = http://ftp.gnome.org/pub/gnome/sources/gupnp/$(GUPNP_VERSION_MAJOR)
#GUPNP_LICENSE = LGPLv2+
#GUPNP_LICENSE_FILES = COPYING
#GUPNP_INSTALL_STAGING = YES
#GUPNP_DEPENDENCIES = host-pkg-config libglib2 libxml2 gssdp util-linux


GUPNP_VERSION_MAJOR = 1.0
GUPNP_VERSION = $(GUPNP_VERSION_MAJOR).1
GUPNP_SOURCE = gupnp-$(GUPNP_VERSION).tar.gz
GUPNP_SITE = http://ftp.gnome.org/pub/gnome/sources/gupnp/$(GUPNP_VERSION_MAJOR)
GUPNP_LICENSE = LGPLv2+
GUPNP_LICENSE_FILES = COPYING
GUPNP_INSTALL_STAGING = YES
GUPNP_DEPENDENCIES = host-pkg-config libglib2 libxml2 gssdp util-linux

#$(eval $(autotools-package))
$(eval $(call AUTOTARGETS,package,gupnp)) 
