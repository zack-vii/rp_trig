srcdir = .
builddir = .
top_srcdir = ../..
top_builddir = ../..
abs_srcdir = $(realpath $(srcdir))
abs_builddir = $(realpath $(builddir))
abs_top_srcdir = $(realpath $(top_srcdir))
abs_top_builddir = $(realpath $(top_builddir))

MAKE_PROCESS = $(shell grep -c ^processor /proc/cpuinfo)
AM_MAKEFLAGS += -j$(MAKE_PROCESS)

MODULES = rp_trig
SOC_BOARD = red_pitaya
SHELL = /bin/bash
CC = gcc
ARCH = arm
CROSS_COMPILE = arm-linux-gnueabihf-
LINUX_DIR = linux
LINUX_SRCDIR = $(abs_top_srcdir)/$(LINUX_DIR)
LINUX_BUILDDIR = $(abs_top_builddir)/$(LINUX_DIR)
LINUX_CFLAGS = -O2 -mtune=cortex-a9 -mfpu=neon -mfloat-abi=hard
LINUX_PACKAGE = uImage
LINUX_UIMAGE_LOADADDR = 0x8000
LINUX_IMAGE = $(LINUX_PACKAGE)

TOOLCHAIN_DIR = $(abs_top_srcdir)/toolchain
TOOLCHAIN_PATH = $(TOOLCHAIN_DIR)/bin

define _set_export
export ARCH=$(ARCH); \
export CROSS_COMPILE=$(CROSS_COMPILE); \
export PATH=$${PATH}:$(TOOLCHAIN_PATH)
endef

.PRECIOUS: Makefile
.PHONY: modules clean
modules: $(LINUX_SRCDIR) $(MODULES:=.c) Kbuild
	@echo " --- building modules ---"; \
	$(_set_export); \
	$(MAKE) -C $< CFLAGS="$(LINUX_CFLAGS)" M=$(abs_srcdir) \
	 srcdir=$(srcdir) builddir=$(builddir) modules


clean:	$(LINUX_SRCDIR)
	@$(MAKE) -C $< CFLAGS="$(LINUX_CFLAGS)" M=$(abs_srcdir) clean

MKIMAGE:
	@which mkimage >/dev/null||apt install u-boot-tools

.PHONY: linux-init linux-init-s
linux-init-s: $(LINUX_SRCDIR) $(LINUX_BUILDDIR)
	$(_set_export); \
	cd $(LINUX_BUILDDIR); \
	export LS=$$(ls); \
	export KERNELVERSION=$$($(MAKE) -s -C $< kernelversion); \
	export DEFCONFIG=${abs_top_srcdir}/linux.conf/$${KERNELVERSION}/$(SOC_BOARD).def; \
	export SRCARCH=${ARCH}; \
	export srctree=$(LINUX_SRCDIR); \
	$(LINUX_BUILDDIR)/scripts/kconfig/conf --defconfig=$${DEFCONFIG} Kconfig

linux-init: ##@linux initialize linux sources applying the soc defconfig
	$(MAKE) -s linux-init-s

$(LINUX_BUILDDIR)/.config: $(LINUX_SRCDIR) $(LINUX_BUILDDIR)
	$(_set_export); \
	$(MAKE) $(AM_MAKEFLAGS) -C $< mrproper; \
	$(MAKE) -s $(AM_MAKEFLAGS) -C $< defconfig; \
	$(MAKE) -s linux-init

$(LINUX_IMAGE): $(LINUX_SRCDIR) $(LINUX_BUILDDIR) $(LINUX_BUILDDIR)/.config $(TOOLCHAIN_DIR) MKIMAGE
	$(_set_export); \
	$(MAKE) $(AM_MAKEFLAGS) -C $< CFLAGS="$(LINUX_CFLAGS)" \
	 UIMAGE_LOADADDR=$(LINUX_UIMAGE_LOADADDR) $(LINUX_PACKAGE);\
	$(MAKE) $(AM_MAKEFLAGS) -C $< CFLAGS="$(LINUX_CFLAGS)" modules;\
	mkdir -p $(abs_top_srcdir)/lib/modules; \
	$(MAKE) $(AM_MAKEFLAGS) -C $< CFLAGS="$(LINUX_CFLAGS)" \
	 INSTALL_MOD_PATH=$(abs_top_srcdir) modules_install;\
	cp $(LINUX_BUILDDIR)/arch/arm/boot/uImage $@

$(LINUX_SRCDIR):
	$(MAKE) -s -C $(top_srcdir) $(LINUX_DIR)

$(TOOLCHAIN_DIR):
	$(MAKE) -s -C $(top_srcdir) toolchain

.NOEXPORT:
