resource "pkcs12_from_pem" "pkcs12" {
  password         = var.password
  cert_pem         = var.cert_pem
  private_key_pem  = var.private_key_pem
  private_key_pass = var.private_key_pass
  ca_pem           = var.ca_pem
}
