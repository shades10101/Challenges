### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      linipv4_address = module.aws-instance.ip
    }
  )
  filename = "inventory"
}