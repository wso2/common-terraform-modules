resource "vault_auth_backend" "kubernetes_rbom" {
  type     = "kubernetes"
}
resource "vault_kubernetes_auth_backend_config" "kubernetes_rbom" {
  backend         = vault_auth_backend.kubernetes_rbom.path
  kubernetes_host = "https://kubernetes.default.svc.cluster.local:443"
}
