################################################################################
#
# lockfile-progs
#
################################################################################

LOCKFILE_PROGS_VERSION = 0.1.19
LOCKFILE_PROGS_SOURCE = lockfile-progs_$(LOCKFILE_PROGS_VERSION).tar.gz
LOCKFILE_PROGS_SITE = http://snapshot.debian.org/archive/debian/20210903T205304Z/pool/main/l/lockfile-progs
LOCKFILE_PROGS_DEPENDENCIES = liblockfile
LOCKFILE_PROGS_LICENSE = GPL-2.0
LOCKFILE_PROGS_LICENSE_FILES = COPYING

LOCKFILE_PROGS_BINS = \
	$(addprefix lockfile-,check create remove touch) \
	$(addprefix mail-,lock touchlock unlock)

LOCKFILE_PROGS_LDFLAGS = $(TARGET_LDFLAGS)

ifeq ($(BR2_PACKAGE_LOCKFILE_PROGS_STATIC),y)
LOCKFILE_PROGS_LDFLAGS += -static
endif

define LOCKFILE_PROGS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) \
		LDFLAGS="$(LOCKFILE_PROGS_LDFLAGS)" -C $(@D)
endef

define LOCKFILE_PROGS_INSTALL_TARGET_CMDS
	for i in $(LOCKFILE_PROGS_BINS); do \
		$(INSTALL) -D -m 755 $(@D)/bin/$$i $(TARGET_DIR)/usr/bin/$$i || exit 1; \
	done
endef

$(eval $(generic-package))
