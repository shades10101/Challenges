# Challenges

Envirnment variables:

Github actions:
${{ secrets.SSH_PRIVATE_KEY }} = SSH Private key
${{ secrets.TF_API_TOKEN }} = TF API Token

TF workspaces:
AWS CLI Credentials 

1)
a) Github: https://github.com/shades10101/Challenges

b) VPC and subnet CIDR:

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "pub_cidr_1" {
  default = "10.0.1.0/24"
}

c) 
Instance does deploy as t3.micro, an ebs with 8gb and the instanec is named aa-terraform-1.

Terraform code is working as expected, but the SG are wide open - was having issues with yum packages even after opening port 20, 21, 22, 80, and 443. Felt like i was running out of time and wanted to move ahead, would not do this in production. 

Referenced a module that I created months ago, used this code to help with the infrastructure deployment: 
https://github.com/shades10101/Terraform/tree/main/Another%203-Tier%20Architecture%20with%20AWS

Important information:
- Went with TF workspaces for remote backend.
- Provided public key in the aws-instance module so I could have the private key in github actions envirnment variable.
- Inventory file in repo will take precedence over newly created inventory, ive noticed that if there is a inventory file in the repo it will use that instead of the newly created inventory file. Havent tested from scratch but i will after writing this.
- Modules are stored in: terraform_modules/modules/*
- Inventory file is created by terraform, look at module.aws-instance and /outputs.tf

2)
a) Ran this via CLI first and dont get issues, tried it with ansible and was getting errors. Looks like i need to work on error handling. But I left it to ignore errors.

b) Created base_playbook, added roles for sysctl, packages, and nginx.

c) This is working as well, the ZIP that I submitted to acuityads is actually missing the correct ending to the playbook. I needed to stop docker, start docker and deploy the container. 


3)
This took me the longest to create, Terraform pipeline was quite easy but i had issues with the Ansible pipeline. Had to add a ssh argument (StrictHostKeyChecking=no) to get this to work, took me awhile to figure out the syntax (ssh_common_args: -o UserKnownHostsFile=/dev/null).

 Used this as a resource: https://learn.hashicorp.com/tutorials/terraform/github-actions#aws_access_key_id

Changes I made after submission:

- For some reason I have to stop and start the docker service at the end of the playbook, then tell docker compose to start the container. Once that is done the instance can be reach at IP:80