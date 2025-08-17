variable "resource_group_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "VPC_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = map(object({
    zone           = string
    cidr           = string
    public_gateway = optional(string)
  }))
}

variable "address_prefixs" {
  type = map(object({
    zone = string
    cidr = string
  }))
}

variable "floating_IPs" {
  type = map(
    object({
      primary_network_interface_id = string
    })
  )
}

variable "NAT" {
  type = map(object({
    zone = string
  }))
}
