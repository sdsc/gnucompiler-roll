NAME        = mpc-modules
RELEASE     = 0
PKGROOT     = /opt/modulefiles/applications/mpc

VERSION_SRC = $(REDHAT.ROOT)/src/mpc/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
