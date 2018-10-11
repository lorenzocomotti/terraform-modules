data "vsphere_datacenter" "datacenter" {
  name = "${var.vmware_datacenter}"
}

data "vsphere_resource_pool" "resourcepool" {
  name          = "${var.vmware_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_datastore_cluster" "datastore" {
  name          = "${var.vmware_datastore}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "vm-network" {
  name          = "${var.vmware_network_name}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vmware_template}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_virtual_machine" "instance" {
  name             = "${var.name}"
  resource_pool_id = "${data.vsphere_resource_pool.resourcepool.id}"
  datastore_cluster_id = "${data.vsphere_datastore_cluster.datastore.id}"
  count = "${var.quantity}"

  num_cpus = "${var.cpus}"
  memory   = "${var.memory}"
  memory_reservation = "${var.memory_reservation}"

  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id = "${data.vsphere_network.vm-network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label = "disk-os"
    size  = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    #customize {
    #  windows_options {
    #    computer_name  = "${var.name}"
    #    admin_password = "${var.windows_password}"
    #  }
      network_interface {
      }  
    }
  }
}
