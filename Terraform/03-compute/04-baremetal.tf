# resource "ibm_is_bare_metal_server" "baremetal" {
# for_each = var.baremetal

#   name    = each.key
#   image   = each.value.image
#   profile = each.value.profile
#   vpc     = each.value.vpc_id
#   zone    = each.value.zone
#   keys    = [each.value.ssh_key_id]

#   primary_network_interface {

#     allow_ip_spoofing = false
#     subnet            = each.value.subnet_id
#     security_groups   = [each.value.security_groups_id]
#     primary_ip {
#       address = each.value.ip
#     }
#   }
# }

# us-south-2