.DEFAULT_GOAL := all

VIVADO_RELEASE = 2020.1

DEVTREE_REPO = Xilinx
DEVTREE_RELEASE = $(VIVADO_RELEASE)
DEVTREE_NAME = device-tree-xlnx-xilinx-v$(DEVTREE_RELEASE)
DEVTREE_TAG = xilinx-v$(DEVTREE_RELEASE)

LINUX_REPO = Xilinx
LINUX_RELEASE = 2016.1
LINUX_NAME = linux-xlnx-xilinx-v$(LINUX_RELEASE)
LINUX_TAG = xilinx-v$(LINUX_RELEASE)

UBOOT_REPO = Xilinx
UBOOT_RELEASE = $(VIVADO_RELEASE)
UBOOT_NAME = u-boot-xlnx-xilinx-v$(UBOOT_RELEASE)
UBOOT_TAG = xilinx-v$(UBOOT_RELEASE)

TOOLCHAIN_VERSION = 7.5
TOOLCHAIN_RELEASE = 2019.12
TOOLCHAIN_NAME = gcc-linaro-$(TOOLCHAIN_VERSION).0-$(TOOLCHAIN_RELEASE)-x86_64_arm-linux-gnueabihf

DEVTREE_DIR = devicetree
LINUX_DIR = linux
UBOOT_DIR = uboot
TOOLCHAIN_DIR = toolchain

$(DEVTREE_DIR):
	@rm -rf $@
	@curl -L https://github.com/$(DEVTREE_REPO)/device-tree-xlnx/archive/$(DEVTREE_TAG).tar.gz | tar -z -x\
	 && mv $(DEVTREE_NAME) $@\
	 && touch $@

$(LINUX_DIR):
	@rm -rf $@
	@curl -L https://github.com/$(LINUX_REPO)/linux-xlnx/archive/$(LINUX_TAG).tar.gz | tar -z -x\
	 && mv $(LINUX_NAME) $@\
	 && touch $@

$(UBOOT_DIR):
	@rm -rf $@
	@curl -L https://github.com/$(UBOOT_REPO)/u-boot-xlnx/archive/$(UBOOT_TAG).tar.gz | tar -z -x\
	 && mv $(UBOOT_NAME) $@\
	 && touch $@

$(TOOLCHAIN_DIR):
	@rm -rf $@
	@curl -L http://releases.linaro.org/components/toolchain/binaries/$(TOOLCHAIN_VERSION)-$(TOOLCHAIN_RELEASE)/arm-linux-gnueabihf/$(TOOLCHAIN_NAME).tar.xz | tar --xz -x\
	 && mv $(TOOLCHAIN_NAME) $@\
	 && touch $@

.PHONY: distclean all

distclean:
	@rm -rf $(XILINX_DEVICETREE) 2>/dev/null ||:
	@rm -rf $(XILINX_LINUX) 2>/dev/null ||:
	@rm -rf $(TOOLCHAIN) 2>/dev/null ||:

all: $(DEVTREE_DIR) $(LINUX_DIR) $(TOOLCHAIN_DIR)
