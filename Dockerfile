# Stage 1: Build the application with Maven
FROM maven:3.8.4-openjdk-21-slim AS builder

WORKDIR /app

# Copy only the necessary files for Maven dependency resolution
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Stage 2: Create the final Docker image
FROM openjdk:21

WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=builder /app/target/leasing-0.0.1-SNAPSHOT.jar ./app.jar

# Expose port 8080
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
