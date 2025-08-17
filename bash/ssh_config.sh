cat << EOF > ~/.ssh/config
Host bastion
    HostName $1
    User ubuntu
    IdentityFile /home/khaled/khaled/Project_DevOps/Infra/Terraform/keys/public
    StrictHostKeyChecking no

Host master
    HostName $2
    User ubuntu
    IdentityFile /home/khaled/khaled/Project_DevOps/Infra/Terraform/keys/private
    ProxyCommand ssh -q -W %h:%p bastion
    StrictHostKeyChecking no

Host worker-1
    HostName $3
    User ubuntu
    IdentityFile /home/khaled/khaled/Project_DevOps/Infra/Terraform/keys/private
    ProxyCommand ssh -q -W %h:%p bastion
    StrictHostKeyChecking no

Host worker-2
    HostName $4
    User ubuntu
    IdentityFile /home/khaled/khaled/Project_DevOps/Infra/Terraform/keys/private
    ProxyCommand ssh -q -W %h:%p bastion
    StrictHostKeyChecking no
EOF