FROM jboss/wildfly:14.0.1.Final

COPY ./deployments/   /opt/jboss/wildfly/standalone/deployments/
COPY ./modules/       /opt/jboss/wildfly/modules/
COPY ./configuration/ /opt/jboss/wildfly/standalone/configuration/

USER root
RUN chmod -R 777 /opt/jboss/wildfly/standalone/deployments/
RUN chmod -R 777 /opt/jboss/wildfly/modules/
RUN chmod -R 777 /opt/jboss/wildfly/standalone/configuration/

RUN chmod g+rwx /opt/jboss/wildfly/standalone/tmp/auth/
