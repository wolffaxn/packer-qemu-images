
TEMPLATE_FILE:=./ubuntu/ubuntu.pkr.hcl
VAR_FILE_UBUNTU_22.04:=./ubuntu/ubuntu-22.04-x86_64.pkrvars.hcl
VAR_FILE_UBUNTU_24.04:=./ubuntu/ubuntu-24.04-x86_64.pkrvars.hcl

.PHONY: init
init:
	packer init ./ubuntu/ubuntu.pkr.hcl

.PHONY: build_22.04
build_22.04: init
	PACKER_LOG=1 packer build -force --var-file ${VAR_FILE_UBUNTU_22.04} ${TEMPLATE_FILE}

.PHONY: build_24.04
build_24.04: init
	PACKER_LOG=1 packer build -force --var-file ${VAR_FILE_UBUNTU_24.04} ${TEMPLATE_FILE}
