################################################################################
#
# libsoup
#
################################################################################

LIBSOUP_VERSION_MAJOR = 2.54
LIBSOUP_VERSION = $(LIBSOUP_VERSION_MAJOR).1
LIBSOUP_SOURCE = libsoup-$(LIBSOUP_VERSION).tar.gz
LIBSOUP_SITE = http://ftp.gnome.org/pub/gnome/sources/libsoup/$(LIBSOUP_VERSION_MAJOR)
LIBSOUP_LICENSE = LGPLv2+
LIBSOUP_LICENSE_FILES = COPYING
LIBSOUP_INSTALL_STAGING = YES
LIBSOUP_CONF_ENV = ac_cv_path_GLIB_GENMARSHAL=$(LIBGLIB2_HOST_BINARY)
LIBSOUP_CONF_OPT = --disable-glibtest --enable-vala=no --with-gssapi=no
LIBSOUP_DEPENDENCIES = host-pkg-config host-libglib2 \
	libglib2 libxml2 sqlite host-intltool

ifeq ($(BR2_PACKAGE_LIBSOUP_GNOME),y)
LIBSOUP_CONF_OPT += --with-gnome
else
LIBSOUP_CONF_OPT += --without-gnome
endif

ifeq ($(BR2_PACKAGE_LIBSOUP_SSL),y)
LIBSOUP_DEPENDENCIES += glib-networking
else
LIBSOUP_CONF_OPT += --disable-tls-check
endif

LIBSOUP_MAKE_OPT += CFLAGS+="-L../libsoup/.libs/" LIBS+="-lintl -lgio-2.0 -lgobject-2.0 -lglib-2.0"

#$(eval $(autotools-package))
$(eval $(call AUTOTARGETS,package,libsoup))
