variable "aws_region" {
    default = "ap-south-1"
}

variable "vpc_cidr_range"{
    description = "CIDR Range for VPC"
}

variable "subnet_cidr_range"{
    description = "CIDR Range for Subnet"
}

variable "ec2_image_id"{
    default = "ami-07191cf2912e097a6"
}