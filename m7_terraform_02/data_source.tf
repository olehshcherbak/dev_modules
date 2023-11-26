data "aws_region" "current" {}

data "aws_availability_zones" "available_zones" {
  state = "available"
}

data "aws_vpcs" "all_vpcs" {}

data "aws_ami" "ubuntu_latest" {
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

data "aws_security_group" "web" {
  filter {
    name = "tag:Owner"
    values = ["preprod"]
  }
}

data "aws_subnets" "web" {}

data "aws_network_interfaces" "all" {}

data "aws_instances" "backend" {
  filter {
    name = "tag:ServerType"
    values = ["backend"]
  }
}

