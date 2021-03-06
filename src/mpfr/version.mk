NAME           = sdsc-mpfr
VERSION        = 3.1.2
RELEASE        = 4
PKGROOT        = /opt/gnu/mpfr

SRC_SUBDIR     = mpfr

SOURCE_NAME    = mpfr
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = 3.1.2
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No\nAutoProv:No
RPM.PREFIX     = $(PKGROOT)
