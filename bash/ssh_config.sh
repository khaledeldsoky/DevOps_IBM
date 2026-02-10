cat << EOF > ~/.ssh/config
Host bastion
    HostName $1
    User ubuntu
    IdentityFile /home/khaled/khaled/Project_DevOps/Infra/Terraform/keys/public
    StrictHostKeyChecking no

# Host master
#     HostName $2
#     User ubuntu
#     IdentityFile /home/khaled/khaled/Project_DevOps/Infra/Terraform/keys/private
#     ProxyCommand ssh -q -W %h:%p bastion
#     StrictHostKeyChecking no

# Host worker-1
#     HostName $3
#     User ubuntu
#     IdentityFile /home/khaled/khaled/Project_DevOps/Infra/Terraform/keys/private
#     ProxyCommand ssh -q -W %h:%p bastion
#     StrictHostKeyChecking no

# Host worker-2
#     HostName $4
#     User ubuntu
#     IdentityFile /home/khaled/khaled/Project_DevOps/Infra/Terraform/keys/private
#     ProxyCommand ssh -q -W %h:%p bastion
#     StrictHostKeyChecking no
EOF

# sudo virt-install   --name bootstrap   --ram 8192   --vcpus 4   --disk path=/var/lib/libvirt/images/bootstrap.qcow2,size=60   --cdrom /var/lib/libvirt/boot/rhcos-live.x86_64.iso   --network bridge=br0   --os-variant rhel9.0   --graphics none   --console pty,target_type=serial

# 
# sudo virt-install --name bootstrap --ram 16384 --vcpus 4 --disk path=/var/lib/libvirt/images/bootstrap.qcow2,size=120 --cdrom /var/lib/libvirt/boot/rhcos-live.x86_64.iso --network bridge=virbr0,mac=52:54:00:aa:01:01 --os-variant rhel9.0   --graphics none   --console pty,target_type=serial
# sudo virt-install --name bootstrap --ram 16384 --vcpus 4 --disk path=/mnt/vdd/bootstrap.qcow2,size=120 --cdrom /var/lib/libvirt/boot/rhcos-live.x86_64.iso --network bridge=virbr0,mac=52:54:00:aa:01:01 --os-variant rhel9.0   --graphics none   --console pty,target_type=serial

# ignition.config.url=http://192.168.122.1/ignition/bootstrap.ign

# 
# sudo virt-install   --name master  --ram 16384   --vcpus 4   --disk path=/var/lib/libvirt/images/master.qcow2,size=120   --cdrom /var/lib/libvirt/boot/rhcos-live.x86_64.iso   --network bridge=virbr0,mac=52:54:00:aa:01:02   --os-variant rhel9.0   --graphics none   --console pty,target_type=serial
# sudo virt-install   --name master  --ram 16384   --vcpus 4   --disk path=/mnt/vdd/master.qcow2,size=120   --cdrom /var/lib/libvirt/boot/rhcos-live.x86_64.iso   --network bridge=virbr0,mac=52:54:00:aa:01:02   --os-variant rhel9.0   --graphics none   --console pty,target_type=serial
# sudo virt-install   --name bootstrap   --ram 8192   --vcpus 4   --disk path=/mnt/vdd/master.qcow2,size=120  --os-variant rhel8.0   --network network=default   --graphics none   --cdrom /var/lib/libvirt/images/rhcos-live.iso
# ignition.config.url=http://192.168.122.1/ignition/master.ign 

# /images/pxeboot/vmlinuz initrd=/images/pxeboot/initrd.img rw coreos.liveiso=rhcos-416.94.202501270445-0 ignition.firstboot ignition.platform.id=metal ignition.config.url=http://192.168.122.1/ignition/bootstrap.ign
# /images/pxeboot/vmlinuz initrd=/images/pxeboot/initrd.img,/images/ignition.img rw coreos.liveiso=rhcos-416.94.202501270445-0 ignition.firstboot ignition.platform.id=metal  ignition.config.url=http://192.168.122.1/ignition/master.ign 