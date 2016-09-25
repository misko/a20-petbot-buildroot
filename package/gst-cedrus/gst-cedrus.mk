################################################################################
#
# gst1-plugins-base
#
################################################################################

GST_CEDRUS_VERSION = 0.2
GST_CEDRUS_SOURCE = gst-cedrus-$(GST_CEDRUS_VERSION).tar.gz
GST_CEDRUS_SITE = http://www.petbot.com
GST_CEDRUS_INSTALL_STAGING = YES

GST_CEDRUS_AUTORECONF = YES
#GST_CEDRUS_AUTORECONF_OPT = -I $(@D)/common/m4  -fi

# freetype is only used by examples, but if it is not found
# and the host has a freetype-config script, then the host
# include dirs are added to the search path causing trouble
GST_CEDRUS_CONF_ENV =
	FT2_CONFIG=/bin/false \
	ac_cv_header_stdint_t="stdint.h"

GST_CEDRUS_DEPENDENCIES = gst1-plugins-base gstreamer1  gettext libintl
GST_CEDRUS_MAKE_OPT += CFLAGS+=-lintl

#$(eval $(autotools-package))
$(eval $(call AUTOTARGETS,package,gst-cedrus))
