output "self_signed_cert_arn" {
  description = "The ARN of the self-signed certificate"
  value       = aws_acm_certificate.self_signed_cert.arn
}
