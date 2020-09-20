resource "aws_vpc" "main" {
  cidr_block = "172.24.0.0/16"
  tags       = merge({ Name = "ecs-vpc" }, local.common_tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ecs-vpc.id
  tags   = merge({ Name = "ecs-igw" }, local.common_tags)
}

resource "aws_subnet" "public" {
  count                   = length(data.aws_availability_zones.available.names)
  cidr_block              = element(var.public_subnets, count.index)
  vpc_id                  = aws_vpc.ecs-vpc.id
  map_public_ip_on_launch = true
  tags                    = merge({ Name = "ecs-pub-subnet-${count.index}" }, local.common_tags)
}

resource "aws_subnet" "private" {
  count      = length(data.aws_availability_zones.available.names)
  cidr_block = element(var.private_subnets, count.index)
  vpc_id     = aws_vpc.main.id
  tags       = merge({ Name = "ecs-priv-subnet-${count.index}" }, local.common_tags)
}

resource "aws_nat_gateway" "gw" {
  count         = length(aws_subnet.public)
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags          = merge({ Name = "nat-gw-${count.index}" }, local.common_tags)
}

resource "aws_route_table" "ecs-rt" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  tags   = merge({ Name = "ecs-rt-${count.index}"}
  , local.common_tags)
}

resource "aws_route_table_association" "ecs-rt-assoc" {
  count          = length(aws_subnet.ecs-subnets)
  route_table_id = aws_route_table.ecs-rt.id
  subnet_id      = element(aws_subnet.ecs-subnets.*.id, count.index)
}

resource "aws_route" "ecs-rt" {
  count                  = length(aws_subnet.ecs-subnets)
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.ecs-rt.id
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_network_acl" "ecs-acl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.public.*.id
  tags       = merge({ Name = "ecs-acl" }, local.common_tags)
}
