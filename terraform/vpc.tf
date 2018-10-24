resource "aws_vpc" "this" {
  cidr_block = "${var.aws_vpc_subnet}"

  tags {
    Name = "paxful_tt_vpc"
  }
}

resource "aws_subnet" "this" {
  cidr_block = "${var.aws_vpc_subnet}"
  vpc_id     = "${aws_vpc.this.id}"

  tags {
    Name = "paxful_tt_sb"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"

  tags {
    Name = "paxful_tt_ig"
  }
}

resource "aws_route" "this" {
  route_table_id         = "${aws_vpc.this.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.this.id}"
}

# resource "aws_security_group_rule" "paxful_tt" {
#   type        = "ingress"
#   from_port   = 0
#   to_port     = 0
#   protocol    = "-1"
#   cidr_blocks = ["0.0.0.0/0"]

#   security_group_id = "${aws_vpc.paxful_tt.default_security_group_id}"
# }

resource "aws_security_group" "this" {
  name = "paxful_tt_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.this.id}"

  tags {
    Name = "paxful_tt_sg"
  }
}
