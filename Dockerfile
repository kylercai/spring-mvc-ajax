FROM tomcat:latest
EXPOSE 8080
RUN rm -fr /usr/local/tomcat/webapps/ROOT
COPY build/libs/s.war /usr/local/tomcat/webapps/ROOT.war
RUN /usr/local/tomcat/bin/startup.sh