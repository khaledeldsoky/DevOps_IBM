resource "ibm_resource_group" "resource-group" {
  name = var.resource_group_name
}

resource "ibm_is_vpc" "VPC" {
  name           = var.VPC_name
  resource_group = var.resource_group_id
  
  tags = ["Name:VPC-${var.VPC_name}"]
}
