resource "ibm_is_security_group_rule" "SGR_tcp" {
  for_each  = var.SGR_tcp
  group     = each.value.group
  direction = each.value.direction
  remote    = each.value.remote
  
  tcp {
    port_max = each.value.port_max
    port_min = each.value.port_min
  }

}


resource "ibm_is_security_group_rule" "SGR_udp" {
  for_each  = var.SGR_udp
  group     = each.value.group
  direction = each.value.direction
  remote    = each.value.remote

  udp {
    port_max = each.value.port_max
    port_min = each.value.port_min
  }

}

resource "ibm_is_security_group_rule" "SGR_icmp" {
  for_each  = var.SGR_icmp
  group     = each.value.group
  direction = each.value.direction
  remote    = each.value.remote
  
  icmp {
  }

}

