data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  # this filter is here to guarantee that ami's come from the official CentOS.org
  # we can be sure of the ami's authenticity by filtering by the products id's unique to
  # CentOS.org, which can be found on their web site at https://wiki.centos.org/Cloud/AWS
  filter {
    name = "product-code"
    values = compact(var.image_provider == "AWS" ? [
      var.release == 8 ? "47k9ia2igxpcce2bzo8u3kj03" : "", # Official `CentOS 8 (x86_64) - with Updates HVM` by AWS product id
      var.release == 7 ? "cvugziknvmxgqna9noibqnnsy" : "", # Official `CentOS 7 (x86_64) - with Updates HVM` by AWS product id
      ] : [
      var.release == 7 ? "aw0evgkw8e5c1q413zgy5pjce" : "", # Official `CentOS 7 (x86_64) - with Updates HVM` by CentOS product id
    ])
  }

  owners = ["679593333241"]

}

resource "aws_key_pair" "ssh_key_pub" {
   key_name = "${var.key_name}"
   public_key = "${file("${var.key_path}/${var.key_pub}")}"
}

resource "aws_instance" "jenkins_instance" {
  
  # Lookup the correct AMI based on the region
  # we specified
  availability_zone      = "us-east-1a"
  instance_type          = "${var.instance_type}"
  ami                    = "${data.aws_ami.centos.id}"
  #ami                    = "${var.jenkins_ami_id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${module.px_jenkins_sg.security_group_id}"]
  subnet_id              = "${module.px_poc_vpc.public_subnets[0]}"
  associate_public_ip_address = true
  iam_instance_profile = "${var.jenkins_instance_profile}"

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

  provisioner "remote-exec" {
    inline = [
      "curl --silent --location http://pkg.jenkins.io/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo",
      "sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum update -y",
      "sudo yum install epel-release -y",
      "sudo yum install git -y",
      "sudo rm -rf /tmp/portworx-poc /tmp/scripts /tmp/pipelines",
      "cd /tmp && git clone https://github.com/panchnayak/portworx-poc.git",
      "cp -r /tmp/portworx-poc/scripts .",
      "sudo mkdir -p /var/lib/jenkins/init.groovy.d",
      "sudo cp /tmp/scripts/jenkins/jenkins-create-admin.groovy /var/lib/jenkins/init.groovy.d",
      "cd /tmp/scripts/jenkins",
      "chmod +x install-jenkins.sh init-jenkins.sh install-tools.sh install-plugins.sh create-pipelines.sh",
      "./install-jenkins.sh",
      #setting up JAVA_HOME path for all users
      "export JAVA_HOME=/usr/lib/jvm/openjdk11",
      "export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.",
      "export PATH=$PATH:$JAVA_HOME/bin:.",
      "./init-jenkins.sh",
       "./install-tools.sh",
       "./install-plugins.sh ${var.jenkins_username} ${var.jenkins_password}",
      "sudo systemctl restart jenkins",
      "./create-pipelines.sh ${var.jenkins_username} ${var.jenkins_password}",
      "sleep 10s",
      "./build-pipelines.sh ${var.jenkins_username} ${var.jenkins_password}",
       "sleep 10s",
      "sudo rm -rf /tmp/portworx-poc"
    ]

    connection {
      user        = "${var.user_name}"
      host        = "${aws_instance.jenkins_instance.public_ip}"
      agent       = false
      private_key = "${file("${var.key_path}/${var.key_private}")}"
    }
  }
}


