#!/usr/bin/make -f

export PACKER_LOG=1

PKR_OUTPUT_DIR=output
PKR_HCL_DIR=.

clean:
	@echo "make clean"
	rm -rf ${PKR_OUTPUT_DIR}/

init:
	@echo "make init"
	packer init ${PKR_HCL_DIR}

build-all: clean init
	@echo "make build-all"
	packer build -only "qemu.ubuntu-*" ${PKR_HCL_DIR}

build-24.04:
	@echo "make build-24.04"
	rm -rf ${PKR_OUTPUT_DIR}/ubuntu-24.04
	packer build -only "qemu.ubuntu-24.04" ${PKR_HCL_DIR}

build-22.04:
	@echo "make build-22.04"
	rm -rf ${PKR_OUTPUT_DIR}/ubuntu-22.04
	packer build -only "qemu.ubuntu-22.04" ${PKR_HCL_DIR}
