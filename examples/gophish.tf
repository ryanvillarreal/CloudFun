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

module "phishing_server" {
  source = "./modules/aws/phishing-server"

  // How many servers to create?  
  // count = 2
  vpc_id = "${module.create_vpc.vpc_id}"
  subnet_id = "${module.create_vpc.subnet_id}"
}

