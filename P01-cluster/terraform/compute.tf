resource "oci_core_instance" "node" {
  for_each            = toset(local.nodes)
  availability_domain = local.ad_map[each.key]
  compartment_id      = var.compartment_ocid
  display_name        = each.key
  shape               = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 8
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.cluster_subnet.id
    assign_public_ip = true
    display_name     = "vnic-${each.key}"
    hostname_label   = each.key
  }

  source_details {
    source_type             = "image"
    source_id               = local.image_id
    boot_volume_size_in_gbs = 60
  }

  agent_config {
    is_management_disabled = false
    is_monitoring_disabled = false

    plugins_config {
      name          = "Vulnerability Scanning"
      desired_state = "ENABLED"
    }
    plugins_config {
      name          = "Compute Instance Monitoring"
      desired_state = "ENABLED"
    }
    plugins_config {
      name          = "Custom Logs Monitoring"
      desired_state = "DISABLED"
    }
  }

  metadata = {
    ssh_authorized_keys = local.ssh_public_key_main
    user_data = base64encode(<<EOF
        #cloud-config
        users:
          - default
          - name: ansible
            groups: sudo
            shell: /bin/bash
            sudo: ['ALL=(ALL) NOPASSWD:ALL']
            ssh_authorized_keys:
              - ${local.ssh_public_key_ansible}
        ssh_pwauth: false
        package_update: true
        EOF
    )

  }

  lifecycle {
    ignore_changes = [source_details[0].source_id]
  }
}
