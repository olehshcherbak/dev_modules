
output "aws_availability_zones" {
    value = data.aws_availability_zones.available_zones.names
}

output "aws_ami" {
    value = data.aws_ami.ubuntu_ami.image_id
}

output "aws_security_group" {
  value = aws_security_group.ubuntu-security-group.ingress
}

output "aws_subnets" {
  value = data.aws_subnets.filter.ids
}

output "public_ips" {
  value = {
    eip_1 = aws_eip.elastic1_to_ubuntu.public_ip
    eip_2 = aws_eip.elastic2_to_ubuntu.public_ip
    eip_3 = aws_eip.elastic3_to_ubuntu.public_ip
  }
}

