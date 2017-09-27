NAME           = sdsc-gmp
VERSION        = 6.0.0a
RELEASE        = 2
PKGROOT        = /opt/gnu/gmp

SRC_SUBDIR     = gmp

SOURCE_NAME    = gmp
SOURCE_SUFFIX  = tar.bz2
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = gmp-6.0.0

TAR_BZ2_PKGS   = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
RPM.PREFIX     = $(PKGROOT)
