FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /build

# Copy backend pom and source
COPY backend/pom.xml ./pom.xml
COPY backend/src ./src

# Build the application
RUN mvn clean package -DskipTests && \
    ls -la target/ && \
    echo "Build completed successfully"

# Runtime stage - Use Tomcat
FROM tomcat:10.1-jdk21

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file
COPY --from=build /build/target/student-management.war /usr/local/tomcat/webapps/student-management.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
