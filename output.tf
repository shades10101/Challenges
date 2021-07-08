### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      linipv4_address = module.aws-instance.ip
    }
  )
  filename = "inventory"
}

output "private_key" {
    value = module.aws-instance.private_key_pem
}