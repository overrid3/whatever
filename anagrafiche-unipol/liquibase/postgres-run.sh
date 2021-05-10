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
#. $LOCAL_DIRECTORY/env.properties

echo "$ENTRYPOINT_cname CLASSPATH = /liquibase/lib/postgresql-42.2.20.jar";
echo "$ENTRYPOINT_cname CONTEXTS=Anagrafiche_BIC_DIRECTORY_PLUS,Anagrafiche_COUNTRY,Anagrafiche_CURRENCY,CommonMonitor_J0TDOMAIN,DriverCommon_J0TCURRENT_REVISION,CommonMonitor_J0TGROU_EVID,CommonMonitor_J0TGROU_EVID_REL,DriverCommon_J0TMQDUMPER,CommonMonitor_J0TORGANIZATION,DriverCommon_J0TPARTICIPANT_NEW,CommonMonitor_J0TREQUEST_TYPE,DriverCommon_J0TRESOURCES_ZIP,CommonAdmin_J0TTEMPLATE,CommonMonitor_J0TTOPIC,CommonMonitor_J0TTSINP,CommonMonitor_J0TTSINS,CommonMonitor_J0TTSISR,CommonMonitor_J0TTSOUS,CommonMonitor_J0TTSOUT,CommonMonitor_J0TTSRTS,CommonMonitor_J0TTSSTA,CommonMonitor_J0TTTRSZ,DriverCommon_J0TWEB_REPORT,DriverCommon_J1TWORKING_PROCESS,DriverCommon_JETNETWORK_MESSAGE_SUSP,user_profiler_ROLE,DriverCommon_YWTWIBAP,dev";

#input properties
echo "$ENTRYPOINT_cname CONNECTION_STRING_OWNER = jdbc:postgresql://local/netgat/anagrafiche/postgres-unipol:5432";
echo "$ENTRYPOINT_cname CHANGE_LOG_DDL_OWNER = /liquibase/changelog/master_changelog_owner.xml";
echo "$ENTRYPOINT_cname DB_OWNER_USERNAME = docker";
echo "$ENTRYPOINT_cname DB_OWNER_PASSWORD = docker";
echo "$ENTRYPOINT_cname DATA_TABLE_SPACE = TS_DATA";
echo "$ENTRYPOINT_cname INDEX_TABLE_SPACE = TS_INDEX";
echo "$ENTRYPOINT_cname DB_OWNER = docker";
echo "$ENTRYPOINT_cname DB_USER = docker";

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
    update \
    -Ddbowner=$DB_OWNER \
    -Ddbuser=$DB_USER \
    -DtablesTablespaceName=$DATA_TABLE_SPACE \
    -DindexesTablespaceName=$INDEX_TABLE_SPACE \
    -Dliquibasetype=two \
    -DuseDatabaseChangeLog=true
printf "\n\ndone\n\n\n\n"
