data "aws_region" "current" {}

data "aws_availability_zones" "available_zones" {
    state = "available"
}

data "aws_availability_zone" "german1b" {
  name = "eu-central-1b"
}

data "aws_vpcs" "all_vpcs" {}

data "aws_ami" "ubuntu_ami" {
  #executable_users = ["self"]
  most_recent      = true
  #name_regex       = "^ami-\\d{3}"
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["*ubuntu-jammy-22.04-amd64-server*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

data "aws_subnets" "filter" {
  filter {
    name = "subnet-id"
    values = ["subnet-*"]
  }
}
