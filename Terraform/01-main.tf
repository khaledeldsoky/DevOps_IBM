module "Network" {
  source              = "./01-network"
  resource_group_id   = data.ibm_resource_group.resource_group.id
  resource_group_name = data.ibm_resource_group.resource_group.name
  VPC_name            = "vpc-name"
  vpc_id              = module.Network.VPC.id

  routing_table = {
    public-routing-table = {
      name = "public-routing-table"
    }

    private-routing-table = {
      name = "private-routing-table"
    }

    private-routing-table-2 = {
      name = "private-routing-table-2"
    }

    private-routing-table-3 = {
      name = "private-routing-table-3"
    }

  }

  subnets = {
    "public-subnet" = {
      zone          = var.zone_eu_gb_2
      cidr          = var.cider_block_192_168_1
      routing_table = module.Network.routing_tables["public-routing-table"].id
    }

    "private-subnet-1" = {
      zone           = var.zone_eu_gb_2
      cidr           = var.cider_block_192_168_2
      public_gateway = module.Network.GW_id["nat-1"].id
      routing_table  = module.Network.routing_tables["private-routing-table"].id
    }

    "private-subnet-2" = {
      zone           = var.zone_eu_gb_3
      cidr           = var.cider_block_192_168_3
      public_gateway = module.Network.GW_id["nat-2"].id
      routing_table  = module.Network.routing_tables["private-routing-table-2"].id
    }

    "private-subnet-3" = {
      zone           = var.zone_eu_gb_1
      cidr           = var.cider_block_192_168_4
      public_gateway = module.Network.GW_id["nat-3"].id
      routing_table  = module.Network.routing_tables["private-routing-table-3"].id
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

    "prefix-192-168-4" = {
      cidr = var.cider_block_192_168_4
      zone = var.zone_eu_gb_1
    }

  }

  NAT = {
    "nat-1" = {
      zone = var.zone_eu_gb_2
    }
    "nat-2" = {
      zone = var.zone_eu_gb_3
    }
    "nat-3" = {
      zone = var.zone_eu_gb_1
    }
  }
}

module "Security" {
  source            = "./02-security"
  resource_group_id = data.ibm_resource_group.resource_group.id
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

    SGR_icmp_bastion_inbound = {
      group     = module.Security.security_group["public"].id
      direction = "inbound"
      remote    = "0.0.0.0/0"
    }

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


    SGR_icmp_bastion_outbound = {
      group     = module.Security.security_group["public"].id
      direction = "outbound"
      remote    = "0.0.0.0/0"
    }

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

resource "ibm_is_volume" "my_boot_volume" {
  name       = "my-boot-volume-name"
  profile    = "general-purpose"
  zone       = "eu-gb-2"
  # Update the capacity to a new, larger size
  capacity   = 1000
}

resource "ibm_is_instance_volume_attachment" "attach_data" {
  instance = module.Compute.instance["bastion-instance"].id
  volume   = ibm_is_volume.my_boot_volume.id
  name     = "data-attach"
}


module "Compute" {
  source = "./03-compute"
  floating_IPs = {
    "bastion-ip" = {
      primary_network_interface_id = module.Compute.instance["bastion-instance"].primary_network_interface[0].id
    }
  }

  resource_group_id = data.ibm_resource_group.resource_group.id
  instances = {
    "bastion-instance" = {
      # boot_volume_size   = 700
      image              = data.ibm_is_image.ubuntu.id
      profile            = var.bxf-24x96
      vpc_id             = module.Network.VPC.id
      zone               = var.zone_eu_gb_2
      ssh_key_id         = module.Security.ssh_key["public-ssh-key"].id
      security_groups_id = module.Security.security_group["public"].id
      subnet_id          = module.Network.subnets["public-subnet"].id
      ip                 = "192.168.1.12"
    }

  }



  #   "master-instance" = {
  #     image              = data.ibm_is_image.ubuntu.id
  #     profile            = var.bx2-4x16
  #     vpc_id             = module.Network.VPC.id
  #     zone               = var.zone_eu_gb_2
  #     ssh_key_id         = module.Security.ssh_key["private-ssh-key"].id
  #     security_groups_id = module.Security.security_group["private-master"].id
  #     subnet_id          = module.Network.subnets["private-subnet-1"].id
  #     ip                 = "192.168.2.10"
  #   }

  #   "worker-instance-1" = {
  #     image              = data.ibm_is_image.ubuntu.id
  #     profile            = var.bx2-4x16
  #     vpc_id             = module.Network.VPC.id
  #     zone               = var.zone_eu_gb_2
  #     ssh_key_id         = module.Security.ssh_key["private-ssh-key"].id
  #     security_groups_id = module.Security.security_group["private-worker"].id
  #     subnet_id          = module.Network.subnets["private-subnet-1"].id
  #     ip                 = "192.168.2.11"
  #   }

  #   "worker-instance-2" = {
  #     image              = data.ibm_is_image.ubuntu.id
  #     profile            = var.bx2-4x16
  #     vpc_id             = module.Network.VPC.id
  #     zone               = var.zone_eu_gb_3
  #     ssh_key_id         = module.Security.ssh_key["private-ssh-key"].id
  #     security_groups_id = module.Security.security_group["private-worker"].id
  #     subnet_id          = module.Network.subnets["private-subnet-2"].id
  #     ip                 = "192.168.3.10"
  #   }
  # }

}
