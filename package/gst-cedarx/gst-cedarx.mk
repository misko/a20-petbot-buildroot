################################################################################
#
# gst1-plugins-base
#
################################################################################

GST_CEDARX_VERSION = 0.2
GST_CEDARX_SOURCE = gst-cedarx-$(GST_CEDARX_VERSION).tar.gz
GST_CEDARX_SITE = http://www.petbot.com
GST_CEDARX_INSTALL_STAGING = YES

GST_CEDARX_AUTORECONF = YES
#GST_CEDARX_AUTORECONF_OPT = -I $(@D)/common/m4  -fi

# freetype is only used by examples, but if it is not found
# and the host has a freetype-config script, then the host
# include dirs are added to the search path causing trouble
GST_CEDARX_CONF_ENV =
	FT2_CONFIG=/bin/false \
	ac_cv_header_stdint_t="stdint.h"

GST_CEDARX_DEPENDENCIES = gst1-plugins-base gstreamer1  gettext libintl media-codec
GST_CEDARX_MAKE_OPT += CFLAGS+=-lintl

#$(eval $(autotools-package))
$(eval $(call AUTOTARGETS,package,gst-cedarx))
