#Stage 1

FROM maven:3.8.6-jdk-8 AS build

WORKDIR /app

COPY src ./src
COPY pom.xml ./pom.xml

RUN mvn clean install

#Stage 2

FROM tomcat:8.5

COPY --from=build /app/target/demo.war /usr/local/tomcat/webapps/demo.war

RUN echo "export JAVA_OPTS=\"-Dapp.env=staging\"" > /usr/local/tomcat/bin/setenv.sh

EXPOSE 8080

CMD ["catalina.sh", "run"]
