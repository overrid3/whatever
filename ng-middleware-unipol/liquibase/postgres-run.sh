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
    DB_USER_PASSWORD            user password
    DATA_TABLE_SPACE            data tablespace name
    INDEX_TABLE_SPACE           index tablespace name
    DB_OWNER                    db owner user
    DB_USER                     db user user
USAGE
    exit 1
}

LOCAL_DIRECTORY="$( dirname "${BASH_SOURCE[0]}" )"
#load properties from env.properties
# shellcheck disable=SC1090
. $LOCAL_DIRECTORY/env.properties

echo "$ENTRYPOINT_cname CLASSPATH = $CLASSPATH";
echo "$ENTRYPOINT_cname CONTEXTS = $CONTEXTS";

#input properties
echo "$ENTRYPOINT_cname CONNECTION_STRING_OWNER = $CONNECTION_STRING_OWNER";
echo "$ENTRYPOINT_cname CHANGE_LOG_DDL_OWNER = $CHANGE_LOG_DDL_OWNER";
echo "$ENTRYPOINT_cname DB_OWNER_USERNAME = $DB_OWNER_USERNAME";
echo "$ENTRYPOINT_cname DB_OWNER_PASSWORD = $DB_OWNER_PASSWORD";
echo "$ENTRYPOINT_cname DATA_TABLE_SPACE = $DATA_TABLE_SPACE";
echo "$ENTRYPOINT_cname INDEX_TABLE_SPACE = $INDEX_TABLE_SPACE";
echo "$ENTRYPOINT_cname DB_OWNER = $DB_OWNER";
echo "$ENTRYPOINT_cname DB_USER = $DB_USER";

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
    --outputFile=./update_owner.sql \
    update \
    -Ddbowner=$DB_OWNER \
    -Ddbuser=$DB_USER \
    -DtablesTablespaceName=$DATA_TABLE_SPACE \
    -DindexesTablespaceName=$INDEX_TABLE_SPACE \
    -Dliquibasetype=two \
    -DuseDatabaseChangeLog=true
printf "\n\ndone\n\n\n\n"
sleep 20m