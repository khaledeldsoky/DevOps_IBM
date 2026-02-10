output "instance" {
  value = {
    for instances in ibm_is_instance.instances : instances.name => {
      name                      = instances.name
      id                        = instances.id
      primary_network_interface = instances.primary_network_interface
    }
  }
}


# output "baremetal" {
#   value = {
#     for baremetal in ibm_is_bare_metal_server.baremetal : baremetal.name => {
#       name                      = baremetal.name
#       id                        = baremetal.id
#       primary_network_interface = baremetal.primary_network_interface
#     }
#   }
# }