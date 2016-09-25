################################################################################
#
# gst1-plugins-base
#
################################################################################

GST_JPCNN_VERSION = 1.0
GST_JPCNN_SOURCE = gst-jpcnn-$(GST_JPCNN_VERSION).tar.gz
GST_JPCNN_SITE = http://www.petbot.com
GST_JPCNN_INSTALL_STAGING = YES

GST_JPCNN_AUTORECONF = YES
#GST_JPCNN_AUTORECONF_OPT = -I $(@D)/common/m4  -fi

# freetype is only used by examples, but if it is not found
# and the host has a freetype-config script, then the host
# include dirs are added to the search path causing trouble
GST_JPCNN_CONF_ENV =
	FT2_CONFIG=/bin/false \
	ac_cv_header_stdint_t="stdint.h"

GST_JPCNN_DEPENDENCIES = gst1-plugins-base gstreamer1  gettext libintl media-codec libjpcnn
GST_JPCNN_MAKE_OPT += CFLAGS+=-lintl

#$(eval $(autotools-package))
$(eval $(call AUTOTARGETS,package,gst-jpcnn))
