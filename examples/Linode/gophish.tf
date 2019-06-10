// --------------------------------------
// Minimum required TF version is 0.11.0

terraform {
  required_version = ">= 0.11.0"
}

provider "linode" {
  token = "0114593ae57604f62205d8c473c996484886e82ff167734d8b486678aa4fd84b"
}

// Create VPC for Linode instances

module "create_vpc" {
  source = "./modules/linode/create-vpc"
}