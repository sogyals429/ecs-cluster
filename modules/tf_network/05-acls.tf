# Public Network

resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.main.id
  subnet_ids = aws_subnet.public.*.id
}

# Private Network

resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.main.id
  subnet_ids = aws_subnet.private.*.id
}

# resource "aws_network_acl_rule" "https"{
  
# }
