XILINX_RELEASE = 2020.1
XILINX_LINUX_NAME = linux-xlnx-xilinx-v$(XILINX_RELEASE)
XILINX_DEVICETREE_NAME = device-tree-xlnx-xilinx-v$(XILINX_RELEASE)

TOOLCHAIN_VERSION = 7.5-2019.12
TOOLCHAIN_RELEASE = 7.5.0-2019.12
TOOLCHAIN_NAME = gcc-linaro-$(TOOLCHAIN_RELEASE)-x86_64_arm-linux-gnueabihf

XILINX_DEVICETREE = devicetree
XILINX_LINUX = linux
TOOLCHAIN = toolchain

$(XILINX_DEVICETREE):
	@rm -rf $@
	@curl -L https://github.com/Xilinx/device-tree-xlnx/archive/xilinx-v$(XILINX_RELEASE).tar.gz | tar -z -x\
	 && mv $(XILINX_DEVICETREE_NAME) $@\
	 && touch $@

$(XILINX_LINUX):
	@rm -rf $@
	@curl -L https://github.com/Xilinx/linux-xlnx/archive/xilinx-v$(XILINX_RELEASE).tar.gz | tar -z -x\
	 && mv $(XILINX_LINUX_NAME) $@\
	 && touch $@


$(TOOLCHAIN):
	@rm -rf $@
	@curl -L http://releases.linaro.org/components/toolchain/binaries/$(TOOLCHAIN_VERSION)/arm-linux-gnueabihf/$(TOOLCHAIN_NAME).tar.xz | tar --xz -x\
	 && mv $(TOOLCHAIN_NAME) $@\
	 && touch $@

.PHONY: distclean all


distclean:
	@rm -rf $(XILINX_DEVICETREE) 2>/dev/null ||:
	@rm -rf $(XILINX_LINUX) 2>/dev/null ||:
	@rm -rf $(TOOLCHAIN) 2>/dev/null ||:

all: $(XILINX_DEVICETREE) $(XILINX_LINUX) $(TOOLCHAIN)

