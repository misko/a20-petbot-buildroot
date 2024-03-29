################################################################################
#
# libnice
#
################################################################################

#LIBNICE_VERSION = 0.1.8
#LIBNICE_VERSION = 0.1.13
LIBNICE_VERSION = git
LIBNICE_SOURCE =libnice-$(LIBNICE_VERSION).tar.gz
#LIBNICE_SITE = http://nice.freedesktop.org/releases/
LIBNICE_AUTORECONF = YES

LIBNICE_LICENSE = MPLv1.1 or LGPLv2.1
LIBNICE_LICENSE_FILES = COPYING COPYING.MPL COPYING.LGPL

LIBNICE_INSTALL_STAGING = YES
LIBNICE_CONF_OPT = \
	--without-gstreamer-0.10 \
	--disable-gtk-doc  \
	--enable-gupnp

#--without-gstreamer \

LIBNICE_DEPENDENCIES = host-pkg-config host-libglib2 libglib2 gstreamer1 gst1-plugins-base gupnp-igd

$(eval $(call AUTOTARGETS,package,libnice)) 
