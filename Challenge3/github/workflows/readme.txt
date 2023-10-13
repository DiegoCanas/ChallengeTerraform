
En este challenge se nos pide que instalemos el chart de helm creado en el challenge 1 
usando el módulo del challenge 2, esto va a hacer que tengamos que modificar el código 
de terraform puesto que los valores para configurar la identificación los obtenemos de 
terraform mediante entornos.


Dentro de GitHub habra que crear los secretos, para ello hacemos lo siguiente:
1. Vamos a la página del repositorio de GitHub en el que se esta trabajando
2. Configuración
3. Secretos
4. Nuevo secreto del repositorio
5. Agregar secreto

Por último, en cuanto al progreso del GitHub workflow, cuando estamos en la rama main,
recoge los secretos de identificación, aplica la configuración de terraform
y configura kubectl.