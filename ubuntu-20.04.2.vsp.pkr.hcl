# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.
#
# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.
#
# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
##############################################################################################
variable "winrm_username" {
    type          = string
    description   = "default winrm username used by packer to log into windows image"
}

variable "winrm_password" {
    type          = string
    description   = "default winrm username used by packer to log into windows image"
    sensitive     = true
}

variable "ssh_username" {
    type          = string
    description   = "default ssh username used by packer to log into linux image"
}

variable "ssh_password" {
    type          = string
    description   = "default ssh password used by packer to log into linux image"
    sensitive     = true
}

variable "vcenter_server" {
    type          = string
    description   = "HomeLab vCenter Server"
}

variable "datacenter" {
    type          = string
    description   = "HomeLab vCenter Server Datacenter"
}

variable "cluster" {
    type          = string
    description   = "HomeLab vCenter Server Cluster"
}

variable "host" {
    type          = string
    description   = "HomeLab vCenter Server Host to build images"
}

variable "datastore" {
    type          = string
    description   = "HomeLab vCenter Server vSAN Datastore to build images"
}

variable "folder" {
    type          = string
    description   = "HomeLab vCenter Server target folder for image"
}

variable "vcenter_username" {
    type          = string
    sensitive     = true
    description   = "HomeLab vCenter Server Username"
}

variable "vcenter_password" {
    type          = string
    sensitive     = true
    description   = "HomeLab vCenter Server Password"
}

# source blocks are analogous to the "builders" in json templates. They are used
# in build blocks. A build block runs provisioners and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "vsphere-iso" "ubuntu-2004" {
  ############ VM Config ############
  CPUs                 = 1
  RAM                  = 2048
  RAM_reserve_all      = true
  storage {
    disk_size             = 20000
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = "VM Network"
    network_card = "vmxnet3"
  }
  guest_os_type        = "ubuntu64Guest"
  insecure_connection  = true
  remove_cdrom         = true
  boot_order           = "disk,cdrom"

  ############ Boot Config ############
  boot_wait            = "5s"
  
  http_directory       = "http/ubuntu"
  cd_files             = ["http/ubuntu/user-data","http/ubuntu/meta-data"]
  cd_label             = "cidata"
  boot_command         = ["<enter><enter><f6><esc><wait>",
                          " ro net.ifnames=0 biosdevname=0",
                          " autoinstall ds=nocloud;",
                          "<enter><wait>"] 
  iso_urls             = ["https://releases.ubuntu.com/20.04/ubuntu-20.04.2-live-server-amd64.iso"]
  iso_checksum         = "d1f2bf834bbe9bb43faf16f9be992a6f3935e65be0edece1dee2aa6eb1767423"

  
  ############ User Config ############
  ssh_username           = "ubuntu"
  ssh_password           = "${var.ssh_password}"
  ssh_timeout            = "20m"
  ssh_handshake_attempts = "200"

  ############ vSphere Config ############
  vcenter_server      = "${var.vcenter_server}"
  datacenter          = "${var.datacenter}"
  cluster             = "${var.cluster}"
  datastore           = "${var.datastore}"
  folder              = "${var.folder}"
  vm_name             = "ubuntu-2004-vsp-pkr-{{ timestamp }}"
  username            = "${var.vcenter_username}"
  password            = "${var.vcenter_password}"
  convert_to_template = true 
  shutdown_command    = "sudo shutdown -P now"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vsphere-iso.ubuntu-2004"]

  provisioner "shell" {
    inline = ["ls /",
              "sudo echo ###################### install utils",
              "sudo apt-get update -y",
              "sudo apt-get install -f -y cloud-utils python3 net-tools curl cloud-init python3-pip",
#              "sudo echo ###################### stop cloud-init",
#              "sudo systemctl stop cloud-init",
#              "sudo rm -f /etc/machine-id",
#              "sudo echo ###################### clean cloud-init cache",
#              "sudo cloud-init clean -s -l",
#              "sudo rm -rf /var/log/cloud",
#              "sudo rm -rf /var/lib/cloud/*",
#              "sudo echo ###################### update CMDLINE_LINUX_DEFAULT",
#              "sudo sed -i 's/seedfrom=.*/seedfrom=\/dev\/sr0\"/g' /etc/default/grub ",
#              "sudo update-grub2"
              "sudo echo ###################### Update Done ",
    ]
  }

  provisioner "shell" {
    script       = "http/ubuntu/setup.sh"
    pause_before = "10s"
    timeout      = "10s"
  }
}
