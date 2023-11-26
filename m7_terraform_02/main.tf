# 1. use default vpc
# 2. create security group with inbound rules at least SSH and tag Owner: preprod
#
#
provider "aws" {
  region = var.region
}

  
resource "aws_instance" "m7a-backend-1" {
  ami = data.aws_ami.ubuntu_latest.image_id
  count = var.backend_count
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  instance_type = var.instance_type
  user_data = templatefile("ssh-public-config.tpl", {key_owner = "ubuntu-cin"})
  vpc_security_group_ids = [data.aws_security_group.web.id]

  depends_on = [ aws_instance.m7a-db ]

  tags = {
    Name = "Ubuntu-Back-01"
    Env = "test"
    ServerType = "backend"
  }
}

resource "aws_instance" "m7a-backend-2" {
  ami = data.aws_ami.ubuntu_latest.image_id
  count = var.backend_count
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  instance_type = var.instance_type
  user_data = templatefile("ssh-public-config.tpl", {key_owner = "ubuntu-cin"})
  vpc_security_group_ids = [data.aws_security_group.web.id]
  
  depends_on = [ aws_instance.m7a-db ]
  
  tags = {
    Name = "Ubuntu-Back-02"
    Env = "test"
    ServerType = "backend"
  }
}

resource "aws_instance" "m7a-db" {
  ami = data.aws_ami.ubuntu_latest.image_id
  availability_zone = var.awz_1c
  instance_type = var.instance_type
  user_data = templatefile("ssh-public-config.tpl", {key_owner = "ubuntu-cin"})
  vpc_security_group_ids = [data.aws_security_group.web.id]

  tags = {
    Name = "Ubuntu-DB"
    Env = "test"
    ServerType = "db"
  }
}

resource "aws_ebs_volume" "vlm-db" {
  availability_zone = var.awz_1c
  size = 1
  type = "gp2"
  tags = {
    Name = "Additional-vlm-db"
    Env = "test"
  }
}

resource "aws_volume_attachment" "vlm-db-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.vlm-db.id}"
  instance_id = "${aws_instance.m7a-db.id}"
}

resource "aws_instance" "m7a-frontend" {
  ami = data.aws_ami.ubuntu_latest.image_id
  availability_zone = var.awz_1c
  instance_type = var.instance_type
  user_data = templatefile("ssh-public-config.tpl", {key_owner = "ubuntu-cin"})
  vpc_security_group_ids = [data.aws_security_group.web.id]
  
  depends_on = [ 
    aws_instance.m7a-backend-1,
    aws_instance.m7a-backend-2
  ]
  
  tags = {
    Name = "Ubuntu-Frontend"
    Env = "test"
    ServerType = "frontend"
  }
}

resource "aws_eip" "frontend_eip" {}

resource "aws_eip_association" "frontend_eip_association" {
  instance_id = aws_instance.m7a-frontend.id
  allocation_id = aws_eip.frontend_eip.id
}

resource "aws_eip" "backend_eip" {
  count = length(data.aws_instances.backend.ids)
}

resource "aws_eip_association" "backend_eip_association" {
  count = length(data.aws_instances.backend.ids)
  instance_id = data.aws_instances.backend.ids[count.index]
  allocation_id = aws_eip.backend_eip[count.index].id
}
