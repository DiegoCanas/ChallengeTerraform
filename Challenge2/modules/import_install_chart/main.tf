
#Copiamos los charts de Helm
#Utilizamos el comando null_resource para poder ejecutar una acción local como el comando 'az acr import'

resource "null_resource" "copy_helm_charts" {
#El count depende de la variable 'var.charts', esto deremina cuantas instancias de van a crear (una por cada Helm Chart)
  count = length(var.charts)

#Este trigger permite que la copia se realice SOLO cuando haya cambios en el contenedor de referencia, cuando se hagan estos cambios se iniciará la copia al registro instancia.
  triggers = {
#azurerm_container_registry permite gestionar un Azure Container Registry
    source_acr_id = azurerm_container_registry.reference.azurecr.io.id
  }

#Utilizamos "local-exec" porque vamos a ejecutar los comandos en una maquina local (la mia)
#Utilizamos el bloque 'provisioner' puesto que vamos a ejecutar un comando en un entorno local
  provisioner "local-exec" {
    command = <<EOT
    
    #az -> Interactua con Azure a traves de su CLI
    #acr import -> Importación de imagenes
    #-n ${var.acr_server} -> Lugar al que se importan las imagenes
    # Resto -> Se define la fuente de las imágenes, el repostorio del Chart de Helm y la versión específica del Chart de Helm

      az acr import -n ${var.acr_server} --source ${var.source_acr_server}/${var.charts[count.index].chart_repository}:${var.charts[count.index].chart_version}
    EOT
  }
}



#Instalamos los charts de Helm
#Utilizamos helm_release para desplegar un Chart en un cluster de kubernetes, en este caso AKS

resource "helm_release" "install_charts" {
  count = length(var.charts)

#Definimos nombre, namespace, repositorio desde el que se obtienen los Charts a instalar y el chart especifico que se instala

  name       = var.charts[count.index].chart_name
  namespace  = var.charts[count.index].chart_namespace
  repository = var.acr_server
  chart      = "${var.charts[count.index].chart_repository}:${var.charts[count.index].chart_version}"

#Bloques dinamicos de valores regulares y sensibles.
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
