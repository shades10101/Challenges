variable "ws_irules" {
  type = list(number) // Tells Terraform this is a list with only number values
}
variable "ws_erules" {
  type = list(number)
}
variable "vpc_id" {}