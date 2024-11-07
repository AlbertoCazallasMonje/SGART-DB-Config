#!/bin/bash

# Inicia SQL Server en segundo plano
/opt/mssql/bin/sqlservr &

# Espera unos segundos para asegurar que el servidor esté listo
sleep 15

# Ejecuta el script de inicialización si `sqlcmd` está disponible
if [ -f "/opt/mssql-tools/bin/sqlcmd" ]; then
    /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -d master -i /usr/src/app/init-db.sql
else
    echo "sqlcmd no está disponible en /opt/mssql-tools/bin/sqlcmd"
fi

# Espera indefinidamente para mantener el contenedor activo
wait
