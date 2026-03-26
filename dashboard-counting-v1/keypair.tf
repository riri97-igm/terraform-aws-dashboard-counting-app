resource "tls_private_key" "counting_dashboard" {
  algorithm = "ED25519"
}

locals {
  key_name             = "${var.prefix}-key"
  private_key_filename = "${var.prefix}-ssh-key.pem"
}

resource "aws_key_pair" "counting_dashboard" {
  key_name   = local.key_name
  public_key = tls_private_key.counting_dashboard.public_key_openssh

  tags = {
    Name = local.key_name
  }
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.counting_dashboard.private_key_openssh
  filename        = local.private_key_filename
  file_permission = "0600"
}