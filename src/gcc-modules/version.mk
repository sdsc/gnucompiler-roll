NAME        = gcc-modules
RELEASE     = 0
PKGROOT     = /opt/modulefiles/compilers/gnu

VERSION_SRC = $(REDHAT.ROOT)/src/gcc/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
