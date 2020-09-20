# Public Network

resource "aws_route_table" "ecs-rt" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  tags   = merge({ Name = "ecs-rt-${count.index}" }, var.common_tags)
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

resource "aws_route_table" "private-rt" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  tags   = merge({ Name = "ecs-private-rt-${count.index}" }, var.common_tags)
}

resource "aws_route_table_association" "priavte-ecs-rt-assoc" {
  count          = length(aws_subnet.private)
  route_table_id = element(aws_route_table.private-rt.*.id, count.index)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
}

resource "aws_route" "private-rt" {
  count                  = length(aws_subnet.private)
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = element(aws_route_table.private-rt.*.id, count.index)
  nat_gateway_id         = element(aws_nat_gateway.ngw.*.id, count.index)
}