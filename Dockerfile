# Usa la imagen oficial de Jenkins como base
FROM jenkins/jenkins:lts

# Configura Jenkins para evitar la necesidad de usar root (opcional, recomendado)
USER root

# Instala Maven
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

# Cambia el usuario de nuevo a Jenkins para correr el contenedor
USER jenkins
