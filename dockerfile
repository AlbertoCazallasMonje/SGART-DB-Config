# Usa la imagen oficial de SQL Server 2022 Express
FROM mcr.microsoft.com/mssql/server:2022-latest

# Establece variables de entorno
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

# Cambia al usuario root para instalar paquetes
USER root

# Instala mssql-tools, unixodbc-dev y sudo para que sqlcmd esté disponible y se puedan elevar permisos
RUN apt-get update && \
    apt-get install -y mssql-tools unixodbc-dev sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Agrega mssql-tools a la ruta del sistema
ENV PATH="$PATH:/opt/mssql-tools/bin"

# Copia los archivos necesarios
COPY entrypoint.sh /usr/src/app/entrypoint.sh
COPY init-db.sql /usr/src/app/init-db.sql

# Da permisos de ejecución al script de entrada
RUN chmod +x /usr/src/app/entrypoint.sh

# Expone el puerto predeterminado de SQL Server
EXPOSE 1433

# Cambia al usuario mssql para ejecutar SQL Server
USER mssql

# Ejecuta el script de entrada usando bash
CMD ["bash", "/usr/src/app/entrypoint.sh"]
