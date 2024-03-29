#############################################################
#
# libgcrypt
#
#############################################################

LIBGCRYPT_VERSION = 1.4.6
LIBGCRYPT_SOURCE = libgcrypt-$(LIBGCRYPT_VERSION).tar.bz2
LIBGCRYPT_SITE = ftp://ftp.gnupg.org/gcrypt/libgcrypt
LIBGCRYPT_INSTALL_STAGING = YES
LIBGCRYPT_AUTORECONF = YES

LIBGCRYPT_CONF_ENV = \
	ac_cv_sys_symbol_underscore=no
LIBGCRYPT_CONF_OPT = \
	--disable-optimization \
	--with-gpg-error-prefix=$(STAGING_DIR)/usr LDFLAGS="-lgpg-error"

LIBGCRYPT_DEPENDENCIES = libgpg-error

$(eval $(call AUTOTARGETS,package,libgcrypt))
