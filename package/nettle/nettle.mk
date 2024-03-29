################################################################################
#
# nettle
#
################################################################################

NETTLE_VERSION = 3.2
NETTLE_SITE = http://www.lysator.liu.se/~nisse/archive
NETTLE_DEPENDENCIES = gmp
NETTLE_INSTALL_STAGING = YES
NETTLE_LICENSE = Dual GPLv2+/LGPLv3+
NETTLE_LICENSE_FILES = COPYING.LESSERv3 COPYINGv2
# don't include openssl support for (unused) examples as it has problems
# with static linking
NETTLE_CONF_OPT = --disable-openssl
# For 0002-fix-CVE-2016-6489.patch
NETTLE_AUTORECONF = YES

# ARM assembly requires v6+ ISA
ifeq ($(BR2_ARM_CPU_ARMV4)$(BR2_ARM_CPU_ARMV5)$(BR2_ARM_CPU_ARMV7M),y)
NETTLE_CONF_OPT += --disable-assembler
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
NETTLE_CONF_OPT += --enable-arm-neon
else
NETTLE_CONF_OPT += --disable-arm-neon
endif

#$(eval $(autotools-package))
$(eval $(call AUTOTARGETS,package,nettle))
