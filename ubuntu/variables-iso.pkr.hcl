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
