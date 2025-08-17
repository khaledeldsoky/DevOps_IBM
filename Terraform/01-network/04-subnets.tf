resource "ibm_is_subnet" "subnets" {
  for_each = var.subnets

  name            = each.key
  vpc             = var.vpc_id
  zone            = each.value.zone
  ipv4_cidr_block = each.value.cidr # "10.240.0.0/24"  
  resource_group = var.resource_group_id

  # routing_table   = ibm_is_vpc_routing_table.routing_table.routing_table
  public_gateway  = each.value.public_gateway
  tags = ["Name:Subnet-${each.key}"]
}