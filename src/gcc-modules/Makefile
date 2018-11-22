REDHAT.ROOT = $(CURDIR)/../../
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

$(VERSION_INC): $(VERSION_SRC)
	/bin/grep 'VERSION.*=' $(VERSION_SRC) > $@

build:

install:: typical-modulefile-install
	if test "$(GNUTOOLSCOMPILER)" = "yes"; then \
               perl -pi -e "\$$dollar=chr(36);s!GNUTOOLSBEGIN!if {\! \$${dollar}unloadApps} {!g" $(ROOT)/$(PKGROOT)/$(VERSION); \
               perl -pi -e "s!GNUTOOLSEND!}!g" $(ROOT)/$(PKGROOT)/$(VERSION); \
        else \
               perl -pi -e "s!GNUTOOLSBEGIN!!g" $(ROOT)/$(PKGROOT)/$(VERSION); \
               perl -pi -e "s!GNUTOOLSEND!!g" $(ROOT)/$(PKGROOT)/$(VERSION); \
        fi


clean::
	rm -f $(VERSION_INC)
