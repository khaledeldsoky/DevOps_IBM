# resource "ibm_is_vpc_address_prefix" "Address_Prefixs" {
#   for_each = var.Address_Prefixs

#   name = each.key
#   vpc  = var.vpc_id
#   zone = each.value.zone
#   cidr = each.value.cidr # "10.240.0.0/24"  
# }

resource "ibm_is_vpc_address_prefix" "address_prefixs" {
  for_each = var.address_prefixs
  
  name = each.key
  zone = each.value.zone
  vpc  = var.vpc_id
  cidr = each.value.cidr

}
