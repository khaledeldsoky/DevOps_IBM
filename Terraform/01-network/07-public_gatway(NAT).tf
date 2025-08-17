resource "ibm_is_vpc_routing_table" "routing_table" {
  name = "routing-table"
  vpc  = var.vpc_id
}

resource "ibm_is_public_gateway" "NAT" {
  for_each = var.NAT
  name = each.key
  vpc  = var.vpc_id
  zone = each.value.zone
  tags = ["Name:NAT-${each.key}"]
}
