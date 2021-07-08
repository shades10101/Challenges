### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile(".github/workflows/inventory.tmpl",
    {
      linipv4_address = module.aws-instance.ip
    }
  )
  filename = "inventory"
}