output "security_group" {
  value = {
    for SG in ibm_is_security_group.security_groups : SG.name => 
    {
      name = SG.name
      id   = SG.id
    }
  }
}

output "ssh_key" {
  value = {
    for ssh_keys in ibm_is_ssh_key.ssh : ssh_keys.name => 
    {
      name = ssh_keys.name
      id   = ssh_keys.id
    }
  }
}
