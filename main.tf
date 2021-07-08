provider "aws" {
  region = var.aws_region
}

terraform {
  backend "remote" {
    organization = "2020-learning-shahid"

    workspaces {
      name = "acuityads_challenge"
    }
  }
}

module "aws-vpc" {
  source = "./terraform_modules/modules/aws-vpc"

  aws_region          = var.aws_region
  vpc_cidr            = var.vpc_cidr
  pub_cidr_1          = var.pub_cidr_1
  availability_zone_1 = var.availability_zone_1
}

module "aws-sg" {
  source = "./terraform_modules/modules/aws-sg"

  ws_irules = var.ws_irules
  ws_erules = var.ws_erules
  vpc_id    = module.aws-vpc.out_vpc_id
}

module "aws-instance" {
  source = "./terraform_modules/modules/aws-instance"

  aws_region          = var.aws_region
  key_name            = var.key_name
  instance_type       = var.instance_type
  pub_subnet_1_id     = module.aws-vpc.out_pub_subnet_1_id
  web_server_sg_id    = module.aws-sg.out_web_server_sg_id
  ami                 = var.ami
  availability_zone_1 = var.availability_zone_1
}

resource "null_resource" "run-ansible" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "ansible-playbook base_playbook.yaml -i inventory --key-file=${{secrets.SSH_PRIVATE_KEY}}"
  }
  depends_on = [module.aws-instance]
}