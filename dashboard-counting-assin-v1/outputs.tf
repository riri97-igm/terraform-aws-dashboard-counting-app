output "dashboard_public_ip" {
  description = "Public IP of dashboard VM"
  value       = aws_instance.dashboard_vm.public_ip
}

output "dashboard_url" {
  description = "Access URL for dashboard"
  value       = "http://${aws_instance.dashboard_vm.public_ip}:9002"
}

output "counting_private_ip" {
  description = "Private IP of counting VM"
  value       = aws_instance.counting_vm.private_ip
}