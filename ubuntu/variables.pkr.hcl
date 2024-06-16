packer {
  required_version = ">= 1.11.0"

  required_plugins {
    qemu = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "cpu" {
  type    = number
  default = 2
}

variable "disk_cache" {
  type    = string
  default = "none"
}

variable "disk_compression" {
  type    = bool
  default = true
}

variable "disk_discard" {
  type    = string
  default = "ignore"
}

variable "disk_image" {
  type    = bool
  default = true
}

variable "disk_interface" {
  type    = string
  default = "virtio"
}

variable "disk_size" {
  type    = string
  default = "32G"
}

variable "format" {
  type    = string
  default = "qcow2"
}

variable "headless" {
  type    = bool
  default = true
}

variable "iso_checksum" {
  type    = string
  default = "https://cloud-images.ubuntu.com/releases"
}

variable "iso_url" {
  type    = string
  default = "https://cloud-images.ubuntu.com/releases"
}

variable "machine_type" {
  type    = string
  default = "q35"
}

variable "net_device" {
  type    = string
  default = "virtio-net"
}

variable "output_dir" {
  type    = string
  default = "output"
}

variable "ram" {
  type    = string
  default = "2048M"
}

variable "ssh_handshake_attempts" {
  type    = number
  default = 100
}

variable "ssh_password" {
  type    = string
  default = "ubuntu"
}

variable "ssh_timeout" {
  type    = string
  default = "30m"
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "ssh_wait_timeout" {
  type    = string
  default = "30m"
}

variable "vm_name" {
  type    = string
  default = "ubuntutT"
}
