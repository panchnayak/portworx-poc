
module "px_jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.jenkins_sg}"
  description = "Security group for web servrs with custom ports open within VPC"
  vpc_id      = "${module.px_poc_vpc.vpc_id}"

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp", "http-80-tcp", "ssh-tcp", "all-all"]
  egress_rules             = ["all-all"]
}