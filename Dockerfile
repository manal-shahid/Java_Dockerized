# ====== BUILD STAGE ======
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copy all source code
COPY . .

# Build the JAR without running tests
RUN mvn clean package -DskipTests

# ====== RUNTIME STAGE ======
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copy only the built JAR from previous stage
COPY --from=build /app/target/spring-boot-3-rest-api-example-0.0.1-SNAPSHOT.jar app.jar

# Expose Spring Boot default port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
