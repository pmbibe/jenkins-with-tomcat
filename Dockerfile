FROM tomcat:8.0-alpine
LABEL maintainer="pmbibe@github.com"

ARG filePath

ADD $filePath /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]