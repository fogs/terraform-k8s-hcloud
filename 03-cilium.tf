resource "helm_release" "cilium" {
  name       = "cilium"
  namespace  = "kube-system"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.9.1"

  set {
    name  = "prometheus.enabled"
    value = "true"
  }
  
  set {
    name  = "devices"
    value = "{eth0}"
  }
  
  set {
    name  = "hostFirewall"
    value = "true"
  }

  depends_on = [hcloud_server.master, hcloud_network.kubenet, null_resource.init_masters, null_resource.init_workers]
}
