resource "aws_vpc" "hydroscope-vpc" {
  cidr_block           = "10.0.0.0/21"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "hydroscope-vpc"
    Project = "hydroscope"
  }
}

# Private Subnets
resource "aws_subnet" "Private-subnet-1" {
  vpc_id            = aws_vpc.hydroscope-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name    = "Private-subnet-1"
    Project = "hydroscope"
  }
}

resource "aws_subnet" "Private-subnet-2" {
  vpc_id            = aws_vpc.hydroscope-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name    = "Private-subnet-2"
    Project = "hydroscope"
  }
}

resource "aws_subnet" "Private-subnet-3" {
  vpc_id            = aws_vpc.hydroscope-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name    = "Private-subnet-3"
    Project = "hydroscope"
  }
}

# Public Subnets
resource "aws_subnet" "Public-subnet-1" {
  vpc_id            = aws_vpc.hydroscope-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name    = "Public-subnet-1"
    Project = "hydroscope"
  }
}

resource "aws_subnet" "Public-subnet-2" {
  vpc_id            = aws_vpc.hydroscope-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name    = "Public-subnet-2"
    Project = "hydroscope"
  }
}

resource "aws_subnet" "Public-subnet-3" {
  vpc_id            = aws_vpc.hydroscope-vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-south-1c"

  tags = {
    Name    = "Public-subnet-3"
    Project = "hydroscope"
  }
}

resource "aws_internet_gateway" "hydroscope-igw" {
  vpc_id = aws_vpc.hydroscope-vpc.id

  tags = {
    Name    = "hydroscope-igw"
    Project = "hydroscope"
  }
}

resource "aws_eip" "hydroscope-eip" {
  domain = "vpc"

  tags = {
    Name    = "hydroscope-eip"
    Project = "hydroscope"
  }
}

resource "aws_route_table" "hydroscope-route-table-public" {
  vpc_id = aws_vpc.hydroscope-vpc.id

  tags = {
    Name    = "hydroscope-route-table-public"
    Project = "hydroscope"
  }
}

resource "aws_route" "hydroscope-route-public" {
  route_table_id         = aws_route_table.hydroscope-route-table-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.hydroscope-igw.id
}

resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.Public-subnet-1.id
  route_table_id = aws_route_table.hydroscope-route-table-public.id
}

resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.Public-subnet-2.id
  route_table_id = aws_route_table.hydroscope-route-table-public.id
}

resource "aws_route_table_association" "public-3" {
  subnet_id      = aws_subnet.Public-subnet-3.id
  route_table_id = aws_route_table.hydroscope-route-table-public.id
}

resource "aws_nat_gateway" "hydroscope-nat-gateway" {
  allocation_id = aws_eip.hydroscope-eip.id
  subnet_id     = aws_subnet.Public-subnet-1.id

  tags = {
    Name    = "hydroscope-nat-gateway"
    Project = "hydroscope"
  }
}

resource "aws_route_table" "hydroscope-route-table-private" {
  vpc_id = aws_vpc.hydroscope-vpc.id

  tags = {
    Name    = "hydroscope-route-table-private"
    Project = "hydroscope"
  }
}

resource "aws_route" "hydroscope-route-private" {
  route_table_id         = aws_route_table.hydroscope-route-table-private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.hydroscope-nat-gateway.id
}

resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.Private-subnet-1.id
  route_table_id = aws_route_table.hydroscope-route-table-private.id
}

resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.Private-subnet-2.id
  route_table_id = aws_route_table.hydroscope-route-table-private.id
}

resource "aws_route_table_association" "private-3" {
  subnet_id      = aws_subnet.Private-subnet-3.id
  route_table_id = aws_route_table.hydroscope-route-table-private.id
}
