
Primero, creamos una carpeta de terraform básica.

Archivos modificados:

modules/import_install_chart/main.tf
modules/import_install_chart/variables.tf

- Planteamiento del ejercicio, hacer dos declaraciones, una se copian los archivos del 
‘reference’ a la ‘instance’ y otro que instale del reference al cluster AKS.
- Realizamos estas dos declaraciones en el main.
- Establecemos las variables, han de estar relacionadas con las del módulo.
- Ejecutamos los comandos de validación ‘terraform validate’ y ‘terraform fm’
Recibimos el siguiente mensaje: ‘Success! The configuration is valid’


Variables.tf

- Definimos en este archivo las variables para el main.tf
- Definimos ocho variables:
    . acr_server
    . acr_server_subscription
    . source_acr_client_id
    . source_acr_client_secret
    . source_acr_server
    . values
    . sensitive_values
    . charts
- Estas variables darán información al archivo main para poder hacer la copia y
la instalación.

Main.tf

- Primer bloque, copiamos los charts de helm
- Utilizamos el comando null_resource porque nos permite ejecutar una acción local 
como el comando 'az acr import'
- Añadimos un count que depende de la variable 'var.charts', esto deremina cuantas 
instancias de van a crear (una por cada Helm Chart)
- Añadimos un trigger que permite que la copia se realice SOLO cuando haya cambios en el 
contenedor de referencia, cuando se hagan estos cambios se iniciará la copia al registro instancia.
- Utilizamos "local-exec" porque vamos a ejecutar los comandos en una maquina local (la mia)
- Utilizamos el bloque 'provisioner' puesto que vamos a ejecutar un comando en un entorno local

- Segundo bloque, instalamos los charts de helm 
- Utilizamos helm_release para desplegar un Chart en un cluster de kubernetes, en este caso AKS
- Definimos nombre, namespace, repositorio desde el que se obtienen los Charts a instalar
 y el chart especifico que se instala

- Tercer y cuarto bloque, definimos las variables dinamicas de valores regulares y sensibles.