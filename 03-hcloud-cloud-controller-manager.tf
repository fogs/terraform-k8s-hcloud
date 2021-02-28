resource "helm_release" "hcloud-cloud-controller-manager" {
  name       = "hcloud-cloud-controller-manager"
  namespace  = "kube-system"
  repository = "https://helm-charts.mlohr.com/"
  chart      = "hcloud-cloud-controller-manager"
#  version    = "1.0.4"

  set {
    name  = "manager.secret.create"
    value = "true"
  }

  set {
    name  = "manager.secret.hcloudApiToken"
    value = var.hcloud_token
  }

  set {
    name  = "manager.privateNetwork.enabled"
    value = "true"
  }

  set {
    name  = "manager.loadBalancers.enabled"
    value = "true"
  }

  set {
    name  = "manager.privateNetwork.id"
    value = hcloud_network.kubenet.id
  }

  set {
    name  = "manager.privateNetwork.clusterSubnet"
    value = "10.88.0.0/16"
  }

  depends_on = [hcloud_server.master, hcloud_network.kubenet, null_resource.init_masters, null_resource.init_workers]
}
