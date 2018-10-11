# Create instance
module "windows-iis" {
  source = "github.com/lorenzocomotti/terraform-modules//vmware/instance-windows"
  name = "${var.name}"
  quantity = "${var.quantity}"
  vmware_network_name = "${var.vmware_network_name}"
  vmware_datastore = "${var.vmware_datastore}"
  vmware_datacenter = "${var.vmware_datacenter}"
  vmware_resource_pool = "${var.vmware_resource_pool}"
  vmware_template = "${var.vmware_template}"
  windows_password = "${var.windows_password}"
  cpus = "${var.cpus}"
  domain = "${var.domain}"
  memory = "${var.memory}"

   connection {
    type     = "winrm"
    user     = "Administrator"
    password = "${var.windows_password}"
    timeout  = "30m"
  }

  provisioner "file" {
    source      = "iis.ps1"
    destination = "C:\\scripts\\iis.ps1"
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -File C:\\scripts\\iis.ps1"
    ]
  }
}

