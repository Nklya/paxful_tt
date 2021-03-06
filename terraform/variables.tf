variable aws_access_key {
  description = "AWS access key"
}

variable aws_secret_key {
  description = "AWS secret key"
}

variable aws_region {
  description = "AWS region"
  default     = "eu-west-1"
}

variable aws_pubkey {
  description = "Public key"
  default     = "../id_rsa.pub"
}

variable aws_vpc_subnet {
  description = "AWS VPC subnet"
  default     = "10.10.10.0/24"
}

variable "aws_instance_type" {
  description = "AWS instance type"
  default     = "t3.nano"
}
