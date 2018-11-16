PACKAGE     = gcc
CATEGORY    = compilers

NAME        = sdsc-$(PACKAGE)-modules
RELEASE     = 9
PKGROOT     = /opt/modulefiles/$(CATEGORY)/gnu

GNUTOOLSCOMPILER=no
ifneq ("$(ROLLOPTS)", "$(subst gnutoolscompiler=,,$(ROLLOPTS))")
  GNUTOOLSCOMPILER = $(subst gnutoolscompiler=,,$(filter gnutoolscompiler=%,$(ROLLOPTS)))
endif

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No\nAutoProv:No
RPM.PREFIX  = $(PKGROOT)
