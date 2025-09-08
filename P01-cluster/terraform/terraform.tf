terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0.0"
    }
  }

  cloud {

    organization = "XXX"

    workspaces {
      name = "XXX"
    }
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  fingerprint  = var.fingerprint
  # private_key_path = var.private_key_path
  private_key = var.private_key_oci
  region      = "eu-frankfurt-1"
}
