output "vpc_id" {
  value = aws_vpc.hydroscope-vpc.id
}

output "private_subnets" {
  value = [
    aws_subnet.Private-subnet-1.id,
    aws_subnet.Private-subnet-2.id,
    aws_subnet.Private-subnet-3.id
  ]
}

output "public_subnets" {
  value = [
    aws_subnet.Public-subnet-1.id,
    aws_subnet.Public-subnet-2.id,
    aws_subnet.Public-subnet-3.id
  ]
}

output "public_subnet_1" {
  value = aws_subnet.Public-subnet-1.id
}
