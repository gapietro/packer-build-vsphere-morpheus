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


# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "vsphere-iso" "win2019-gui" {
  ############ VM Config ############
  CPUs                 = 2
  RAM                  = 2048
  RAM_reserve_all      = true
  disk_controller_type = ["lsilogic-sas"]
  storage {
    disk_size             = 40960
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = "VM Network"
    network_card = "e1000e"
  }

  guest_os_type    = "windows9Server64Guest"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"
  
  ############ Boot Config ############
  boot_wait        = "5s"
  floppy_files     = ["scripts/windows/bios/gui/autounattend.xml","scripts/windows/vmware-tools.ps1"]
  iso_checksum     = "3022424f777b66a698047ba1c37812026b9714c5"
  iso_url          = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"

  ############ User/Comm Config ############
  communicator   = "winrm"
  winrm_insecure = true
  winrm_password = "${var.winrm_password}"
  winrm_timeout  = "4h"
  winrm_use_ssl  = true
  winrm_username = "${var.winrm_username}"

  ############ vSphere Config ############
  vcenter_server = "${var.vcenter_server}"
  datacenter     = "${var.datacenter}"
  cluster        = "${var.cluster}"
  datastore      = "${var.datastore}"
  folder         = "${var.folder}"
  vm_name        = "windows-2019gui-vsp-pkr-{{ timestamp }}"
  username       = "${var.vcenter_username}"
  password       = "${var.vcenter_password}"
  insecure_connection  = true
}


# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vsphere-iso.win2019-gui"]

  #provisioner "powershell" {
  #  scripts = ["scripts/windows/vmware-tools.ps1"]
  #}

  provisioner "powershell" {
    scripts = ["scripts/windows/setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    scripts = ["scripts/windows/win-update.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    scripts = ["scripts/windows/win-update.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    scripts = ["scripts/windows/cleanup.ps1"]
  }

  provisioner "windows-shell" {
    inline = ["%WINDIR%\\system32\\sysprep\\sysprep.exe /generalize /shutdown /oobe"]
  }


}
