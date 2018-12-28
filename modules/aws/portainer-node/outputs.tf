output "ips" {
  value = ["${aws_instance.portainer-node.*.public_ip}"]
}
