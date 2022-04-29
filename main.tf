//This terraform file deploys Phonebook Application to five Docker Machines on EC2 Instances  which are ready for Docker Swarm operations. Docker Machines will run on Amazon Linux 2  with custom security group allowing SSH (22), HTTP (80) UDP (4789, 7946),  and TCP(2377, 7946, 8080) connections from anywhere.
//User needs to select appropriate key name when launching the template.
/*
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.60.0"
    }
  }
}
*/

provider "aws" {
  region = "eu-central-1"
  //  access_key = ""
  //  secret_key = ""
  //  If you have entered your credentials in AWS CLI before, you do not need to use these arguments.
}

data "aws_ami" "amazon-linux-2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }

}

resource "aws_instance" "tf-flask-ec2" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  key_name = "eu-central-1" # dont forget to change here (without .pem)
  security_groups = ["tf-sec-gr"]
  tags = {
    Name = "Flask-app"
  }
user_data = <<-EOF
          #! /bin/bash
          yum update -y
          yum install epel-release -y
          yum install git -y
          amazon-linux-extras install nginx1 -y
          amazon-linux-extras install docker -y
          systemctl start docker
          systemctl enable docker
          usermod -a -G docker ec2-user
          newgrp docker
          cd /home/ec2-user/
          git clone https://github.com/HsSarikaya/flask.git 
          docker build -t my-image /home/ec2-user/myflask/files/ 
          docker run -dp 5000:5000 my-image
          PUB=$(curl -s http://checkip.amazonaws.com)
          sed s/PUB/$PUB/ /home/ec2-user/myflask/nginx.conf > /home/ec2-user/default.conf
          rm -rf /etc/nginx/conf.d/default.conf
          cp /home/ec2-user/default.conf /etc/nginx/conf.d/
          systemctl restart nginx.service
          EOF
}          

resource "aws_security_group" "tf-sec-gr" {
  name = "tf-sec-gr"
  tags = {
    Name = "tf-sec-gr"
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5000
    protocol = "tcp"
    to_port = 5000
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}