#!/bin/bash

# Switch to oracle user and start database services
sudo su - oracle <<EOF
lsnrctl status > /dev/null 2>&1 || lsnrctl start
sqlplus / as sysdba <<SQL
STARTUP;
EXIT;
SQL
EOF

# Check if Oracle database started successfully
if sudo su - oracle -c "sqlplus / as sysdba <<SQL
    SELECT 'Database Started' FROM dual;
    EXIT;
SQL" | grep -q "Database Started"; then
    echo "Oracle database started successfully."
else
    echo "Failed to start Oracle database."
    exit 1
fi

# Show the current WSL IP
echo "Oracle is running. Connect using this IP:"
ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
