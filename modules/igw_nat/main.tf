variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = { Name = "hydroscope-igw" }
}

resource "aws_eip" "eip" {
  domain = "vpc"
  tags = { Name = "hydroscope-eip" }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.public_subnet_ids[0]
  tags = { Name = "hydroscope-nat" }
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}
