resource "ibm_is_floating_ip" "floating_IPs" {
  for_each = var.floating_IPs

  name           = each.key
  resource_group = var.resource_group_id
  target         = each.value.primary_network_interface_id # == ibm_is_instance.master_instance.primary_network_interface[0].id
  tags           = ["Name:floating-IP-${each.key}"]

}
