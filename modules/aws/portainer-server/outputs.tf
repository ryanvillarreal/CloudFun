output "ips" {
  value = ["${aws_instance.portainer-server.*.public_ip}"]
}