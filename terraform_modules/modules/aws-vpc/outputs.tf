output "out_vpc_id" {
  value = aws_vpc.vpc.id
}
output "out_vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}
output "out_pub_subnet_1_id" {
  value = aws_subnet.pub_subnet_1.id
}