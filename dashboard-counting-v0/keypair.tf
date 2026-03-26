resource "tls_private_key" "counting_dashboard" {
  algorithm = "ED25519"
}

locals {
  private_key_filename = "${var.prefix}-ssh-key.pem"
}

resource "aws_key_pair" "counting_dashboard" {
  key_name   = local.private_key_filename
  public_key = tls_private_key.counting_dashboard.public_key_openssh
}

resource "local_file" "private_key_pem" {
  filename        = local.private_key_filename
  content         = tls_private_key.counting_dashboard.private_key_pem
  file_permission = "0400"
}