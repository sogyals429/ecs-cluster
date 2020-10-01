output "aws_vpc_id" {
  value = aws_vpc.main.id
  description = "VPC ID for Main VPC"
}

output "aws_private_subnets" {
  value = aws_subnet.private.*.id
  description = "Private Subnets for VPC"
}