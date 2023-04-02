#
# Build stage
#
FROM maven:3.5-jdk-11-slim AS BUILD
COPY . .
RUN mvn clean install -DskipTests

#
# Package stage
#
FROM openjdk:11-jdk-slim
COPY --from=build target/formatec-1-0.0.1-SNAPSHOT.jar formatec-1-0.0.1-SNAPSHOT.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","formatec-1-0.0.1-SNAPSHOT.jar"]
