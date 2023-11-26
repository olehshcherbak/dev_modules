variable "region" {
    default = "eu-central-1"
}

variable "instance_type" {
    description = "instance type"
    default = "t3.micro"
}

variable "backend_count" {
    description = "backend instance count"
    default = 2
}

variable "awz_1c" {
  description = "zone_1c"
  default = "eu-central-1c"
}
