terraform {
  required_version = ">= 1.10"
  required_providers {
    mongodb = {
      source  = "FelGel/mongodb"
      version = "> 1.0.0"
    }
  }
}
