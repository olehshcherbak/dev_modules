provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "ubuntu-1" {
  ami = data.aws_ami.ubuntu_ami.image_id
  availability_zone = data.aws_availability_zone.german1b.name
  instance_type = var.instance_type
  user_data = templatefile("ssh-public-config.tpl", {key_owner = "ubuntu-cin"})
  vpc_security_group_ids = [aws_security_group.ubuntu-security-group.id]
  tags = {
    Name = "Ubuntu-01"
    Env = "test"
    ServerType = "backend"
  }
}

resource "aws_instance" "ubuntu-2" {
  ami = data.aws_ami.ubuntu_ami.image_id
  availability_zone = data.aws_availability_zone.german1b.name
  instance_type = var.instance_type
  user_data = templatefile("ssh-public-config.tpl", {key_owner = "ubuntu-cin"})
  vpc_security_group_ids = [aws_security_group.ubuntu-security-group.id]
  tags = {
    Name = "Ubuntu-02"
    Env = "test"
    ServerType = "backend"
  }
}

resource "aws_instance" "ubuntu-3" {
  ami = data.aws_ami.ubuntu_ami.image_id
  availability_zone = data.aws_availability_zone.german1b.name
  instance_type = var.instance_type
  user_data = templatefile("ssh-public-config.tpl", {key_owner = "ubuntu-cin"})
  vpc_security_group_ids = [aws_security_group.ubuntu-security-group.id]
  tags = {
    Name = "Ubuntu-03"
    Env = "test"
    ServerType = "backend"
  }
}

resource "aws_ebs_volume" "vlm-01" {
  availability_zone = data.aws_availability_zone.german1b.name
  size = var.volume_size
  type = var.volume_type
  final_snapshot = var.volume_snap
  tags = {
    Name = "Test-vlm-01"
    Env = "test"
  }
}

resource "aws_ebs_volume" "vlm-02" {
  availability_zone = data.aws_availability_zone.german1b.name
  size = var.volume_size
  type = var.volume_type
  final_snapshot = var.volume_snap
  tags = {
    Name = "Test-vlm-02"
    Env = "test"
  }
}

resource "aws_ebs_volume" "vlm-03" {
  availability_zone = data.aws_availability_zone.german1b.name
  size = var.volume_size
  type = var.volume_type
  final_snapshot = var.volume_snap
  tags = {
    Name = "Test-vlm-03"
    Env = "test"
  }
}

resource "aws_volume_attachment" "vlm-01-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.vlm-01.id}"
  instance_id = "${aws_instance.ubuntu-1.id}"
}

resource "aws_volume_attachment" "vlm-02-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.vlm-02.id}"
  instance_id = "${aws_instance.ubuntu-2.id}"
}

resource "aws_volume_attachment" "vlm-03-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.vlm-03.id}"
  instance_id = "${aws_instance.ubuntu-3.id}"
}

resource "aws_eip" "elastic1_to_ubuntu" {
  instance = aws_instance.ubuntu-1.id
  tags = {
    Name = "eip-Ubuntu"
  }
}

resource "aws_eip" "elastic2_to_ubuntu" {
  instance = aws_instance.ubuntu-2.id
  tags = {
    Name = "eip-Ubuntu"
  }
}

resource "aws_eip" "elastic3_to_ubuntu" {
  instance = aws_instance.ubuntu-3.id
  tags = {
    Name = "eip-Ubuntu"
  }
}


resource "aws_security_group" "ubuntu-security-group" {
  name = "Bakcend security group"
  description = "3x Ubuntu"

  dynamic "ingress" {
    for_each = ["80", "22", "443", "3000", "3001", "3002", "3003", "3004", "8080", "9090"]
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