data "ibm_is_image" "ubuntu" {
  name = "ibm-ubuntu-22-04-5-minimal-amd64-5"
}

data "ibm_is_floating_ip" "public_ip_bastion" {
  name = "bastion-ip"
  depends_on = [
    module.Compute,
    null_resource.delay
  ]
}
