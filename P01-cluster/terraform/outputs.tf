output "public_ips" {
  description = "Public IPv4 addresses for nodes"
  value       = { for n, inst in oci_core_instance.node : n => inst.public_ip }
}

output "private_ips" {
  description = "Private IPv4 addresses for nodes"
  value = {
    for n, inst in oci_core_instance.node :
    n => inst.private_ip
  }
}

output "ad_placement" {
  description = "Availability Domains for nodes"
  value       = local.ad_map
}

output "imge_Ubuntu" {
  description = "Latest Ubuntu 24.04"
  value       = data.oci_core_images.ubuntu_arm.images[0].id
}

output "ansible_inventory" {
  value = join("\n",
    concat(
      ["[cluster_oci]"],
      [
        for name, inst in oci_core_instance.node :
        "${name} ansible_host=${inst.public_ip} private_ip=${inst.private_ip} ansible_user=ansible"
      ],
      ["", "[all:vars]", "ansible_python_interpreter=/usr/bin/python3"]
    )
  )
}

# Generate Ansible inventory file locally:
# terraform output -raw ansible_inventory > inventory.ini
