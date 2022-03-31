module "px_rancher_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.px_rancher_sg}"
  description = "Security group for web servrs with custom ports open within VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp", "http-80-tcp", "ssh-tcp", "all-all"]
  egress_rules             = ["all-all"]
}