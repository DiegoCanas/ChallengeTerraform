
resource "null_resource" "copy_helm_charts" {
  count = length(var.charts)
  triggers = {
    source_acr_id = azurerm_container_registry.reference.azurecr.io.id
  }
  provisioner "local-exec" {
    command = <<EOT
      az acr import -n ${var.acr_server} --source ${var.source_acr_server}/${var.charts[count.index].chart_repository}:${var.charts[count.index].chart_version}
    EOT
  }
}

resource "helm_release" "install_charts" {
  count = length(var.charts)
  name       = var.charts[count.index].chart_name
  namespace  = var.charts[count.index].chart_namespace
  repository = var.acr_server
  chart      = "${var.charts[count.index].chart_repository}:${var.charts[count.index].chart_version}"

  dynamic "set" {
    for_each = var.charts[count.index].values
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.charts[count.index].sensitive_values
    content {
      name     = set_sensitive.value.name
      value    = set_sensitive.value.value
      sensitive = true
    }
  }
}
