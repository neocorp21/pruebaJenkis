# Usar una imagen base de OpenJDK
FROM openjdk:17-jdk-slim

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo JAR generado desde el directorio target al contenedor
# Asumiendo que el archivo JAR se encuentra en target/demo-jenkins-app-0.0.1-SNAPSHOT.jar
COPY target/demo-jenkins-app-0.0.1-SNAPSHOT.jar demo-jenkins-app.jar

# Exponer el puerto 8080 para acceder a la aplicación
EXPOSE 8082

# Comando para ejecutar el archivo JAR cuando el contenedor se inicie
ENTRYPOINT ["java", "-jar", "/app/demo-jenkins-app.jar"]
