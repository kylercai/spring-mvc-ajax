FROM tomcat:latest
EXPOSE 8080
COPY build/libs/spring-mvc-ajax.war /usr/local/tomcat/webapps/spring-mvc-ajax.war
RUN /usr/local/tomcat/bin/startup.sh