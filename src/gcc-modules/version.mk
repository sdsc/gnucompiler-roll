PACKAGE     = gcc
CATEGORY    = compilers

NAME        = sdsc-$(PACKAGE)-modules
RELEASE     = 8
PKGROOT     = /opt/modulefiles/$(CATEGORY)/gnu

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No\nAutoProv:No
RPM.PREFIX  = $(PKGROOT)
