#Las explicaciones repetitivas se explicarán solo una vez para no ensuciar el código.


#Definimos en este archivo las variables para el modulo reutilizable
variable "acr_server" {
#Describimos la variabel acr_server
  description = "Azure Container Registry donde copiamos los Helm charts del reference.azure.io."
#Se proporciona una cadena
  type        = string 
# En caso de que se quiera dar un valor constante
# default     = "instance.azurecr.io"
}

variable "acr_server_subscription" {
  description = "ID de la suscrpición de Azure del registro instance.azurecr.io."
  type        = string
  default     = "env("TF_VAR_AZURE_SUBSCRIPTION_ID)"  
}

variable "source_acr_client_id" {
  description = "ID de cliente de Azure para autenticarse."
  type        = string
  default     = ""env("TF_VAR_AZURE_CLIENT_ID)""
}

variable "source_acr_client_secret" {
  description = "Secreto que se utiliza para la autenticación del cliente de Azure."
  type        = string
  default     = ""env("TF_VAR_AZURE_CLIENT_SECRET)""
}

variable "source_acr_server" {
  description = "Azure Container Registry con el cual instalamos en el AKS cluster."
  type        = string
  default     = "reference.azurecr.io"
}


variable "values" {
  description = "Se escriben los diferentes valores para el chart de Helm que se va a instalar."
  type = list(object({
    name  = string
    value = string
  }))
}

variable "sensitive_values" {
  description = "Se escriben los diferentes valores sensibles para el chart de Helm que se va a instalar."
  type = list(object({
    name  = string
    value = string
  }))
}

variable "charts" {
  chart_name       = string
  chart_namespace  = string
  chart_repository = string
  chart_version    = string
}