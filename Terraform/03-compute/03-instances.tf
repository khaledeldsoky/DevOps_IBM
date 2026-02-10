resource "ibm_is_instance" "instances" {
  for_each = var.instances
resource_group = var.resource_group_id
  name    = each.key
  image   = each.value.image
  profile = each.value.profile
  vpc     = each.value.vpc_id
  zone    = each.value.zone
  keys    = [each.value.ssh_key_id]

  # boot_volume {
  #   size = each.value.boot_volume_size
  #   name = "${each.key}-boot-volume"
  # }

  primary_network_interface {

    allow_ip_spoofing = false
    subnet            = each.value.subnet_id
    security_groups   = [each.value.security_groups_id]
    primary_ip {
      address = each.value.ip
    }
    
  }

}


# address = valid static IPs are from 192.168.10.4 to 192.168.10.254
# the 4 ips is reserves
# IBM Cloud reserves:

# .0: Network address

# .1: Reserved for gateway/router

# .2 & .3: IBM services

# So you should start using IPs from .4 or above
