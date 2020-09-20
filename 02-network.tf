resource "aws_vpc" "main" {
  cidr_block = "172.24.0.0/16"
  tags       = merge({ Name = "ecs-vpc" }, local.common_tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge({ Name = "ecs-igw" }, local.common_tags)
}

# Public Network

resource "aws_subnet" "public" {
  count                   = length(data.aws_availability_zones.available.names)
  cidr_block              = element(var.public_subnets, count.index)
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags                    = merge({ Name = "ecs-pub-subnet-${count.index}" }, local.common_tags)
}

resource "aws_route_table" "ecs-rt" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  tags   = merge({ Name = "ecs-rt-${count.index}" }, local.common_tags)
}

resource "aws_route_table_association" "ecs-rt-assoc" {
  count          = length(aws_subnet.public)
  route_table_id = element(aws_route_table.ecs-rt.*.id, count.index)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

resource "aws_route" "public" {
  count                  = length(aws_subnet.public)
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = element(aws_route_table.ecs-rt.*.id, count.index)
  gateway_id             = aws_internet_gateway.igw.id
}

# Private Network

resource "aws_subnet" "private" {
  count      = length(data.aws_availability_zones.available.names)
  cidr_block = element(var.private_subnets, count.index)
  vpc_id     = aws_vpc.main.id
  tags       = merge({ Name = "ecs-priv-subnet-${count.index}" }, local.common_tags)
}

resource "aws_eip" "ngw-ip" {
  depends_on                = [aws_internet_gateway.igw]
  count                     = length(aws_subnet.public)
  vpc                       = true
  associate_with_private_ip = element(var.private_subnets,count.index)
  tags                      = merge({ Name = "ecs-eip-${count.index}" }, local.common_tags)
}

resource "aws_nat_gateway" "ngw" {
  count         = length(aws_subnet.public)
  allocation_id = element(aws_eip.ngw-ip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags          = merge({ Name = "nat-gw-${count.index}" }, local.common_tags)
}


resource "aws_route_table" "private-rt" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  tags   = merge({ Name = "ecs-private-rt-${count.index}" }, local.common_tags)
}

resource "aws_route_table_association" "priavte-ecs-rt-assoc" {
  count          = length(aws_subnet.private)
  route_table_id = element(aws_route_table.private-rt.*.id, count.index)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
}

resource "aws_route" "private_rt" {
  count                  = length(aws_subnet.private)
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = element(aws_route_table.private-rt.*.id, count.index)
  nat_gateway_id         = element(aws_nat_gateway.ngw.*.id, count.index)
}
