output "ip" {
  description = "default ip address of the deployed VM"
  value       = aws_instance.web_server.public_ip
}