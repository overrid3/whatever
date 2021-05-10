#!/usr/bin/env bash

ENTRYPOINT_cname="${0##*/}:"

echo "$ENTRYPOINT_cname verify environment:"

usage() {
    cat << USAGE >&2
Missing required parameter: $1
Usage:
    $ENTRYPOINT_cname define the following environment variables:
    CONNECTION_STRING_OWNER     Connection String for owner
    CHANGE_LOG_DDL_OWNER        absolute path to changeLogFile for data definition for owner
    DB_OWNER_USERNAME           owner username
    DB_OWNER_PASSWORD           owner password
    CONNECTION_STRING_USER      Connection String for user
    CHANGE_LOG_DDL_USER         absolute path to changeLogFile for data definition for user
    DB_USER_USERNAME            user username
    DB_USER_PASSWORD            user password
    DATA_TABLE_SPACE            data tablespace name
    INDEX_TABLE_SPACE           index tablespace name
    DB_OWNER                    db owner user
    DB_USER                     db user user
    CONTEXTS                    contexts
USAGE
    exit 1
}

export CLASSPATH=/liquibase/lib/postgresql-42.2.20.jar:/liquibase/changelog

echo "$ENTRYPOINT_cname CONNECTION_STRING_OWNER = $CONNECTION_STRING_OWNER";
echo "$ENTRYPOINT_cname CHANGE_LOG_DDL_OWNER = $CHANGE_LOG_DDL_OWNER";
echo "$ENTRYPOINT_cname DB_OWNER_USERNAME = $DB_OWNER_USERNAME";
echo "$ENTRYPOINT_cname DB_OWNER_PASSWORD = $DB_OWNER_PASSWORD";
echo "$ENTRYPOINT_cname CONNECTION_STRING_USER = $CONNECTION_STRING_USER";
echo "$ENTRYPOINT_cname CHANGE_LOG_DDL_USER = $CHANGE_LOG_DDL_USER";
echo "$ENTRYPOINT_cname DB_USER_USERNAME = $DB_USER_USERNAME";
echo "$ENTRYPOINT_cname DB_USER_PASSWORD = $DB_USER_PASSWORD";
echo "$ENTRYPOINT_cname DATA_TABLE_SPACE = $DATA_TABLE_SPACE";
echo "$ENTRYPOINT_cname INDEX_TABLE_SPACE = $INDEX_TABLE_SPACE";
echo "$ENTRYPOINT_cname DB_OWNER = $DB_OWNER";
echo "$ENTRYPOINT_cname DB_USER = $DB_USER";
echo "$ENTRYPOINT_cname CONTEXTS = $CONTEXTS";

if [ -z "${CONNECTION_STRING_OWNER}" ]; then
    usage "CONNECTION_STRING_OWNER"
    exit 1
fi
if [ -z "${CHANGE_LOG_DDL_OWNER}" ]; then
    usage "CHANGE_LOG_DDL_OWNER"
    exit 1
fi
if [ -z "${DB_OWNER_USERNAME}" ]; then
    usage "DB_OWNER_USERNAME"
    exit 1
fi
if [ -z "${DB_OWNER_PASSWORD}" ]; then
    usage "DB_OWNER_PASSWORD"
    exit 1
fi
if [ -z "${CONNECTION_STRING_USER}" ]; then
    usage "CONNECTION_STRING_USER"
    exit 1
fi
if [ -z "${CHANGE_LOG_DDL_USER}" ]; then
    usage "CHANGE_LOG_DDL_USER"
    exit 1
fi
if [ -z "${DB_USER_USERNAME}" ]; then
    usage "DB_USER_USERNAME"
    exit 1
fi
if [ -z "${DB_USER_PASSWORD}" ]; then
    usage "DB_USER_PASSWORD"
    exit 1
fi
if [ -z "${DATA_TABLE_SPACE}" ]; then
    usage "DATA_TABLE_SPACE"
    exit 1
fi
if [ -z "${INDEX_TABLE_SPACE}" ]; then
    usage "INDEX_TABLE_SPACE"
    exit 1
fi
if [ -z "${DB_OWNER}" ]; then
    usage "DB_OWNER"
    exit 1
fi
if [ -z "${DB_USER}" ]; then
    usage "DB_USER"
    exit 1
fi
if [ -z "${CONTEXTS}" ]; then
    usage "CONTEXTS"
    exit 1
fi

echo "$ENTRYPOINT_cname run liquibase CHANGE_LOG_DDL_OWNER"
printf "\n\nExecuting Liquibase to EXECUTE SQL for $DB_OWNER_USERNAME...\n\n"
/liquibase/liquibase \
    --url=$CONNECTION_STRING_OWNER \
    --classpath=$CLASSPATH \
    --changeLogFile=$CHANGE_LOG_DDL_OWNER \
    --username=$DB_OWNER_USERNAME \
    --password=$DB_OWNER_PASSWORD \
    --contexts=$CONTEXTS \
    --logLevel=debug --logFile=./liquibase_owner.log \
    --driverPropertiesFile=./driver.properties \
    update \
    -Ddbowner=$DB_OWNER \
    -Ddbuser=$DB_USER \
    -DtablesTablespaceName=$DATA_TABLE_SPACE \
    -DindexesTablespaceName=$INDEX_TABLE_SPACE \
    -Dliquibasetype=two \
    -DuseDatabaseChangeLog=true
printf "\n\ndone\n\n\n\n"

echo "$ENTRYPOINT_cname run liquibase CHANGE_LOG_DDL_USER"
printf "\n\nExecuting Liquibase to EXECUTE SQL for $DB_USER_USERNAME....\n\n"
/liquibase/liquibase \
    --url=$CONNECTION_STRING_USER \
    --classpath=$CLASSPATH \
    --changeLogFile=$CHANGE_LOG_DDL_USER \
    --username=$DB_USER_USERNAME \
    --password=$DB_USER_PASSWORD \
    --contexts=$CONTEXTS \
    --logLevel=debug --logFile=./liquibase_user.log \
    --driverPropertiesFile=./driver.properties \
    --liquibaseSchemaName=$DB_OWNER_USERNAME \
    update \
    -Ddbowner=$DB_OWNER \
    -Ddbuser=$DB_USER \
    -Dliquibasetype=two \
    -DuseDatabaseChangeLog=true
printf "\n\ndone\n\n\n\n"



