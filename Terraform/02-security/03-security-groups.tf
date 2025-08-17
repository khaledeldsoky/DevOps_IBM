resource "ibm_is_security_group" "security_groups" {
  for_each = var.security_groups

  name = each.key
  vpc  = each.value.vpc_id

  tags = ["Name:security_group-${each.key}"]
}

