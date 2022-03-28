
module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  name = "${var.vpc_name}-instance"

  availability_zone      = "us-east-1a"

  ami                    = "${var.aws_ami_id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  
  vpc_security_group_ids = ["${module.rancher-sg.security_group_id}"]
  subnet_id              = "${module.vpc.public_subnets[0]}"
  associate_public_ip_address = true
  monitoring             = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_key_pair" "ssh_key_pub" {
   key_name = "${var.key_name}"
   public_key = "${file("${var.key_path}/${var.key_pub}")}"
}
resource "null_resource" "rancher_cluster" {

  provisioner "file" {
    source      = "rancher-cluster.sh"
    destination = "/tmp/rancher-cluster.sh"

    connection {
      user        = "ec2-user"
      host        = "${module.ec2_cluster.public_ip}"
      agent       = false
      private_key = "${file("${var.key_path}/${var.key_private}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "chmod +x /tmp/rancher-cluster.sh",
      "/tmp/rancher-cluster.sh ${module.ec2_cluster.public_ip}"
    ]

    connection {
      user        = "${var.user_name}"
      host        = "${module.ec2_cluster.public_ip}"
      agent       = false
      private_key = "${file("${var.key_path}/${var.key_private}")}"
    }

  }
}