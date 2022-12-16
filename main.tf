##########################################
#       Terraform Proxmox                #
#    Deploy LXC container in Proxmox     #
##########################################


terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://SERVER:8006/api2/json"
  pm_api_token_id     = "terraform_user@pam!token_id"
  pm_api_token_secret = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"

}


resource "proxmox_lxc" "LXC" {
  # count        = 3
  target_node  = "proxmox"
  hostname     = "Ubuntu"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst" //Change to Yours
  password     = "LXC_Container"
  unprivileged = true
  cores        = 2
  memory       = 1024
  swap         = 1024
  start        = true


  rootfs {
    storage = "local-lvm" //Change to Yours
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}
