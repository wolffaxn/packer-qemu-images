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
