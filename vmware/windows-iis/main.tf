module "windows-istance" {
  source = "github.com/entercloudsuite/terraform-modules/vmware/instance"
  name = "${var.name}"
  cpus = "${var.cups}"
  memory = "${var.memory}"
  vmware_template = "${var.vmware_template}"
  quantity = "${var.quantity}"
  vmware_network_name = "${var.network_name}"
  vmware_datastore = "${var.vmware_datastore}"
  vmware_network_name = "${var.vmware_network_name}"
  vmware_datacenter = "${var.vmware_datacenter}"
  vmware_resource_pool = "${var.vmware_resource_pool}"
  userdata = "${data.template_file.cloud-config.*.rendered}"
  }

data "template_file" "cloud-config" {
  template = "${file("${path.module}/cloud-config.ps1")}"
  count = "${var.quantity}"
  vars {
    password = "${var.password}"
  }
}
