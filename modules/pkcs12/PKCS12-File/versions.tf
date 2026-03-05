terraform {
  required_version = ">= 1.10"
  required_providers {
    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "0.2.5"
    }
  }
}
