## Create VPC ##

resource "aws_vpc" "ec2-exercise-vpc" {
  cidr_block           = "${var.vpc_cidr_range}"
  enable_dns_hostnames = true
  tags = {
    Name = "ec2-demo-vpc"
  }
}

## Security Group##
resource "aws_security_group" "ec2_private_sg" {
  description = "Allow limited inbound external traffic"
  vpc_id      = aws_vpc.ec2-exercise-vpc.id
  name        = "_ec2_private_sg"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "ec2-private-sg"
  }
}

## Create Subnets ##
resource "aws_subnet" "ec2-subnet_1" {
  vpc_id            = aws_vpc.ec2-exercise-vpc.id
  cidr_block        = "${var.subnet_cidr_range}"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "terraform-subnet_1"
  }
}

resource "aws_instance" "ec2_instance" {
  ami                         = "${var.ec2_image_id}"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.ec2_private_sg.id}"]
  subnet_id                   = aws_subnet.ec2-subnet_1.id
  count                       = 1
  associate_public_ip_address = true
  tags = {
    Name        = "terraform_ec2"
    Environment = "development"
    Project     = "DEMO-TERRAFORM"
  }
}