################################################################################
#
# libsrtp
#
################################################################################

LIBSRTP_VERSION = 1.5.4
LIBSRTP_SOURCE =libsrtp-1.5.4.tar.gz
LIBSRTP_SITE = http://nice.freedesktop.org/releases/

LIBSRTP_LICENSE = BSD-like 1
LIBSRTP_LICENSE_FILES = LICENSE

LIBSRTP_INSTALL_STAGING = YES

LIBSRTP_DEPENDENCIES = host-pkg-config #host-libglib2 libglib2 gstreamer1 gst1-plugins-base

$(eval $(call AUTOTARGETS,package,libsrtp)) 
