variable "domain" {
  default = "automium.internal"
}

variable "quantity" {
  default = 1
}

variable "cpus" {
  default = 1
}

variable "memory" {
  default = 512
}

variable "memory_reservation" {
  default = 256
}

variable "name" {
}

variable "vmware_template" {
  default = "Ubuntu-16.04"
}

variable "vmware_datastore" {
}

variable "vmware_network_name" {
}

variable "vmware_datacenter" {
}

variable "vmware_resource_pool"{
}

variable "windows_password" {
}
