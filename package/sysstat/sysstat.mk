#############################################################
#
# sysstat
#
#############################################################

SYSSTAT_VERSION = 9.1.7
SYSSTAT_SOURCE = sysstat-$(SYSSTAT_VERSION).tar.bz2
SYSSTAT_SITE = http://pagesperso-orange.fr/sebastien.godard/
SYSSTAT_CONF_OPT = --disable-man-group --disable-sensors

ifneq ($(BR2_HAVE_DOCUMENTATION),y)
SYSSTAT_CONF_OPT += --disable-documentation
endif

ifeq ($(BR2_NEEDS_GETTEXT_IF_LOCALE),y)
#SYSSTAT_DEPENDENCIES += gettext libintl
#SYSSTAT_MAKE_OPT += CFLAGS+=-lintl
endif
SYSSTAT_DEPENDENCIES += gettext libintl
SYSSTAT_MAKE_OPT += CFLAGS+=-lintl

# The isag tool is a post processing script that depends on tcl/tk
# among other things. So we don't install it.
SYSSTAT_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) INSTALL_ISAG=n install

$(eval $(call AUTOTARGETS,package,sysstat))
