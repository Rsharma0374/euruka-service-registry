
# Step 1: Build the Java Maven application
FROM maven:3.9.9-eclipse-temurin-17 AS build
# Set the working directory
WORKDIR /build

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Stage 2: Run the application
FROM openjdk:17-jdk-slim


# Copy Java application
COPY --from=build /build/target/*.jar /app/service-registry.jar

# Create logs directory
RUN mkdir -p /opt/logs && chmod 755 /opt/logs

# Expose ports for Nginx and Java application
EXPOSE 8761

# Run the application
ENTRYPOINT ["java", "-jar", "/app/service-registry.jar"]