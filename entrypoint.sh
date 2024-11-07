#!/bin/bash

# Inicia SQL Server en segundo plano
/opt/mssql/bin/sqlservr &

# Espera unos segundos para asegurar que el servidor esté listo
sleep 15

# Ejecuta el script de inicialización
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -d master -i /usr/src/app/init-db.sql

# Espera indefinidamente para mantener el contenedor activo
wait
