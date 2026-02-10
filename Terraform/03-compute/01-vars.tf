variable "instances" {
  type = map(object({
    image              = string
    profile            = string
    vpc_id             = string
    zone               = string
    ssh_key_id         = string
    security_groups_id = string
    subnet_id          = string
    ip                 = string
    # boot_volume_size   = optional(number)
  }))
}
variable "resource_group_id" {
  type = string
}


variable "floating_IPs" {
  type = map(
    object({
      primary_network_interface_id = string
    })
  )
}
# variable "baremetal" {
#   type = map(object({
#     image              = string
#     profile            = string
#     vpc_id             = string
#     zone               = string
#     ssh_key_id         = string
#     security_groups_id = string
#     subnet_id          = string
#     ip                 = string
#   }))
# }
