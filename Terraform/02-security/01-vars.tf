variable "security_groups" {
  type = map(object({
    vpc_id = string 
  }))
}

variable "SGR_tcp" {
  type = map(object({
    group     = string
    direction = string
    remote    = string
    port_max  = number
    port_min  = number
  }))
}

variable "SGR_udp" {
  type = map(object({
    group     = string
    direction = string
    remote    = string
    port_max  = number
    port_min  = number
  }))
}

variable "SGR_icmp" {
  type = map(object({
    group     = string
    direction = string
    remote    = string
  }))
}

variable "ssh_key" {
  type = map(object({
    path     = string
    ssh_type = string
  }))
}

