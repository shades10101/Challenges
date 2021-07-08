variable "availability_zone_1" {
  default = "ca-central-1a"
}
variable "allocated_storage" {
  default = "8"
}
variable "ami" {
  default = "ami-0a7c5b189b6460115"
}
variable "ws_irules" {
  type    = list(number)
  default = [80, 22]
}
variable "ws_erules" {
  type    = list(number)
  default = [0]
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "pub_cidr_1" {
  default = "10.0.1.0/24"
}
variable "aws_region" {
  default = "ca-central-1"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "key_name" {
  default = "aws_terraform"
}