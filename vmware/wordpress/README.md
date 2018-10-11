terraform-module-instance-vmware

## Example

### Create instance

1. Write the example below in a .tf file

```
# Define provider
provider "vsphere" {
  user = "<your_user>"
  password = "<your_passowrd>"
  vsphere_server = "<your_vsphere_server>"
}

# Create instance
module "vmware" {
  source = "github.com/entercloudsuite/terraform-modules/vmware/instance"
  name = "my-instance"
  quantity = 1
  vmware_network_name = "my-network"
  vmware_datastore = "my-datastore"
  vmware_datacenter = "my-datacenter"
  vmware_resource_pool = "my-resource-pool"
}
```
 
2. compile provider "vsphere" section, don't use the variables here
3. Adjust the `quantity` variable to a desirable value
4. Run `terraform init` to allow terraform to get the requirements
5. Run `terraform get` to allow terraform to obtain the modules
6. Run `terraform plan -out plan.tfplan` and `terraform apply plan.tfplan` to provision the infrastructure
