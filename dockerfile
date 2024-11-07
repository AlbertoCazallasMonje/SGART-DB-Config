# Usa la imagen oficial de SQL Server 2022 Express
FROM mcr.microsoft.com/mssql/server:2022-latest

# Establece variables de entorno
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Developer

# Instala mssql-tools y unixodbc-dev para que sqlcmd esté disponible
USER root
RUN apt-get update && \
    apt-get install -y mssql-tools unixodbc-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Agrega mssql-tools a la ruta del sistema
ENV PATH="$PATH:/opt/mssql-tools/bin"

# Cambia al usuario no-root
RUN useradd -m sqluser
USER sqluser

# Copia los archivos necesarios
COPY entrypoint.sh /usr/src/app/entrypoint.sh
COPY init-db.sql /usr/src/app/init-db.sql

# Da permisos de ejecución al script de entrada
RUN chmod +x /usr/src/app/entrypoint.sh

# Expone el puerto predeterminado de SQL Server
EXPOSE 1433

# Ejecuta el script de entrada usando bash sin cambiar el usuario
CMD ["bash", "/usr/src/app/entrypoint.sh"]
