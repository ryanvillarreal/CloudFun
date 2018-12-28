output "ips" {
  value = ["${aws_instance.kali-linux.*.public_ip}"]
}
