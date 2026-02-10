variable "zone_eu_gb_1" {}
variable "zone_eu_gb_2" {}
variable "zone_eu_gb_3" {}
variable "cider_block_192_168_1" {}
variable "cider_block_192_168_2" {}
variable "cider_block_192_168_3" {}
variable "bx2-2x8" {}
variable "bx2-4x16" {}
variable "bxf-8x32" {}
variable "bxf-16x64" {}
variable "bxf-24x96" {}
variable "cx2-metal-96x192" {}    
variable "ssh_type_rsa" {}
variable "ssh_key_private_path" {}
variable "ssh_key_public_path" {}
variable "cider_block_192_168_4" {}

variable "ssh_key_names" {
  type        = list(string)
  description = "List of SSH key names to generate"
}