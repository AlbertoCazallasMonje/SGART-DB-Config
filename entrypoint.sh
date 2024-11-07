#!/bin/bash

# Inicia SQL Server en segundo plano con permisos elevados
sudo /opt/mssql/bin/sqlservr &

# Espera hasta que SQL Server esté completamente inicializado
sleep 30

# Verifica si sqlcmd está disponible y ejecuta el script de inicialización
if command -v sqlcmd > /dev/null; then
    /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -d master -i /usr/src/app/init-db.sql
else
    echo "sqlcmd no está disponible en /opt/mssql-tools/bin/sqlcmd"
fi

# Mantiene el contenedor activo
wait
