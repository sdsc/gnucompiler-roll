NAME        = mpfr-modules
RELEASE     = 0
PKGROOT     = /opt/modulefiles/applications/mpfr

VERSION_SRC = $(REDHAT.ROOT)/src/mpfr/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No