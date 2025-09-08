resource "oci_network_load_balancer_network_load_balancer" "lb" {
  compartment_id = var.compartment_ocid
  display_name   = "lb-cluster"
  subnet_id      = oci_core_subnet.cluster_subnet.id
  is_private     = false
}


resource "oci_network_load_balancer_backend_set" "bs443" {
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.lb.id
  name                     = "bs-443"
  policy                   = "THREE_TUPLE"
  health_checker {
    protocol = "TCP"
    port     = 443
    # url_path = "/ping"
    # return_code = 200
   
}
}

# resource "oci_network_load_balancer_backend_set" "bs80" {
#   network_load_balancer_id = oci_network_load_balancer_network_load_balancer.lb.id
#   name                     = "bs-80"
#   policy                   = "THREE_TUPLE"
#   health_checker {
#     protocol = "TCP"
#     port     = 80
#     # url_path = "/ping"
#     # return_code = 200
   
# }
# }


# resource "oci_network_load_balancer_backend" "backends80" {
#   for_each                 = oci_core_instance.node
#   network_load_balancer_id = oci_network_load_balancer_network_load_balancer.lb.id
#   backend_set_name         = oci_network_load_balancer_backend_set.bs80.name
#   ip_address               = each.value.private_ip
#   port                     = 80
#   weight                   = 1
  
# }

resource "oci_network_load_balancer_backend" "backends443" {
  for_each                 = oci_core_instance.node
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.lb.id
  backend_set_name         = oci_network_load_balancer_backend_set.bs443.name
  ip_address               = each.value.private_ip
  port                     = 443
  weight                   = 1
  
}

resource "oci_network_load_balancer_listener" "l443" {
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.lb.id
  name                     = "tcp-443"
  default_backend_set_name = oci_network_load_balancer_backend_set.bs443.name
  port                     = 443
  protocol                 = "TCP"
  
}

# resource "oci_network_load_balancer_listener" "l80" {
#   network_load_balancer_id = oci_network_load_balancer_network_load_balancer.lb.id
#   name                     = "tcp-80"
#   default_backend_set_name = oci_network_load_balancer_backend_set.bs80.name
#   port                     = 80
#   protocol                 = "TCP"
  
# }