#FROM liquibase/liquibase:3.10.x
FROM liquibase/liquibase

USER root
RUN apt-get update && apt-get install -y netcat
USER liquibase

ADD ./resources/ojdbc.jar /liquibase/lib/

ADD ./delivery/liquibase /liquibase/changelog

ADD ./liquibase/liquibase-entrypoint.sh /liquibase
ADD ./liquibase/driver.properties /liquibase

USER root
RUN chmod -R 777 /liquibase
USER liquibase

ENTRYPOINT ["/bin/bash", "/liquibase/liquibase-entrypoint.sh"]
