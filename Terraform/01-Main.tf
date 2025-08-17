module "Network" {
  source = "./01-network"

  resource_group_id   = module.Network.resource_group.id
  resource_group_name = "resource-group"
  VPC_name            = "vpc-name"
  vpc_id              = module.Network.VPC.id

  subnets = {
    "public-subnet" = {
      zone = var.zone_eu_gb_2
      cidr = var.cider_block_192_168_1
    }

    "private-subnet-1" = {
      zone = var.zone_eu_gb_2
      cidr = var.cider_block_192_168_2
      public_gateway     = module.Network.GW_id["nat-1"].id
    }

    "private-subnet-2" = {
      zone = var.zone_eu_gb_3
      cidr = var.cider_block_192_168_3
      public_gateway     = module.Network.GW_id["nat-2"].id
    }
  }

  floating_IPs = {
    "bastion-ip" = {
      primary_network_interface_id = module.Compute.instance["bastion-instance"].primary_network_interface[0].id
    }
  }

  address_prefixs = {
    "prefix-192-168-1" = {
      cidr = var.cider_block_192_168_1
      zone = var.zone_eu_gb_2
    }

    "prefix-192-168-2" = {
      cidr = var.cider_block_192_168_2
      zone = var.zone_eu_gb_2
    }

    "prefix-192-168-3" = {
      cidr = var.cider_block_192_168_3
      zone = var.zone_eu_gb_3
    }
  }

  NAT = {
    "nat-1"= {
      zone = var.zone_eu_gb_2
    }

    "nat-2"= {
      zone = var.zone_eu_gb_3
    }
  }
}

module "Security" {
  source = "./02-security"

  security_groups = {
    "public" = {
      vpc_id = module.Network.VPC.id
    }

    "private-master" = {
      vpc_id = module.Network.VPC.id
    }

    "private-worker" = {
      vpc_id = module.Network.VPC.id
    }
  }

  SGR_tcp = {
    for rule in local.TCP : "${rule.type}_${rule.group_name}_${rule.direction}_${rule.name}" => {
      group     = module.Security.security_group["${rule.group_name}"].id
      direction = "${rule.direction}"
      remote    = "${rule.remote}"
      port_max  = "${rule.port_max}"
      port_min  = "${rule.port_min}"
    }
  }

  SGR_udp = {
    for rule in local.UDP : "${rule.type}_${rule.group_name}_${rule.direction}_${rule.name}" => {
      group     = module.Security.security_group["${rule.group_name}"].id
      direction = "${rule.direction}"
      remote    = "${rule.remote}"
      port_max  = "${rule.port_max}"
      port_min  = "${rule.port_min}"
    }
  }

  SGR_icmp = {
    #---------- inbound ----------#
    SGR_icmp_master_inbound = {
      group     = module.Security.security_group["private-master"].id
      direction = "inbound"
      remote    = "0.0.0.0/0"
    }

    SGR_icmp_node_inbound = {
      group     = module.Security.security_group["private-worker"].id
      direction = "inbound"
      remote    = "0.0.0.0/0"
    }

    #---------- outbound ----------#
    SGR_icmp_master_outbound = {
      group     = module.Security.security_group["private-master"].id
      direction = "outbound"
      remote    = "0.0.0.0/0"
    }

    SGR_icmp_node_outbound = {
      group     = module.Security.security_group["private-worker"].id
      direction = "outbound"
      remote    = "0.0.0.0/0"
    }
  }
  
  ssh_key = {
    "private-ssh-key" = {
      path     = var.ssh_key_private_path
      ssh_type = var.ssh_type_rsa
    }

    "public-ssh-key" = {
      path     = var.ssh_key_public_path
      ssh_type = var.ssh_type_rsa
    }
  }
}

module "Compute" {
  source = "./03-compute"

  instances = {
    "bastion-instance" = {
      image              = data.ibm_is_image.ubuntu.id
      profile            = var.bx2-2x8
      vpc_id             = module.Network.VPC.id
      zone               = var.zone_eu_gb_2
      ssh_key_id         = module.Security.ssh_key["public-ssh-key"].id
      security_groups_id = module.Security.security_group["public"].id
      subnet_id          = module.Network.subnets["public-subnet"].id
      ip                 = "192.168.1.10"
    }

    "master-instance" = {
      image              = data.ibm_is_image.ubuntu.id
      profile            = var.bx2-2x8
      vpc_id             = module.Network.VPC.id
      zone               = var.zone_eu_gb_2
      ssh_key_id         = module.Security.ssh_key["private-ssh-key"].id
      security_groups_id = module.Security.security_group["private-master"].id
      subnet_id          = module.Network.subnets["private-subnet-1"].id
      ip                 = "192.168.2.10"
    }

    "worker-instance-1" = {
      image              = data.ibm_is_image.ubuntu.id
      profile            = var.bx2-4x16
      vpc_id             = module.Network.VPC.id
      zone               = var.zone_eu_gb_2
      ssh_key_id         = module.Security.ssh_key["private-ssh-key"].id
      security_groups_id = module.Security.security_group["private-worker"].id
      subnet_id          = module.Network.subnets["private-subnet-1"].id
      ip                 = "192.168.2.11"
    }

    "worker-instance-2" = {
      image              = data.ibm_is_image.ubuntu.id
      profile            = var.bx2-4x16
      vpc_id             = module.Network.VPC.id
      zone               = var.zone_eu_gb_3
      ssh_key_id         = module.Security.ssh_key["private-ssh-key"].id
      security_groups_id = module.Security.security_group["private-worker"].id
      subnet_id          = module.Network.subnets["private-subnet-2"].id
      ip                 = "192.168.3.10"
    }
  }
}