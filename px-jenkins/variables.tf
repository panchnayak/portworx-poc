## If you change this variable, You have to change in your AWS credential file:

variable "key_name" {
  default = "jenkins-keypair"
}

variable "env" {
  default = "dev"
}

variable "region" {
    default="us-east-1"
}

variable "vpc_name" {
  default = "px-jenkins-vpc"
}
variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
  type    = list
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "px_jenkins_sg" {
    default="px_jenkins_server_sg"
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

variable "px_jenkin_policy" {
  default = "px-policy-pnayak"
}

variable "px_jenkins_role" {
  default = "px-jenkins-role"
}
variable "px_jenkins_instance_profile" {
  default = "px-jenkins-instance-profile"
}

variable "curlimage" {
  default = "appropriate/curl"
}

variable "jqimage" {
  default = "stedolan/jq"
}


variable "java_home" {
  default = "/usr/lib/jvm/openjdk11"
}

variable "jenkins_username" {
  default = "admin"
}

variable "jenkins_password" {
  default = "password"
}

variable "jenkins_ami_id" {
  default = "ami-0e306787811345859"
}


