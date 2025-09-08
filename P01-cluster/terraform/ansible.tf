resource "local_file" "ansible_inventory" {
  filename = "inventory.ini"

  content = join("\n",
    concat(
      ["[cluster_oci]"],
      [
        for name, inst in oci_core_instance.node :
        "${name} ansible_host=${inst.public_ip} ansible_user=ansible"
      ],
      [
        "",
        "[all:vars]",
        "ansible_python_interpreter=/usr/bin/python3"
      ]
    )
  )
}
