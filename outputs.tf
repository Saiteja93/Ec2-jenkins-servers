# Output Public IP
output "instance_public_ip_one" {
  value = aws_instance.terraform-one.public_ip
}

output "instance_public_ip_two" {
  value = aws_instance.terraform-two.public_ip
}

