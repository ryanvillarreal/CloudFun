terraform {
  required_version = ">= 0.10.0"
}

data "external" "get_public_ip" {
  program = ["bash", "./scripts/get_public_ip.sh" ]
}

resource "aws_security_group" "phishing-server" {
  name = "phishing-server"
  description = "Security Group for GoPhish - Phishing Server"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${data.external.get_public_ip.result["ip"]}/32"]
  }
  ingress {
    from_port = 3333
    to_port = 3333
    protocol = "tcp"
    cidr_blocks = ["${data.external.get_public_ip.result["ip"]}/32"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
