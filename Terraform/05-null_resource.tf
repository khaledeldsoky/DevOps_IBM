# resource "null_resource" "generate_ssh_key" {

#   for_each = toset(var.ssh_key_names)
#   provisioner "local-exec" {
#     command = <<EOT
#       mkdir -p ./keys
#       ssh-keygen -t rsa -b 4096 -f ./keys/${each.key} -N ""
#     EOT
#   }

#   triggers = {
#     always_run = timestamp()
#   }
# }


# # you only need the command in the first time you apply the code
# # terraform apply -target=null_resource.generate_ssh_key -var-file=03-V.tfvars

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
  depends_on = [
    module.Network,
    
  ]
}

resource "null_resource" "copy_ssh_config" {
  
  provisioner "local-exec" {
    command = <<-EOF
     ../bash/ssh_config.sh ${local.bastion_ip}
      # cd ../Ansible
      # ansible-playbook main.yml
    EOF
  }

  depends_on = [module.Compute]
    triggers = {
    always_run = timestamp()
  }
}

# ../bash/ssh_config.sh ${local.bastion_ip} #${local.master_ip} ${local.worker_ip_1} ${local.worker_ip_2}