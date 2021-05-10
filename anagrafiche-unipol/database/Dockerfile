FROM postgres:12

ADD ./database/init.sql /docker-entrypoint-initdb.d/
# to make liquibase starts when the database is ready
#ADD ./database/check_database_is_ready.sh /healthcheck/check_database_is_ready.sh
#RUN chmod 0755 /healthcheck/check_database_is_ready.sh
#
#ADD ./database/warn_liquibase_to_start.sh /docker-entrypoint-initdb.d/
#RUN chmod 0755 /docker-entrypoint-initdb.d/warn_liquibase_to_start.sh