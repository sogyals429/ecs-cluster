resource "aws_vpc" "main" {
  cidr_block = "172.24.0.0/16"
  tags       = merge({ Name = "ecs-vpc" }, var.common_tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge({ Name = "ecs-igw" }, var.common_tags)
}

resource "aws_eip" "ngw-ip" {
  depends_on                = [aws_internet_gateway.igw]
  count                     = length(aws_subnet.public)
  vpc                       = true
  associate_with_private_ip = element(var.private_subnets,count.index)
  tags                      = merge({ Name = "ecs-eip-${count.index}" }, var.common_tags)
}

resource "aws_nat_gateway" "ngw" {
  count         = length(aws_subnet.public)
  allocation_id = element(aws_eip.ngw-ip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags          = merge({ Name = "nat-gw-${count.index}" }, var.common_tags)
}

