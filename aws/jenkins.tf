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

resource "aws_instance" "px_jenkins_instance" {
  
  # Lookup the correct AMI based on the region
  # we specified
  availability_zone      = "us-east-1a"
  instance_type          = "${var.instance_type}"
  #ami                    = "${data.aws_ami.centos.id}"
  ami                    = "${var.jenkins_ami_id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${module.px_jenkins_sg.security_group_id}"]
  subnet_id              = "${module.px_poc_vpc.public_subnets[0]}"
  associate_public_ip_address = true

  # Our Security group to allow HTTP and SSH access
  #user_data              = "${file("install_jenkins1.sh")}"
  #Instance tags
  root_block_device {
  volume_type= "gp2"
  volume_size= 50
  }

  tags = {
    Name = "${var.vpc_name}-jenkins"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "null_resource" "px_jenkins_deployment" {

  #provisioner "file" {
  #  source      = "./scripts"
  #  destination = "/tmp"

  #  connection {
  #    user        = "${var.user_name}"
  #    host        = "${aws_instance.jenkins_instance.public_ip}"
  #    agent       = false
  #    private_key = "${file("${var.key_path}/${var.key_private}")}"
  #  }
  #}

  provisioner "remote-exec" {
    inline = [
      "curl --silent --location http://pkg.jenkins.io/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo",
      "sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum update -y",
      "sudo yum install epel-release -y",
      "sudo yum install git -y",
      "git clone https://github.com/panchnayak/portworx-poc.git",
      "cp -r ./portworx-poc/px-jenkins/scripts .",
      "sudo mkdir -p /var/lib/jenkins/init.groovy.d",
      "sudo cp ./scripts/jenkins-create-admin.groovy /var/lib/jenkins/init.groovy.d",
      "cd scripts",
      "chmod +x install-jenkins.sh init-jenkins.sh install-tools.sh install-plugins.sh create-pipeline.sh",
      "/tmp/scripts/install-jenkins.sh",
      #setting up JAVA_HOME path for all users
      "export JAVA_HOME=/usr/lib/jvm/openjdk11",
      "export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.",
      "export PATH=$PATH:$JAVA_HOME/bin:.",
      ".scripts/init-jenkins.sh",
      "./scripts/install-tools.sh",
      "./scripts/install-plugins.sh ${var.jenkins_username} ${var.jenkins_password}",
      "sudo systemctl restart jenkins",
      "./scripts/create-pipeline.sh ${var.jenkins_username} ${var.jenkins_password}"
    ]

    connection {
      user        = "${var.user_name}"
      host        = "${aws_instance.px_jenkins_instance.public_ip}"
      agent       = false
      private_key = "${file("${var.key_path}/${var.key_private}")}"
    }

  }
}