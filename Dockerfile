# Stage 1: Build the application with Maven
FROM maven:latest AS builder

WORKDIR /app

# Copy only the necessary files for Maven dependency resolution
COPY pom.xml /app
COPY mvn dependecy:resolve
COPY . /app

# Build the application
RUN mvn clean
RUN mvn package -DskipTests

# Stage 2: Create the final Docker image
FROM openjdk:21

WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
