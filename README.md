# Docker Resources Challenge

(Enunciado del ejercicio)

One key feature of docker is that it allows you to define which resources from the host you want to give to your docker container so that if it gets compromised or if it is too demanding, it will not affect the host and other hosted containers.

Within this challenge you are required to:
- Create a container with limited cpu and a script inside that consumes as much cpu as possible. You may look at cpu monitors to check that everything works fine.
- Do the same but challenging the host memory consumption. Take care, if you do this with Java you may end up in a trouble if you do not also specify JVM limits inside the container.
  
## Descripción

Este proyecto demuestra cómo limitar los recursos de CPU y memoria en contenedores Docker, y cómo verificar que estas limitaciones funcionan correctamente mediante un script que consume recursos intencionalmente.

## Requisitos

- Docker instalado en el sistema host
- Acceso a la terminal/linea de comandos
- Permisos para ejecutar contenedores Docker

## Estructura del Proyecto

📦 docker-resources-challenge
├── 📄 Dockerfile       - Archivo de construcción del contenedor
└── 📄 tarea1.sh        - Script que consume recursos para pruebas

## Configuración

### Dockerfile

El Dockerfile utiliza una imagen base de Ubuntu e instala `stress-ng`, una herramienta para pruebas de estrés en sistemas. Luego copia el script de prueba y lo configura como punto de entrada.

### Script `tarea1.sh`

El script ejecuta `stress-ng` con los siguientes parámetros:

- **Consumo de CPU**:
  - 4 workers 
  - Método FFT 
  - 90% de carga

- **Consumo de memoria**:
  - 1 worker 
  - 1000MB de memoria

- **Duración**: 60 segundos

```bash
#!/bin/bash
stress-ng --cpu 4 --cpu-method fft --cpu-load 90 --vm 1 --vm-bytes 1000M --timeout 60s
```

## Comandos Utilizados
```bash
# Construir la imagen con nombre 'prueba1'
sudo docker build -t prueba1 .

# Ejecutar el contenedor con límite de 0.9 CPUs
sudo docker run --cpus="0.9" prueba1

# Listar todos los contenedores (activos e inactivos)
sudo docker ps -a

# Iniciar un contenedor detenido (usando el ID)
sudo docker start <ID_del_contenedor>

# Ver estadísticas de uso de recursos en tiempo real
sudo docker stats <ID_del_contenedor>

# Alternativa: ver stats de todos los contenedores activos
sudo docker stats
```
## Comandos adicionales
```bash
# Ver logs del contenedor
sudo docker logs <ID_del_contenedor>

# Detener un contenedor en ejecución
sudo docker stop <ID_del_contenedor>

# Eliminar un contenedor
sudo docker rm <ID_del_contenedor>

# Eliminar la imagen
sudo docker rmi prueba1
```

## Consejos prácticos
### 1.Para obtener el ID del contenedor rápidamente
`sudo docker ps -aqf "ancestor=prueba1"`

### 2.Para ejecutar con límites combinados
`sudo docker run --cpus="0.9" --memory="500m" prueba1`

### 3.Para ejecutar en segundo plano (modo detached)
`sudo docker run -d --cpus="0.9" prueba1`

## Notas de Seguridad

⚠️ **Advertencias importantes**:

- El script está diseñado para consumir recursos intensivamente. **Ejecútalo solo en entornos controlados**.
- Para aplicaciones Java en contenedores:
  - Debes configurar los límites de la JVM **además** de los límites del contenedor Docker
- **No ejecutes** este contenedor en sistemas de producción sin las debidas precauciones.

## Licencia

📄 Este proyecto no tiene licencia específica y es para fines educativos solamente.
