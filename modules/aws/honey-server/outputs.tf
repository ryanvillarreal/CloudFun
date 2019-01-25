output "ips" {
  value = ["${aws_instance.honey-server.*.public_ip}"]
}
