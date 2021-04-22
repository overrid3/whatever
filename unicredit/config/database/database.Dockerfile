FROM quay.io/maksymbilenko/oracle-xe-11g

ADD ./config/database/init.sql /docker-entrypoint-initdb.d/

# to make liquibase starts when the database is ready
ADD ./config/database/check_database_is_ready.sh /healthcheck/check_database_is_ready.sh
RUN chmod 0755 /healthcheck/check_database_is_ready.sh

# tells to liquibase to start
ADD ./config/database/warn_liquibase_to_start.sh /docker-entrypoint-initdb.d/
RUN chmod 0755 /docker-entrypoint-initdb.d/warn_liquibase_to_start.sh
