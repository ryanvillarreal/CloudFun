// --------------------------------------
// Minimum required TF version is 0.11.0

terraform {
  required_version = ">= 0.11.0"
}

// Create VPC for Linode instances

module "create_vpc" {
  source = "./modules/linode/create-vpc"
}

