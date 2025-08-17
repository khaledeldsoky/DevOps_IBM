output "resource_group" {
  value = ibm_resource_group.resource-group
}

output "VPC" {
  value = ibm_is_vpc.VPC
}

output "subnets" {
  value = ibm_is_subnet.subnets
}

output "GW_id" {
  value = {
    for GWs in ibm_is_public_gateway.NAT : GWs.name =>
    {
      id   = GWs.id
      name = GWs.name
    }
  }
}
