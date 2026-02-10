# output "resource_group" {
#   value = ibm_resource_group.resource_group
# }

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

output "routing_tables" {
  value = {
    for routing_tables in ibm_is_vpc_routing_table.routing_table : routing_tables.name =>
    {
      id   = routing_tables.id
      name = routing_tables.name
    }
  }
}