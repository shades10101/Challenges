provider "aws" {
  region = var.aws_region
}

terraform {
    backend "s3" {
        bucket = "shahids-tf-state-bucket"
        key =  "terraform.tfstate"
        region = "ca-central-1"
        encrypt = true
    }
}

# Configure S3 Bucket
data "aws_s3_bucket" "state_tf" {
    bucket = "shahids-tf-state-bucket"
}

module "aws-vpc" {
  source = "../modules/aws-vpc"

    aws_region = var.aws_region
    vpc_cidr =  var.vpc_cidr
    pub_cidr_1 = var.pub_cidr_1
    availability_zone_1 = var.availability_zone_1
}

module "aws-sg" {
  source = "../modules/aws-sg"

    ws_irules = var.ws_irules
    ws_erules = var.ws_erules
    vpc_id = module.aws-vpc.out_vpc_id
}

module "aws-instance" {
  source = "../modules/aws-instance"

  aws_region = var.aws_region
  key_name = var.key_name
  instance_type = var.instance_type
  pub_subnet_1_id = module.aws-vpc.out_pub_subnet_1_id
  web_server_sg_id = module.aws-sg.out_web_server_sg_id
  ami = var.ami
  availability_zone_1 = var.availability_zone_1
}
