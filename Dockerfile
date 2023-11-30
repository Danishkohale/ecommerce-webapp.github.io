FROM alpine:latest
ENV CATALINA_HOME /usr/local/tomcat
RUN apk update && apk add openjdk8 curl && rm -rf /var/cache/apk/*
RUN curl -o apache-tomcat-9.0.78.tar.gz https://downloads.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz && \
    tar -zxvf apache-tomcat-9.0.78.tar.gz && \
    mv apache-tomcat-9.0.78 ${CATALINA_HOME} && \
    rm apache-tomcat-9.0.78.tar.gz
COPY tomcat-users.xml ${CATALINA_HOME}/conf/tomcat-users.xml
COPY context.xml ${CATALINA_HOME}/webapps/manager/META-INF/context.xml
COPY context.xml ${CATALINA_HOME}/webapps/host-manager/META-INF/context.xml
RUN  mkdir /usr/local/tomcat/webapps/html-files  
COPY index.html /usr/local/tomcat/webapps/html-files/
COPY index.css /usr/local/tomcat/webapps/html-files/
COPY index.js /usr/local/tomcat/webapps/html-files/
COPY media/ /usr/local/tomcat/webapps/html-files/


EXPOSE 8080
CMD ["sh", "-c", "${CATALINA_HOME}/bin/catalina.sh run"]