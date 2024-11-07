# Usa la imagen oficial de SQL Server 2022 Express
FROM mcr.microsoft.com/mssql/server:2022-latest

# Establece variables de entorno
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

# Instala mssql-tools para que sqlcmd esté disponible
RUN apt-get update && \
    apt-get install -y mssql-tools unixodbc-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Agrega mssql-tools a la ruta del sistema
ENV PATH="$PATH:/opt/mssql-tools/bin"

# Copia los archivos necesarios
COPY entrypoint.sh /usr/src/app/entrypoint.sh
COPY init-db.sql /usr/src/app/init-db.sql

# Expone el puerto predeterminado de SQL Server
EXPOSE 1433

# Ejecuta el contenedor como root para asegurar permisos
USER root

# Ejecuta el script de entrada usando bash
CMD ["bash", "/usr/src/app/entrypoint.sh"]
