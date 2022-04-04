output "vpc_arn" {
  value = module.px_poc_vpc.vpc_arn
}

output "vpc_id" {
  value = module.px_poc_vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.px_poc_vpc.vpc_cidr_block
}

output "vpc_instance_tenancy" {
  value = module.px_poc_vpc.vpc_instance_tenancy
}

output "vpc_enable_dns_support" {
  value = module.px_poc_vpc.vpc_enable_dns_support
}

output "vpc_enable_dns_hostnames" {
  value = module.px_poc_vpc.vpc_enable_dns_hostnames
}

output "vpc_main_route_table_id" {
  value = module.px_poc_vpc.vpc_main_route_table_id
}

output "default_network_acl_id" {
  value = module.px_poc_vpc.default_network_acl_id
}

output "default_security_group_id" {
  value = module.px_poc_vpc.default_security_group_id
}

output "public_subnet_ids" {
  value = module.px_poc_vpc.public_subnets
}

output "public_subnet_arns" {
  value = module.px_poc_vpc.public_subnet_arns
}

output "public_subnet_cidr_blocks" {
  value = module.px_poc_vpc.public_subnets_cidr_blocks
}

output "public_route_table_ids" {
  value = module.px_poc_vpc.public_route_table_ids
}


output "private_subnet_ids" {
  value = module.px_poc_vpc.private_subnets
}

output "private_subnet_arns" {
  value = module.px_poc_vpc.private_subnet_arns
}

output "private_subnet_cidr_blocks" {
  value = module.px_poc_vpc.private_subnets_cidr_blocks
}

output "nat_ids" {
  value = module.px_poc_vpc.nat_ids
}

output "nat_public_ips" {
  value = module.px_poc_vpc.nat_public_ips
}

output "private_route_table_ids" {
  value = module.px_poc_vpc.private_route_table_ids
}

output "private_route_table_association_ids" {
  value = module.px_poc_vpc.private_route_table_association_ids
}

output "security_group_id" {
  value = module.px_rancher_sg.security_group_id
}

output "public_ip" {
  value = aws_instance.px_rancher_instance.public_ip
}
output "public_dns_name" {
  value = aws_instance.px_rancher_instance.public_dns
}