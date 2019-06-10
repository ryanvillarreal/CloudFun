terraform {
  required_version = ">= 0.10.0"
}

provider "linode" {
  token = "$LINODE_API_KEY"
}

resource "random_id" "server" {
  count = "${var.count}"
  byte_length = 4
}

resource "random_string" "password" {
  count = "${var.count}"
  length = 16
  special = true
}

resource "tls_private_key" "ssh" {
  count = "${var.count}"
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "linode_instance" "gophish" {
  label = "phishing-server-${random_id.server.*.hex[count.index]}"
  image = "linode/debian9"
  region = "us-west"
  type = "g6-standard-1"

  group = "foo"
  tags = [ "foo" ]
  swap_size = 256
  private_ip = true
}