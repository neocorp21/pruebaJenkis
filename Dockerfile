# Usar una imagen base de OpenJDK
FROM openjdk:17-jdk-slim

# Definir el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo JAR de la aplicación al contenedor
COPY target/demo-jenkins-app-0.0.1-SNAPSHOT.jar demo-jenkins-app.jar

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "demo-jenkins-app.jar"]
