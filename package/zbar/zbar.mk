################################################################################
#
# zbar
#
################################################################################

# github have some additional commits for compiling with recent kernel
ZBAR_VERSION = 0.10
ZBAR_SITE = http://zbar.sourceforge.net
ZBAR_SOURCE = zbar-0.10.tar.gz
ZBAR_LICENSE = LGPLv2.1+
ZBAR_LICENSE_FILES = LICENSE
ZBAR_INSTALL_STAGING = YES
ZBAR_AUTORECONF = YES
ZBAR_DEPENDENCIES = libv4l jpeg gettext
#$(if $(BR2_NEEDS_GETTEXT),gettext) host-gettext 
ZBAR_CONF_OPT = \
	--without-imagemagick \
	--without-qt \
	--without-gtk \
	--without-python \
	--without-x

# fix /usr/bin/install: cannot stat ‘./doc/man/zbarcam.1’: No such file or
#   directory
# make[5]: *** [install-man1] Error 1
define ZBAR_INSTALL_FIXUP
	touch $(@D)/doc/man/zbarcam.1
endef

ZBAR_POST_BUILD_HOOKS += ZBAR_INSTALL_FIXUP

$(eval $(call AUTOTARGETS,package,zbar))

