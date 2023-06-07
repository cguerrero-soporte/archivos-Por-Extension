# Archivos por tipo de extension  
El script escanea los archivos por tipo de extensión para obtener el tamaño total de todos los archivos en la unidad seleccionada. 

El objetivo del script es localizar todos los archivos según el tipo de extensión y verificar el peso total del grupo seleccionado. Por ejemplo, buscar todos los archivos con la extensión .pdf, ver el tamaño total del grupo y determinar la mejor ubicación en caso de realizar una copia de seguridad.  

Proporciona una vista general de los archivos almacenados en los equipos de trabajo de nuestros usuarios.

*Importante:Este script trabaja con las unidades del equipo donde se encuentra almacenado. Como alternativa, utilizando el script WinRM-PowerShell, es posible copiarlo y ejecutarlo desde la sesión abierta.

Nota: El primer do{} contiene una verificacion de usuario por numero, en mi caso los usuarios mantienen numeros en el nombre. Por este motivo es necesario cambiar la variable $carpeta
