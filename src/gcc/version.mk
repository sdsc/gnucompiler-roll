NAME           = sdsc-gcc
VERSION        = 7.1.0
RELEASE        = 1
PKGROOT        = /opt/gnu/gcc

SRC_SUBDIR     = gcc

SOURCE_NAME    = gcc
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
RPM.FILES      = "/opt/gnu/gcc\\n/opt/gnu/gcc/bin*\\n/opt/gnu/gcc/include*\\n/opt/gnu/gcc/lib*\\n/opt/gnu/gcc/lib64*\\n/opt/gnu/gcc/libexec*\\n/opt/gnu/gcc/license-info*\\n/opt/gnu/gcc/share*"
