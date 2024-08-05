resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "time_static" "now" {}

resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.example.private_key_pem

  is_ca_certificate = false

  subject {
    common_name  = "example.com"
    organization = "Example Organization"
  }

  validity_period_hours  = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth"
  ]
}

resource "aws_acm_certificate" "self_signed_cert" {
  private_key       = tls_private_key.example.private_key_pem
  certificate_body  = tls_self_signed_cert.example.cert_pem
  tags = {
    Name = "self_signed_cert"
  }
}

