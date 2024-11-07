# Usa la imagen oficial de SQL Server 2022 Express
FROM mcr.microsoft.com/mssql/server:2022-latest

# Establece variables de entorno
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

# Copia los archivos necesarios
COPY --chown=mssql:mssql entrypoint.sh /usr/src/app/entrypoint.sh
COPY --chown=mssql:mssql init-db.sql /usr/src/app/init-db.sql

# Establece el puerto predeterminado de SQL Server
EXPOSE 1433

# Ejecuta el script de entrada usando bash
USER mssql
CMD ["bash", "/usr/src/app/entrypoint.sh"]
