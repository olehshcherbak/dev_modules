variable "region" {
    default = "eu-central-1"
}

variable "instance_type" {
  description = "instance type"
  default = "t3.micro"
}

variable "volume_type" {
  description = "volume type"
  default = "gp2"
}

variable "volume_size" {
  description = "volume size"
  default = "20"
}

variable "volume_snap" {
  description = "volume final snapshot"
  default = "true"
}

variable "awz_1c" {
  description = "zone_1c"
  default = "eu-central-1c"
}
