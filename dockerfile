# Usa la imagen oficial de SQL Server 2022 Express
FROM mcr.microsoft.com/mssql/server:2022-latest

# Establece variables de entorno
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

# Copia los archivos necesarios
COPY entrypoint.sh /usr/src/app/entrypoint.sh
COPY init-db.sql /usr/src/app/init-db.sql

# Cambia permisos para el script de entrada
RUN chmod +x /usr/src/app/entrypoint.sh

# Expone el puerto predeterminado de SQL Server
EXPOSE 1433

# Usa el script de entrada
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
