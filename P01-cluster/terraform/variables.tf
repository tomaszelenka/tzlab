variable "region" {
  description = "OCI region"
  type = string
  default = "eu-frankfurt-1"
}

variable "tenancy_ocid" {
  description = "OCID tenant"
  type        = string
}

variable "user_ocid" {
  description = "OCID user"
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint API key"
  type        = string
}

variable "compartment_ocid" {
  description = "OCID compartment"
  type        = string
}

variable "private_key_oci" {
  description = "Private key OCI path"
  type        = string
}

# variable "public_key_path" {
#   description = "Public key OCI path"
#   type        = string
# }

variable "ssh_key_main_public" {
  description = "Public SSH key for main user"
  type        = string
}

variable "ssh_key_ansible_public" {
  description = "Public SSH key for ansible user"
  type        = string
}

variable "ssh_source_ip" {
  description = "Source IP SSH client"
  type        = string
}

variable "vcn_ip" {
  description = "VCN IP Oracle"
  type        = string
}