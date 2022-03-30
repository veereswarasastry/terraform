output "aws_vpc_id" {
  value = aws_vpc.ec2-exercise-vpc
}

output "aws_security_gr_id" {
  value = aws_security_group.ec2_private_sg.id
}

output "aws_subnet_subnet_1" {
  value = aws_subnet.ec2-subnet_1.id
}

output "instance_id" { 
    value = aws_instance.ec2_instance[0].id
}