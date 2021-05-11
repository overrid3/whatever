#FROM liquibase/liquibase:3.10.x
FROM liquibase/liquibase

USER root
RUN apt-get update && apt-get install -y netcat
USER liquibase

ADD ./liquibase/tasgroupDBDriver.jar /liquibase/lib/

ADD ./delivery/liquibase/ /liquibase/changelog/

ADD ./liquibase/postgres-run.sh /liquibase
ADD ./liquibase/env.properties /liquibase

USER root
RUN chmod -R 777 /liquibase
USER liquibase

ENTRYPOINT ["/bin/bash", "/liquibase/postgres-run.sh"]

