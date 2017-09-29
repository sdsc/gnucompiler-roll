NAME           = sdsc-mpc
VERSION        = 1.0.3
RELEASE        = 2
PKGROOT        = /opt/gnu/mpc

SRC_SUBDIR     = mpc

SOURCE_NAME    = mpc
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
RPM.PREFIX     = $(PKGROOT)
