terraform {
  required_version = "< 0.12"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
  version    = "1.41.0"
}

data "aws_ami" "this" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-stretch-hvm-x86_64-gp2-*"]
  }

  owners = ["379101102735"]
}

resource "aws_key_pair" "this" {
  key_name   = "paxful_tt"
  public_key = "${file(var.aws_pubkey)}"
}

resource "aws_instance" "appserver" {
  ami                         = "${data.aws_ami.this.id}"
  instance_type               = "${var.aws_instance_type}"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.this.key_name}"
  subnet_id                   = "${aws_subnet.this.id}"
  vpc_security_group_ids      = ["${aws_security_group.this.id}"]

  root_block_device = {
    volume_size = "8"
    volume_type = "gp2"
  }

  tags {
    Name = "appserver"
  }
}

resource "aws_instance" "dbmaster" {
  ami                         = "${data.aws_ami.this.id}"
  instance_type               = "${var.aws_instance_type}"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.this.key_name}"
  subnet_id                   = "${aws_subnet.this.id}"
  vpc_security_group_ids      = ["${aws_security_group.this.id}"]

  root_block_device = {
    volume_size = "8"
    volume_type = "gp2"
  }

  tags {
    Name = "dbmaster"
  }
}

resource "aws_instance" "dbslave" {
  ami                         = "${data.aws_ami.this.id}"
  instance_type               = "${var.aws_instance_type}"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.this.key_name}"
  subnet_id                   = "${aws_subnet.this.id}"
  vpc_security_group_ids      = ["${aws_security_group.this.id}"]

  root_block_device = {
    volume_size = "8"
    volume_type = "gp2"
  }

  tags {
    Name = "dbslave"
  }
}
