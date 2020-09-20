# Public Network

resource "aws_subnet" "public" {
  count                   = length(data.aws_availability_zones.available.names)
  cidr_block              = element(var.public_subnets, count.index)
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags                    = merge({ Name = "ecs-pub-subnet-${count.index}" }, var.common_tags)
}

# Private Network

resource "aws_subnet" "private" {
  count      = length(data.aws_availability_zones.available.names)
  cidr_block = element(var.private_subnets, count.index)
  vpc_id     = aws_vpc.main.id
  tags       = merge({ Name = "ecs-priv-subnet-${count.index}" }, var.common_tags)
}