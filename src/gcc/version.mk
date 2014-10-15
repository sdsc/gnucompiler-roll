NAME           = opt-gcc
VERSION        = 4.9.1
RELEASE        = 0
PKGROOT        = /opt/gnu/gcc

SRC_SUBDIR     = gcc

SOURCE_NAME    = gcc
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
