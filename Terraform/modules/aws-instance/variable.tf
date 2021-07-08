variable "aws_region" {
  description = "AWS region thats being used"
}
variable "availability_zone_1" {
  description = "AZ"
}
variable "instance_type" {
  description = "The instance type that will be provisioned"
}
variable "ami" {
  type = string
}
variable "key_name" {
  description = "Key pair name"
}
variable "pub_subnet_1_id" {
  description = "Public subnet"
}
variable "web_server_sg_id" {
  description = "SG ID"
}