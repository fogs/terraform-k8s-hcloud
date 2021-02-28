provider "helm" {
  kubernetes {
    config_path = "secrets/admin.conf"
  }
}

resource "helm_release" "hcloud-csi-driver" {
  name       = "hcloud-csi-driver"
  namespace  = "kube-system"
  repository = "https://helm-charts.mlohr.com/"
  chart      = "hcloud-csi-driver"
  version    = "1.0.4"

  set {
    name  = "csiDriver.secret.create"
    value = "true"
  }

  set {
    name  = "csiDriver.secret.hcloudApiToken"
    value = var.hcloud_token
  }

  depends_on = [hcloud_server.master, hcloud_network.kubenet, null_resource.init_masters, null_resource.init_workers]
}
