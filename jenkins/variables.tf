variable "master_flavor" {
   default = "e3standard.x2"
}

variable "region" {}

variable "keyname" {}

variable "network_name" {}

variable "image" {}

variable "sec_group" {
  type = "list"
}

variable "tags" {
   default = {
    "server_group" = "JENKINS"
  }
}
