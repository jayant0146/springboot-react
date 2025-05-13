FROM maven:3.8.5-openjdk-17 AS build
RUN mkdir -p /app
WORKDIR /app
COPY pom.xml /app
COPY src /app/src
RUN mvn -f pom.xml clean package


FROM openjdk:17-jdk-alpine3.14
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]