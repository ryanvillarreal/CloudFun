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
// Create the Portainer Server

module "kali_linux" {
  source = "./modules/aws/kali-linux"

  // How many servers to create?  
  count = 1
  vpc_id = "${module.create_vpc.vpc_id}"
  subnet_id = "${module.create_vpc.subnet_id}"
}

