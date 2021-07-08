output "ip" {
  description = "default ip address of the deployed VM"
  value       = aws_instance.web_server.public_ip
}

output "private_key_pem" {
  description = "returns a string"
  value       = tls_private_key.mykey.private_key_pem
  sensitive   = true
}