variable "password" {
  description = "Password for the PKCS12 file"
  type        = string
}
variable "cert_pem" {
  description = "Certificate in PEM format"
  type        = string
}
variable "private_key_pem" {
  description = "Private key in PEM format"
  type        = string
}
variable "private_key_pass" {
  description = "Password for the private key"
  type        = string
  default     = null
}
variable "ca_pem" {
  description = "CA certificate in PEM format"
  type        = string
  default     = null
}
