// --------------------------------------
// Minimum required TF version is 0.10.0

terraform {
  required_version = ">= 0.10.0"
}

// Create VPC for AWS instances

module "create_vpc" {
  source = "./modules/aws/create-vpc"
}

// ---------------------------------------
// Create the Phishing Server

module "honey_server" {
  source = "./modules/aws/honey-server"

  vpc_id = "${module.create_vpc.vpc_id}"
  subnet_id = "${module.create_vpc.subnet_id}"
}
