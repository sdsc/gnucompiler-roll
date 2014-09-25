NAME        = gmp-modules
RELEASE     = 0
PKGROOT     = /opt/modulefiles/applications/gmp

VERSION_SRC = $(REDHAT.ROOT)/src/gmp/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
