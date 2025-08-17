locals {
  master_ip = module.Compute.instance["master-instance"].primary_network_interface[0].primary_ipv4_address

  worker_ip_1 = module.Compute.instance["worker-instance-1"].primary_network_interface[0].primary_ipv4_address

  worker_ip_2 = module.Compute.instance["worker-instance-2"].primary_network_interface[0].primary_ipv4_address

  bastion_ip = data.ibm_is_floating_ip.public_ip_bastion.address

  TCP = [

    # ----------------------------- bastion  ----------------------------- #
    { type = "TCP", group_name = "public", remote = "0.0.0.0/0", direction = "inbound", name = "ssh", port_min = 22, port_max = 22 },
    { type = "TCP", group_name = "public", remote = "0.0.0.0/0", direction = "inbound", name = "DNS", port_min = 53, port_max = 53 },
    { type = "TCP", group_name = "public", remote = "0.0.0.0/0", direction = "inbound", name = "http", port_min = 80, port_max = 80 },
    { type = "TCP", group_name = "public", remote = "0.0.0.0/0", direction = "inbound", name = "https", port_min = 443, port_max = 443 },

    { type = "TCP", group_name = "public", remote = "0.0.0.0/0", direction = "outbound", name = "ssh", port_min = 22, port_max = 22 },
    { type = "TCP", group_name = "public", remote = "0.0.0.0/0", direction = "outbound", name = "DNS", port_min = 53, port_max = 53 },
    { type = "TCP", group_name = "public", remote = "0.0.0.0/0", direction = "outbound", name = "http", port_min = 80, port_max = 80 },
    { type = "TCP", group_name = "public", remote = "0.0.0.0/0", direction = "outbound", name = "https", port_min = 443, port_max = 443 },
    # ----------------------------- master  ----------------------------- #
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "ssh", port_min = 22, port_max = 22 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "DNS", port_min = 53, port_max = 53 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "http", port_min = 80, port_max = 80 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "https", port_min = 443, port_max = 443 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "2379", port_min = 2379, port_max = 2380 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "6443", port_min = 6443, port_max = 6443 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "6783", port_min = 6783, port_max = 6783 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "8080", port_min = 8080, port_max = 8080 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "9000", port_min = 9000, port_max = 9000 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "9999", port_min = 9999, port_max = 9999 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "10250", port_min = 10250, port_max = 10250 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "10251", port_min = 10251, port_max = 10251 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "10252", port_min = 10252, port_max = 10252 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "12252", port_min = 12252, port_max = 12252 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "22623", port_min = 22623, port_max = 22623 },


    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "ssh", port_min = 22, port_max = 22 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "DNS", port_min = 53, port_max = 53 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "http", port_min = 80, port_max = 80 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "https", port_min = 443, port_max = 443 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "6443", port_min = 6443, port_max = 6443 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "6783", port_min = 6783, port_max = 6783 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "8080", port_min = 8080, port_max = 8080 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "9000", port_min = 9000, port_max = 9000 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "9999", port_min = 9999, port_max = 9999 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "10250", port_min = 10250, port_max = 10250 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "10251", port_min = 10251, port_max = 10251 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "10252", port_min = 10252, port_max = 10252 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "12252", port_min = 12252, port_max = 12252 },
    { type = "TCP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "22623", port_min = 22623, port_max = 22623 },


    # ----------------------------- node  ----------------------------- #
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "ssh", port_min = 22, port_max = 22 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "DNS", port_min = 53, port_max = 53 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "http", port_min = 80, port_max = 80 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "https", port_min = 443, port_max = 443 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "6783", port_min = 6783, port_max = 6783 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "6443", port_min = 6443, port_max = 6443 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "8080", port_min = 8080, port_max = 8080 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "10250", port_min = 10250, port_max = 10250 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "10251", port_min = 10251, port_max = 10251 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "10252", port_min = 10252, port_max = 10252 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "2379_to_2380", port_min = 2379, port_max = 2380 },
    

    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "ssh", port_min = 22, port_max = 22 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "DNS", port_min = 53, port_max = 53 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "http", port_min = 80, port_max = 80 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "https", port_min = 443, port_max = 443 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "6783", port_min = 6783, port_max = 6783 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "8080", port_min = 8080, port_max = 8080 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "10250", port_min = 10250, port_max = 10250 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "10251", port_min = 10251, port_max = 10251 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "10252", port_min = 10252, port_max = 10252 },
    { type = "TCP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "6443", port_min = 6443, port_max = 6443 },

  ]

  UDP = [

    # ----------------------------- master  ----------------------------- #
    { type = "UDP", group_name = "private-master", remote = "0.0.0.0/0", direction = "inbound", name = "6783", port_min = 6783, port_max = 6783 },

    { type = "UDP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "6783", port_min = 6783, port_max = 6783 },
    { type = "UDP", group_name = "private-master", remote = "0.0.0.0/0", direction = "outbound", name = "6784", port_min = 6783, port_max = 6784 },

    # ----------------------------- node  ----------------------------- #
    { type = "UDP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "inbound", name = "6783", port_min = 6783, port_max = 6783 },

    { type = "UDP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "6783", port_min = 6783, port_max = 6783 },
    { type = "UDP", group_name = "private-worker", remote = "0.0.0.0/0", direction = "outbound", name = "6784", port_min = 6783, port_max = 6784 },
  ]



}




# locals {
#   SGR_tcp = {
#     "public-inbound-ssh" : { group : "public", direction : "inbound", remote : "0.0.0.0/0", port_max : 22, port_min : 22 },
#     "public-inbound-DNS" : { group : "public", direction : "inbound", remote : "0.0.0.0/0", port_min : 53, port_max : 53 },
#     "public-inbound-http" : { group : "public", direction : "inbound", remote : "0.0.0.0/0", port_max : 80, port_min : 80 },
#     "public-inbound-https" : { group : "public", direction : "inbound", remote : "0.0.0.0/0", port_min : 443, port_max : 443 },

#     "public-outbound-ssh" : { group : "public", direction : "outbound", remote : "0.0.0.0/0", port_max : 22, port_min : 22 },
#     "public-outbound-DNS" : { group : "public", direction : "outbound", remote : "0.0.0.0/0", port_min : 53, port_max : 53 },
#     "public-outbound-http" : { group : "public", direction : "outbound", remote : "0.0.0.0/0", port_max : 80, port_min : 80 },
#     "public-outbound-https" : { group : "public", direction : "outbound", remote : "0.0.0.0/0", port_min : 443, port_max : 443 },

#     "private-master-inbound-ssh" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_max : 22, port_min : 22 },
#     "private-master-inbound-DNS" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_min : 53, port_max : 53 },
#     "private-master-inbound-http" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_max : 80, port_min : 80 },
#     "private-master-inbound-6443" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_min : 6443, port_max : 6443 },
#     "private-master-inbound-2379" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_min : 2379, port_max : 2380 },
#     "private-master-inbound-6783" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_min : 6783, port_max : 6783 },
#     "private-master-inbound-https" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_min : 443, port_max : 443 },
#     "private-master-inbound-10250" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_min : 10250, port_max : 10250 },
#     "private-master-inbound-10251" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_min : 10251, port_max : 10251 },
#     "private-master-inbound-10252" : { group : "private-master", direction : "inbound", remote : "0.0.0.0/0", port_min : 10252, port_max : 10252 },

#     "private-master-outbound-ssh" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_max : 22, port_min : 22 },
#     "private-master-outbound-DNS" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_min : 53, port_max : 53 },
#     "private-master-outbound-http" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_max : 80, port_min : 80 },
#     "private-master-outbound-6443" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_min : 6443, port_max : 6443 },
#     "private-master-outbound-2379" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_min : 2379, port_max : 2380 },
#     "private-master-outbound-6783" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_min : 6783, port_max : 6783 },
#     "private-master-outbound-https" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_min : 443, port_max : 443 },
#     "private-master-outbound-10250" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_min : 10250, port_max : 10250 },
#     "private-master-outbound-10251" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_min : 10251, port_max : 10251 },
#     "private-master-outbound-10252" : { group : "private-master", direction : "outbound", remote : "0.0.0.0/0", port_min : 10252, port_max : 10252 },

#     "private-worker-inbound-ssh" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_max : 22, port_min : 22 },
#     "private-worker-inbound-DNS" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_min : 53, port_max : 53 },
#     "private-worker-inbound-http" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_max : 80, port_min : 80 },
#     "private-worker-inbound-6443" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_min : 6443, port_max : 6443 },
#     "private-worker-inbound-2379" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_min : 2379, port_max : 2380 },
#     "private-worker-inbound-6783" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_min : 6783, port_max : 6783 },
#     "private-worker-inbound-https" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_min : 443, port_max : 443 },
#     "private-worker-inbound-10250" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_min : 10250, port_max : 10250 },
#     "private-worker-inbound-10251" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_min : 10251, port_max : 10251 },
#     "private-worker-inbound-10252" : { group : "private-worker", direction : "inbound", remote : "0.0.0.0/0", port_min : 10252, port_max : 10252 },

#     "private-worker-outbound-ssh" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_max : 22, port_min : 22 },
#     "private-worker-outbound-DNS" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_min : 53, port_max : 53 },
#     "private-worker-outbound-http" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_max : 80, port_min : 80 },
#     "private-worker-outbound-6443" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_min : 6443, port_max : 6443 },
#     "private-worker-outbound-2379" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_min : 2379, port_max : 2380 },
#     "private-worker-outbound-6783" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_min : 6783, port_max : 6783 },
#     "private-worker-outbound-https" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_min : 443, port_max : 443 },
#     "private-worker-outbound-10250" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_min : 10250, port_max : 10250 },
#     "private-worker-outbound-10251" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_min : 10251, port_max : 10251 },
#     "private-worker-outbound-10252" : { group : "private-worker", direction : "outbound", remote : "0.0.0.0/0", port_min : 10252, port_max : 10252 },
#   }

#   SGR_udp = {
#     "private-master-inbound-6783" : { group : "private-master", remote : "0.0.0.0/0", direction : "inbound", name : "6783", port_min : 6783, port_max : 6783 },

#     "private-master-outbound-6783" : { group : "private-master", remote : "0.0.0.0/0", direction : "outbound", name : "6783", port_min : 6783, port_max : 6783 },
#     "private-master-outbound-6784" : { group : "private-master", remote : "0.0.0.0/0", direction : "outbound", name : "6784", port_min : 6783, port_max : 6784 },

#     "private-worker-inound-6783" : { group : "private-worker", remote : "0.0.0.0/0", direction : "inbound", name : "6783", port_min : 6783, port_max : 6783 },

#     "private-worker-outbound-6783" : { group : "private-worker", remote : "0.0.0.0/0", direction : "outbound", name : "6783", port_min : 6783, port_max : 6783 },
#     "private-worker-outbound-6784" : { group : "private-worker", remote : "0.0.0.0/0", direction : "outbound", name : "6784", port_min : 6783, port_max : 6784 },
#   }

# }
