output "vpc_arn" {
  value = module.px_poc_vpc.vpc_arn
}

output "vpc_id" {
  value = module.px_poc_vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.px_poc_vpc.vpc_cidr_block
}

output "vpc_enable_dns_support" {
  value = module.px_poc_vpc.vpc_enable_dns_support
}

output "vpc_enable_dns_hostnames" {
  value = module.px_poc_vpc.vpc_enable_dns_hostnames
}

output "public_subnet_cidr_blocks" {
  value = module.px_poc_vpc.public_subnets_cidr_blocks
}

output "public_ip" {
  value = aws_instance.px_rancher_instance.public_ip
}
output "public_dns_name" {
  value = aws_instance.px_rancher_instance.public_dns
}

output "aws_iam_role" {
  value = resource.aws_iam_role.portworx_role.arn
}

output "aws_iam_role_policy" {
  value = resource.aws_iam_role_policy.portworx_policy.id
}

output "aws_iam_instance_profile" {
  value = resource.aws_iam_instance_profile.portworx_instance_profile.name
}