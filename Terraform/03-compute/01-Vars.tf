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
  }))
}
