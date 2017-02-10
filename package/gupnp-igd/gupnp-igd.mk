################################################################################
#
# gupnp
#
################################################################################
#

GUPNP_IGD_VERSION_MAJOR = 0.2
GUPNP_IGD_VERSION = $(GUPNP_IGD_VERSION_MAJOR).4
GUPNP_IGD_SOURCE = gupnp-igd-$(GUPNP_IGD_VERSION).tar.gz
GUPNP_IGD_SITE = http://ftp.gnome.org/pub/gnome/sources/gupnp/$(GUPNP_IGD_VERSION_MAJOR)
GUPNP_IGD_LICENSE = LGPLv2+
GUPNP_IGD_LICENSE_FILES = COPYING
GUPNP_IGD_INSTALL_STAGING = YES
GUPNP_IGD_DEPENDENCIES = host-pkg-config libglib2 libxml2 gssdp util-linux gupnp
GUPNP_IGD_CONF_OPT += \
        --disable-gtk-doc
GUPNP_IGD_AUTORECONF = YES


#$(eval $(autotools-package))
$(eval $(call AUTOTARGETS,package,gupnp-igd)) 
