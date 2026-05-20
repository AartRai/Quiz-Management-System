# Build stage
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage
FROM openjdk:17-slim
WORKDIR /app
COPY --from=build /app/target/Quiz-Application-1.0-SNAPSHOT-jar-with-dependencies.jar quiz-app.jar
ENTRYPOINT ["java", "-jar", "quiz-app.jar"]
