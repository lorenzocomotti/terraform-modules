# Create instance
module "jenkins_master" {
  source = "github.com/entercloudsuite/terraform-modules//instance?ref=2.6"
  name = "jenkins_master"
  region = "${var.region}"
  image = "${var.image}"
  quantity = 1
  external = "true"
  discovery = "true"
  flavor = "${var.master_flavor}"
  network_name = "${var.network_name}"
  sec_group = ["${var.sec_group}"]
  keypair = "${var.keyname}"
  tags = "${var.tags}"
}
