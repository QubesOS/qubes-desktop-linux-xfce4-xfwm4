RPM_SPEC_FILES := xfwm4.spec
DEBIAN_BUILD_DIRS := debian-pkg/debian

NO_ARCHIVE := 1

ifneq ($(filter $(DISTRIBUTION), debian qubuntu),)
SOURCE_COPY_IN := source-debian-copy-in
endif

source-debian-copy-in: VERSION = $(shell cat $(ORIG_SRC)/version)
source-debian-copy-in: ORIG_FILE = $(CHROOT_DIR)/$(DIST_SRC)/xfwm4_$(VERSION).orig.tar.bz2
source-debian-copy-in: SRC_FILE  = $(ORIG_SRC)/xfwm4-$(VERSION).tar.bz2
source-debian-copy-in:
	mkdir -p "$(CHROOT_DIR)/$(DIST_SRC)/debian/patches"
	$(ORIG_SRC)/debian-quilt $(ORIG_SRC)/series-debian.conf $(CHROOT_DIR)/$(DIST_SRC)/debian/patches
	cp -p $(SRC_FILE) $(ORIG_FILE)
	tar jxvf $(SRC_FILE) -C $(CHROOT_DIR)/$(DIST_SRC)/debian-pkg --strip-components=1

# vim: ft=make
