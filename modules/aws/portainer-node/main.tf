terraform {
  required_version = ">= 0.10.0"
}

data "aws_region" "current" {
  
}

resource "random_id" "node" {
  count = "${var.count}"
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  count = "${var.count}"
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "portainer-node" {
  count = "${var.count}"
  key_name = "portainer-node-key-${count.index}"
  public_key = "${tls_private_key.ssh.*.public_key_openssh[count.index]}"
}

resource "aws_instance" "portainer-node" {

  count = "${var.count}"
  
  tags = {
    Name = "portainer-${random_id.node.*.hex[count.index]}"
  }

  ami = "${var.amis[data.aws_region.current.name]}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.portainer-node.*.key_name[count.index]}"
  vpc_security_group_ids = ["${aws_security_group.portainer-node.id}"]
  subnet_id = "${var.subnet_id}"
  associate_public_ip_address = true


  # Upload the docker_setup script
  provisioner "file" {
    source = "./scripts/docker_setup.sh"
    destination = "/tmp/docker_setup.sh"

    connection {
        type = "ssh"
        user = "admin"
        private_key = "${tls_private_key.ssh.*.private_key_pem[count.index]}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo chmod +x /tmp/docker_setup.sh",
      "sudo /tmp/docker_setup.sh"
    ]

    connection {
        type = "ssh"
        user = "admin"
        private_key = "${tls_private_key.ssh.*.private_key_pem[count.index]}"
    }
  }

  // setup ssh keys in the ssh_keys folder.  add Aliasing support for easy to use ssh
  provisioner "local-exec" {
    command = "echo \"${tls_private_key.ssh.*.private_key_pem[count.index]}\" > ./ssh_keys/portainer_node_${self.public_ip} && echo \"${tls_private_key.ssh.*.public_key_openssh[count.index]}\" > ./ssh_keys/portainer_node_${self.public_ip}.pub" 
  }

  // remove the keys from the ssh_keys server and remove any aliasing
  provisioner "local-exec" {
    when = "destroy"
    command = "rm ./ssh_keys/portainer_node_${self.public_ip}*"
  }

}
