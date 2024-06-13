#
# Packer template to create an Ubuntu Server
#

packer {
  required_plugins {
    qemu = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "cpu" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "16G"
}

variable "headless" {
  type    = string
  default = "true"
}

variable "iso_checksum" {
  type    = string
  default = "https://cloud-images.ubuntu.com/releases/24.04/release/SHA256SUMS"
}

variable "iso_url" {
  type    = string
  default = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img"
}

variable "ram" {
  type    = string
  default = "2048M"
}

variable "ssh_password" {
  type    = string
  default = "ubuntu"
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "vm_name" {
  type    = string
  default = "ubuntu-22.04-x86_64"
}

source "qemu" "ubuntu" {
  disk_cache             = "none"
  disk_compression       = true
  disk_discard           = "ignore"
  disk_image             = true
  disk_interface         = "virtio"
  disk_size              = var.disk_size
  format                 = "qcow2"
  headless               = var.headless
  iso_checksum           = var.iso_checksum
  iso_url                = var.iso_url
  net_device             = "virtio-net"
  output_directory       = "output"
  qemuargs               = [["-m", "${var.ram}"], ["-smp", "${var.cpu}"]]
  shutdown_command       = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_handshake_attempts = 500
  ssh_password           = var.ssh_password
  ssh_timeout            = "30m"
  ssh_username           = var.ssh_username
  ssh_wait_timeout       = "30m"
  vm_name                = "${var.vm_name}.qcow2"

  cd_files = ["ubuntu/http/user-data", "ubuntu/http/meta-data"]
  cd_label = "cidata"
}

build {
  sources = ["source.qemu.ubuntu"]

  # wait for cloud-init to successfully finish
  provisioner "shell" {
    inline = [
      "cloud-init status --wait > /dev/null 2>&1"
    ]
  }
}
