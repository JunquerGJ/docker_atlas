#!/bin/bash
dbUser=`cat /run/secrets/dbUser`
dbUserPass=`cat /run/secrets/dbUserPass`
dbName=`cat /run/secrets/dbName`
dbRootUser=`cat /run/secrets/dbRootUser`
dbDefaultDB=`cat /run/secrets/dbDefaultDB`

printf "CREATE USER %s PASSWORD %s;\nCREATE DATABASE %s;\nGRANT ALL PRIVILEGES ON DATABASE %s TO %s;" $dbUser $dbUserPass $dbName $dbName $dbUser
psql -v ON_ERROR_STOP=1 --username $dbRootUser --dbname postgres <<-EOSQL
    CREATE USER $dbUser WITH PASSWORD '$dbUserPass';
    CREATE DATABASE $dbName;
    GRANT ALL PRIVILEGES ON DATABASE $dbName TO $dbUser;
EOSQL
