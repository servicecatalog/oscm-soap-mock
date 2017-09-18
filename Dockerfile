FROM tomee:8-jre-7.0.3-plume

ADD ./target/oscm-soap-mock.war /usr/local/tomee/webapps/oscm-soap-mock.war
ADD ./tomee/tomcat-users.xml /usr/local/tomee/config/tomcat-users.xml
CMD ["catalina.sh", "run"]
