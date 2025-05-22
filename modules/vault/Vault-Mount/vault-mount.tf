resource "vault_mount" "vault_mount" {
  path = var.path
  type = "kv-v2"
  options = {
    type    = "kv-v2"
    version = "2"
  }
  description = "Secrets of ${var.path}"
}

resource "vault_kv_secret_backend_v2" "secret_backend" {
  mount        = vault_mount.vault_mount.path
  cas_required = false
}
