
output "aws_availability_zones" {
  value = data.aws_availability_zones.available_zones.names
}

output "aws_ami" {
  value = data.aws_ami.ubuntu_latest.image_id
}

output "aws_security_group" {
  value = data.aws_security_group.web.id
}

output "aws_subnets" {
  value = data.aws_subnets.web.ids
}

output "aws_network_interfaces_all" {
  value = data.aws_network_interfaces.all.ids
}

output "aws_instances_back" {
  value = {
    instance_back_id = data.aws_instances.backend.ids
  }
}
