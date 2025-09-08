resource "oci_core_vcn" "cluster_net" {
  compartment_id = var.compartment_ocid
  cidr_block     = "XXX/24"
  display_name   = "cluster-net"
  dns_label      = "clusternet"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.cluster_net.id
  display_name   = "igw-cluster"
  enabled        = true
}

resource "oci_core_route_table" "rt_public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.cluster_net.id
  display_name   = "rt-public"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_security_list" "sl_public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.cluster_net.id
  display_name   = "sl-public"

  ingress_security_rules {
    protocol = "1"
    source   = "0.0.0.0/0"
    icmp_options {
      type = 8
    }
    description = "Allow ICMP type 8 (ping) from anywhere"
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.ssh_source_ip
    tcp_options {
      min = 22
      max = 22
    }
    description = "Allow SSH (TCP 22) from specified source IP"
  }

  # 80 -> 443
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
    description = "Allow HTTP (TCP 80) from anywhere"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
    description = "Allow HTTPS (TCP 443) from anywhere"
  }

  #CEPHv2
  ingress_security_rules {
    protocol = "6"
    source   = var.vcn_ip
    tcp_options {
      min = 3300
      max = 3300
    }
    description = "Allow Ceph v2 (TCP 3300) from within VCN"
  }

  #MicroCeph API
  ingress_security_rules {
    protocol = "6"
    source   = var.vcn_ip
    tcp_options {
      min = 7443
      max = 7443
    }
    description = "Allow MicroCeph API (TCP 7443) from within VCN"
  }

  #CEPHv1
  ingress_security_rules {
    protocol = "6"
    source   = var.vcn_ip
    tcp_options {
      min = 6789
      max = 6789
    }
    description = "Allow Ceph v1 (TCP 6789) from within VCN"
  }

  # Ceph OSD/MDS/mgr (dynamic range TCP 6800-7300)
  ingress_security_rules {
    protocol = "6"
    source   = var.vcn_ip
    tcp_options {
      min = 6800
      max = 7300
    }
    description = "Allow Ceph OSD/MDS/mgr (TCP 6800-7300) from within VCN"
  }

  # Swarm management (TCP 2377)
  ingress_security_rules {
    protocol = "6"        # TCP
    source   = var.vcn_ip
    tcp_options {
      min = 2377
      max = 2377
    }
    description = "Allow Docker Swarm management (TCP 2377) from within VCN"
  }

  # Swarm gossip (TCP 7946)
  ingress_security_rules {
    protocol = "6" # TCP
    source   = var.vcn_ip
    tcp_options {
      min = 7946
      max = 7946
    }
    description = "Allow Docker Swarm gossip (TCP 7946) from within VCN"
  }

  # Swarm gossip (UDP 7946)
  ingress_security_rules {
    protocol = "17" # UDP
    source   = var.vcn_ip
    udp_options {
      min = 7946
      max = 7946
    }
    description = "Allow Docker Swarm gossip (UDP 7946) from within VCN"
  }

  # Swarm VXLAN / overlay (UDP 4789)
  ingress_security_rules {
    protocol = "17" # UDP
    source   = var.vcn_ip
    udp_options {
      min = 4789
      max = 4789
    }
    description = "Allow Docker Swarm VXLAN overlay (UDP 4789) from within VCN"
  }

  # Swarm overlay encrypted
  ingress_security_rules {
    protocol    = "50" # UDP
    source      = var.vcn_ip
    description = "Allow Docker Swarm overlay encrypted (IPSec ESP) from within VCN"
  }

  # node-exporter (host-published)
  ingress_security_rules {
    protocol    = "50" # UDP
    source      = var.vcn_ip
    description = "Allow Docker Swarm overlay encrypted (IPSec ESP) from within VCN"
  }

  # Swarm overlay encrypted
  ingress_security_rules {
    protocol    = "50" # UDP
    source      = var.vcn_ip
    description = "Allow Docker Swarm overlay encrypted (IPSec ESP) from within VCN"
  }

  # node-exporter (host-published)
  ingress_security_rules {
    protocol = "6" # TCP
    source   = var.vcn_ip
    tcp_options {
      min = 9100
      max = 9100
    }
    description = "Allow node-exporter (UDP 9100) from within VCN"
  }

  # cAdvisor (host-published)
  ingress_security_rules {
    protocol = "6" # TCP
    source   = var.vcn_ip
    tcp_options {
      min = 8080
      max = 8080
    }
    description = "Allow cAdvisor (UDP 8080) from within VCN"
  }


  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "cluster_subnet" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.cluster_net.id
  display_name               = "cluster-subnet"
  cidr_block                 = "XXX/24"
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.rt_public.id
  security_list_ids          = [oci_core_security_list.sl_public.id]
  dns_label                  = "clustersub"
}
