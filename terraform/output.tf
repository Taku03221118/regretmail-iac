#output name_services {
#    value = module.dns.name_services
#}

output nat_ip_address {
    value = module.router.address
}
