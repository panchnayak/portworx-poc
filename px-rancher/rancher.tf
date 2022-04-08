
data "aws_ami" "centos" {
owners      = ["679593333241"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

resource "aws_key_pair" "ssh_key_pub" {
   key_name = "${var.key_name}"
   public_key = "${file("${var.key_path}/${var.key_pub}")}"
}

resource "aws_instance" "px_rancher_instance" {
  
  # Lookup the correct AMI based on the region
  # we specified
  availability_zone      = "us-east-1a"
  instance_type          = "${var.instance_type}"
  ami                    = "${data.aws_ami.centos.id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${module.px_rancher_sg.security_group_id}"]
  subnet_id              = "${module.px_poc_vpc.public_subnets[0]}"
  associate_public_ip_address = true
  iam_instance_profile = "${var.portworx_instance_profile}"

  #Instance tags
  root_block_device {
  volume_type= "gp2"
  volume_size= 50
  }

  tags = {
    Name = "${var.vpc_name}-rancher"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "null_resource" "rancher_cluster" {

  provisioner "file" {
    source      = "rancher-cluster.sh"
    destination = "/tmp/rancher-cluster.sh"

    connection {
      user        = "${var.user_name}"
      host        = "${aws_instance.px_rancher_instance.public_ip}"
      agent       = false
      private_key = "${file("${var.key_path}/${var.key_private}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo curl -sSL https://get.docker.com | bash",
      "sudo usermod -a -G docker centos",
      "sudo systemctl enable docker --now",
      "chmod +x /tmp/rancher-cluster.sh",
      "/tmp/rancher-cluster.sh ${aws_instance.px_rancher_instance.public_ip}"
    ]

    connection {
      user        = "${var.user_name}"
      host        = "${aws_instance.px_rancher_instance.public_ip}"
      agent       = false
      private_key = "${file("${var.key_path}/${var.key_private}")}"
    }

  }
}