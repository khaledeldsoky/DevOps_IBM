variable "zone_eu_gb_2" {}
variable "zone_eu_gb_3" {}
variable "cider_block_192_168_1" {}
variable "cider_block_192_168_2" {}
variable "cider_block_192_168_3" {}
variable "bx2-2x8" {}
variable "bx2-4x16" {}
variable "ssh_type_rsa" {}
variable "ssh_key_private_path" {}
variable "ssh_key_public_path" {}
variable "ssh_key_names" {
  type        = list(string)
  description = "List of SSH key names to generate"
}