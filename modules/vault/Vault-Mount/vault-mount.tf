resource "vault_mount" "vault_mount" {
  path = var.path
  type = "kv-v2"
  options = {
    type    = "kv-v2"
    version = "2"
  }
  description = "Secrets of ${var.path}"
}
