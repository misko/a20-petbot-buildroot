################################################################################
#
# gst1-plugins-base
#
################################################################################

A20_PETBOT_FIRMWARE_VERSION = HEAD
A20_PETBOT_FIRMWARE_SITE = git@github.com:misko/a20-petbot-firmware.git
A20_PETBOT_FIRMWARE_SITE_METHOD = git

A20_PETBOT_FIRMWARE_INSTALL_STAGING = YES

A20_PETBOT_FIRMWARE_AUTORECONF = YES
#A20_PETBOT_FIRMWARE_AUTORECONF_OPT = -I $(@D)/common/m4  -fi

# freetype is only used by examples, but if it is not found
# and the host has a freetype-config script, then the host
# include dirs are added to the search path causing trouble
A20_PETBOT_FIRMWARE_CONF_ENV =
	FT2_CONFIG=/bin/false \
	ac_cv_header_stdint_t="stdint.h" \
	ac_cv_prog_cc_c99='-std=gnu99' \
	LIBS=-lrt 



A20_PETBOT_FIRMWARE_DEPENDENCIES = gst1-plugins-base gstreamer1  gettext libintl  gst1-plugins-bad libcurl libnice mpg123 libao
A20_PETBOT_FIRMWARE_MAKE_OPT += CFLAGS+="-std=gnu99 -DA20 -DPBSSL -DPTHREADS -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -g" LDFLAGS+="-lpthread -g"

#$(eval $(autotools-package))
$(eval $(call AUTOTARGETS,package,a20-petbot-firmware))
