provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "m7-ubuntu-1" {
  ami = data.aws_ami.ubuntu_ami.image_id
  availability_zone = data.aws_availability_zone.german1b.name
  instance_type = "t3.micro"
  user_data = templatefile("ssh-public-config.tpl", {key_owner = "ubuntu-cin"})
  vpc_security_group_ids = [aws_security_group.ubuntu-security-group.id]
  tags = {
    Name = "Ubuntu-01"
    Env = "test"
    ServerType = "backend"
  }
}

resource "aws_instance" "m7-ubuntu-2" {
  ami = data.aws_ami.ubuntu_ami.image_id
  availability_zone = data.aws_availability_zone.german1b.name
  instance_type = "t3.micro"
  user_data = templatefile("ssh-public-config.tpl", {key_owner = "ubuntu-cin"})
  vpc_security_group_ids = [aws_security_group.ubuntu-security-group.id]
  tags = {
    Name = "Ubuntu-02"
    Env = "test"
    ServerType = "backend"
  }
}

# resource "aws_ebs_volume" "vlm-3a" {
#   availability_zone = data.aws_availability_zone.german1b.name
#   size = 1
#   type = "gp2"
#   #iops = 100
#   tags = {
#     Name = "Test-vlm-03"
#     Env = "test"
#   }
# }

# resource "aws_ebs_volume" "vlm-4a" {
#   availability_zone = data.aws_availability_zone.german1b.name
#   size = 1
#   type = "gp2"
#   #iops = 100
#   tags = {
#     Name = "Test-vlm-04"
#     Env = "test"
#   }
# }

# resource "aws_volume_attachment" "vlm-3a-attachment" {
#   device_name = "/dev/xvdh"
#   volume_id = "${aws_ebs_volume.vlm-3a.id}"
#   instance_id = "${aws_instance.m7-ubuntu-1.id}"
# }

# resource "aws_volume_attachment" "vlm-4a-attachment" {
#   device_name = "/dev/xvdh"
#   volume_id = "${aws_ebs_volume.vlm-4a.id}"
#   instance_id = "${aws_instance.m7-ubuntu-2.id}"
# }


# resource "aws_eip" "elastic1_to_ubuntu" {
#   instance = aws_instance.m7-ubuntu-1.id
#   tags = {
#     Name = "eip-Ubuntu-1"
#   }
# }

resource "aws_eip" "elastic2_to_ubuntu" {
  instance = aws_instance.m7-ubuntu-2.id
  tags = {
    Name = "eip-Ubuntu-2"
  }
}

resource "aws_security_group" "ubuntu-security-group" {
  name = "Bakcend security group"
  description = "2x Ubuntu"

  dynamic "ingress" {
    for_each = ["80", "22", "443", "3000"]
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "Ubuntu security group"
    Env = "test"
  }

}