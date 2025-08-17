mkdir -p ./keys

ssh-keygen -t rsa -b 4096 -f ./keys/${each.key} -N ""

chmod +x ../bash/ssh_config.sh 

terraform init
terraform apply -var-file=03-V.tfvars