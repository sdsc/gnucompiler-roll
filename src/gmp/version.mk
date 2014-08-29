NAME           = opt-gmp
VERSION        = 5.1.3
RELEASE        = 1
PKGROOT        = /opt/gnu/gmp

SRC_SUBDIR     = gmp

SOURCE_NAME    = gmp
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = 5.1.3
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
