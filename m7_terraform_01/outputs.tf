
# output "aws_availability_zones" {
#     value = data.aws_availability_zones.available_zones.names
# }

output "aws_ami" {
    value = data.aws_ami.ubuntu_ami.image_id
}

