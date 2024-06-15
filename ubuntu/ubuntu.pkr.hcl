#
# Packer template to create an Ubuntu Server
#

build {
  source "qemu.ubuntu" {
    name             = "ubuntu-24.04"
    iso_url          = var.ubuntu_24_04_iso_url
    iso_checksum     = lookup(var.map_iso_checksum, basename(var.ubuntu_24_04_iso_url), "none")
    output_directory = abspath("${var.output_dir}/${source.name}")
    vm_name          = "${source.name}.${var.format}"
  }

  source "qemu.ubuntu" {
    name             = "ubuntu-22.04"
    iso_url          = var.ubuntu_22_04_iso_url
    iso_checksum     = lookup(var.map_iso_checksum, basename(var.ubuntu_22_04_iso_url), "none")
    output_directory = abspath("${var.output_dir}/${source.name}")
    vm_name          = "${source.name}.${var.format}"
  }

  # wait for cloud-init to successfully finish
  provisioner "shell" {
    inline = [
      "sudo cloud-init status --wait > /dev/null 2>&1"
    ]
  }
}

source "qemu" "ubuntu" {
  disk_cache             = var.disk_cache
  disk_compression       = var.disk_compression
  disk_discard           = var.disk_discard
  disk_image             = var.disk_image
  disk_interface         = var.disk_interface
  disk_size              = var.disk_size
  format                 = var.format
  headless               = var.headless
  machine_type           = var.machine_type
  net_device             = var.net_device
  qemuargs               = [["-m", "${var.ram}"], ["-smp", "${var.cpu}"]]
  shutdown_command       = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_handshake_attempts = var.ssh_handshake_attempts
  ssh_password           = var.ssh_password
  ssh_timeout            = var.ssh_timeout
  ssh_username           = var.ssh_username
  ssh_wait_timeout       = var.ssh_wait_timeout

  cd_files = ["http/user-data", "http/meta-data"]
  cd_label = "cidata"
}

variable "map_iso_checksum" {
  type = map(string)
  default = {
    "ubuntu-22.04-server-cloudimg-amd64.img" : "362f43af89dec3eb5980873f8f9f4994800b1fb27bce4df91681c3a167ce07b9"
    "ubuntu-24.04-server-cloudimg-amd64.img" : "bc984eb1d1efbf2da8c7e9fa2487347a4cbc03247c487d890cdd32f231e1b3b0"
  }
}

variable "ubuntu_24_04_iso_url" {
  type    = string
  default = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img"
}

variable "ubuntu_22_04_iso_url" {
  type    = string
  default = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
}
