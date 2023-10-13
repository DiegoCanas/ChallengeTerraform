
Estas son las herramientas que he utilizado para conseguir los tres objetivos que se plantean:
	Aislas grupos de nodos específicos (nodeSelector).
	Asegurar que un pod del mismo tipo no se programe en el mismo nodo (podAntiAffinity).
	Desplegar los pods en diferentes zonas de disponibilidad (nodeAffinity).

Archivos modificados:
values.yaml
app-pod.yaml


VALUES.yaml

- Añadimos las diferentes herramientas


APP-POD.yaml

- Archivo creado para poder administrar los pods con el objetivo de conseguir lo expuesto
en el enunciado

- Al haber añadido el nodeSelector podemos especificar que grupo de pods queremos aislar.

- Usamos podAntiAffinity y requiredDuringSchedulingIgnoredDuringExecution, con esto nos 
aseguramos de que si las condiciones mencionadas posteriormente se cumplen en dos pods,
no se puedan desplegar en el mismo nodo.

- Kubernetes utilizará el nombre del host para determinar si los pods se pueden programar
en el mismo nodo o no.

- Nos aseguramos que los pods se desplieguen en nodos con la etiqueta `topology.kubernetes.io/zone'
igual a la definica en el values.yaml.