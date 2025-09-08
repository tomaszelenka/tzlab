locals {
  nodes = ["node01", "node02", "node03"]

  ad_map = {
    node01 = data.oci_identity_availability_domains.ads.availability_domains[0].name
    node02 = data.oci_identity_availability_domains.ads.availability_domains[1].name
    node03 = data.oci_identity_availability_domains.ads.availability_domains[2].name
  }

  image_id        = data.oci_core_images.ubuntu_arm.images[0].id
  ssh_public_key_main  = var.ssh_key_main_public
  ssh_public_key_ansible = var.ssh_key_ansible_public

  # ssh_key_main_path    = "~/.ssh/XXX.pub"
  # ssh_key_ansible_path = "~/.ssh/XXX.pub"
}
