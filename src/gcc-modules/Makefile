REDHAT.ROOT = $(CURDIR)/../../
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

$(VERSION_INC): $(VERSION_SRC)
	/bin/grep 'VERSION.*=' $(VERSION_SRC) > $@

build:

# could not get the substitution below to work with perl
install:: typical-modulefile-install
	if test "$(GNUTOOLSCOMPILER)" = "yes"; then \
               sed -i 's/GNUTOOLSBEGIN/if {! $$unloadApps} {/g' $(ROOT)/$(PKGROOT)/$(VERSION); \
               perl -pi -e "s!GNUTOOLSEND!}!g" $(ROOT)/$(PKGROOT)/$(VERSION); \
        else \
               perl -pi -e "s!GNUTOOLSBEGIN!!g" $(ROOT)/$(PKGROOT)/$(VERSION); \
               perl -pi -e "s!GNUTOOLSEND!!g" $(ROOT)/$(PKGROOT)/$(VERSION); \
        fi


clean::
	rm -f $(VERSION_INC)
