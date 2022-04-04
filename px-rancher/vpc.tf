provider "aws" {
  region = "${var.region}"
}
module "px_poc_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"
  azs             = "${var.azs}"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  instance_tenancy        = "default"
  enable_dns_support      = true
  enable_dns_hostnames    = true
  map_public_ip_on_launch = false
  enable_nat_gateway = false
  enable_vpn_gateway = false
  single_nat_gateway  = false
  reuse_nat_ips       = false                   # <= Skip creation of EIPs for the NAT Gateways
  #external_nat_ip_ids = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}