resource "ibm_is_ssh_key" "ssh" {
  for_each = var.ssh_key

  name       = each.key
  public_key = file("${each.value.path}")
  type       = each.value.ssh_type

  tags = ["Name:ssh-${each.key}"]
}

