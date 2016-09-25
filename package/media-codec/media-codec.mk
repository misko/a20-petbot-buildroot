################################################################################
#
# gst1-plugins-base
#
################################################################################

MEDIA_CODEC_VERSION = 0.2
MEDIA_CODEC_SOURCE = media-codec-$(MEDIA_CODEC_VERSION).tar.gz
MEDIA_CODEC_SITE = http://www.petbot.com
MEDIA_CODEC_INSTALL_STAGING = YES

MEDIA_CODEC_AUTORECONF = YES
#MEDIA_CODEC_AUTORECONF_OPT = -I $(@D)/common/m4  -fi

# freetype is only used by examples, but if it is not found
# and the host has a freetype-config script, then the host
# include dirs are added to the search path causing trouble
MEDIA_CODEC_CONF_ENV =
	FT2_CONFIG=/bin/false \
	ac_cv_header_stdint_t="stdint.h"


#MEDIA_CODEC_CONF_OPT = CFLAGS="$(TARGET_CFLAGS) -mfloat-abi=softfp" LDFLAGS="-Wl,--no-as-needed" #-mfpu=neon" 
MEDIA_CODEC_CONF_OPT = CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="-Wl,--no-as-needed" #-mfpu=neon" 
#MEDIA_CODEC_CFLAGS += -mfpu=neon
#MEDIA_CODEC_DEPENDENCIES = gst1-plugins-base gstreamer1  gettext libintl
#MEDIA_CODEC_MAKE_OPT += CFLAGS+=-lintl

#define MEDIA_CODEC_BOOTSTRAP
#	cd $(@D) && PATH=$(BR_PATH) AUTOPOINT=/bin/true ./bootstrap
#endef
#MEDIA_CODEC_PRE_CONFIGURE_HOOKS += MEDIA_CODEC_BOOTSTRAP

#$(eval $(autotools-package))
$(eval $(call AUTOTARGETS,package,media-codec))
