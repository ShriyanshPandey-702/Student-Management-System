# =========================
# Build stage
# =========================
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /build

# Copy pom.xml first for better layer caching
COPY backend/pom.xml ./pom.xml

# Download dependencies (cached layer)
RUN mvn dependency:go-offline -B

# Copy source code
COPY backend/src ./src

# Build the application
RUN mvn clean package -DskipTests && \
    ls -la target/ && \
    echo "Build completed: $(ls -lh target/*.war)"

# =========================
# Runtime stage
# =========================
FROM tomcat:10.1-jdk21

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR with proper context path
COPY --from=build /build/target/student-management.war \
    /usr/local/tomcat/webapps/student-management.war

# Set environment variables with defaults
ENV DB_URL="jdbc:mysql://localhost:3306/student_management?useSSL=false&serverTimezone=UTC" \
    DB_USER="root" \
    DB_PASS="root" \
    PORT="8080"

# Create startup script to handle dynamic PORT
RUN echo '#!/bin/bash' > /start.sh && \
    echo 'sed -i "s/8080/${PORT}/g" /usr/local/tomcat/conf/server.xml' >> /start.sh && \
    echo 'echo "Starting Tomcat on port ${PORT}..."' >> /start.sh && \
    echo 'echo "DB_URL: ${DB_URL}"' >> /start.sh && \
    echo 'echo "DB_USER: ${DB_USER}"' >> /start.sh && \
    echo 'catalina.sh run' >> /start.sh && \
    chmod +x /start.sh

# Expose port (will be overridden by $PORT)
EXPOSE ${PORT}

# Start with custom script
CMD ["/start.sh"]
