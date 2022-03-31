## If you change this variable, You have to change in your AWS credential file:
variable "vpc_name" {
  default = "px-vpc"
}
variable "key_name" {
  default = "rancher-keypair"
}

variable "region" {
  default = "us-east-1"
}

variable "azs" {
  default = ["us-east-1a"]
  type    = list
}

variable "env" {
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "volume_size" {
  default = 15
}

variable "aws_ami_id" {
  default = "ami-033b95fb8079dc481"
}

variable "instance_type" {
  default = "t3.large"
}

variable "user_name" {
  type = string
  default = "centos"
}

variable "key_pub" {
  default = "id_rsa.pub"
}

variable "key_private" {
  default = "id_rsa"
}

variable "key_path" {
  default = "~/.ssh"
}

variable "px_rancher_sg" {
  default = "rancher-server-sg"
}

variable "px_rancher_policy" {
  default = "px-policy-pnayak"
}

variable "px_rancher_role" {
  default = "px-jenkins-role"
}
variable "px_rancher_instance_profile" {
  default = "px-rancher-instance-profile"
}
