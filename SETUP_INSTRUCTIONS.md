# Student Management System - Setup Instructions

This document provides detailed instructions for setting up and running the Student Management System.

## Prerequisites

### Required Software
- **Java 11 or higher** - Download from [Oracle](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://openjdk.java.net/)
- **Maven 3.6+** - Download from [Apache Maven](https://maven.apache.org/download.cgi)
- **Node.js 16+ and npm** - Download from [Node.js](https://nodejs.org/)
- **MySQL 8.0+** - Download from [MySQL](https://dev.mysql.com/downloads/mysql/)
- **Apache Tomcat 9.0+** - Download from [Apache Tomcat](https://tomcat.apache.org/download-90.cgi)

### Development Tools (Optional)
- **IDE**: IntelliJ IDEA, Eclipse, or VS Code
- **Database Client**: MySQL Workbench, DBeaver, or phpMyAdmin

## Database Setup

### 1. Install and Configure MySQL

1. **Install MySQL Server**
   ```bash
   # On macOS with Homebrew
   brew install mysql
   brew services start mysql
   
   # On Ubuntu/Debian
   sudo apt update
   sudo apt install mysql-server
   sudo systemctl start mysql
   
   # On Windows
   # Download and run the MySQL installer
   ```

2. **Secure MySQL Installation**
   ```bash
   sudo mysql_secure_installation
   ```

3. **Create Database and User**
   ```sql
   # Login to MySQL
   mysql -u root -p
   
   # Create database
   CREATE DATABASE student_management;
   
   # Create user (optional, you can use root)
   CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'your_password';
   GRANT ALL PRIVILEGES ON student_management.* TO 'student_user'@'localhost';
   FLUSH PRIVILEGES;
   ```

### 2. Run Database Schema

1. **Execute the SQL script**
   ```bash
   mysql -u root -p student_management < database/schema.sql
   ```

2. **Verify database setup**
   ```sql
   USE student_management;
   SHOW TABLES;
   SELECT * FROM students;
   SELECT * FROM admin;
   ```

## Backend Setup

### 1. Configure Database Connection

Edit the database configuration file:
```java
// backend/src/main/java/com/studentmanagement/config/DatabaseConfig.java

public static final String DB_URL = "jdbc:mysql://localhost:3306/student_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
public static final String DB_USERNAME = "root"; // or your MySQL username
public static final String DB_PASSWORD = "your_mysql_password"; // Change this!
```



### 2. Build the Backend

```bash
# Navigate to backend directory
cd backend

# Clean and compile
mvn clean compile

# Run tests (optional)
mvn test

# Package the application
mvn package
```

### 3. Deploy to Tomcat

#### Option A: Using Tomcat Maven Plugin (Development)
```bash
# From the backend directory
mvn tomcat7:run
```
The application will be available at: `http://localhost:8080/student-management`

#### Option B: Manual Deployment
1. **Copy WAR file to Tomcat**
   ```bash
   cp target/student-management.war $TOMCAT_HOME/webapps/
   ```

2. **Start Tomcat**
   ```bash
   # On macOS/Linux
   $TOMCAT_HOME/bin/startup.sh
   
   # On Windows
   $TOMCAT_HOME/bin/startup.bat
   ```

3. **Access the application**
   - URL: `http://localhost:8080/student-management`
   - API Base: `http://localhost:8080/student-management/api`

## Frontend Setup

### 1. Install Dependencies

```bash
# Navigate to frontend directory
cd frontend

# Install npm packages
npm install
```

### 2. Configure API Endpoints

The frontend is already configured to connect to the backend API. The proxy is set in `package.json`:
```json
"proxy": "http://localhost:8080"
```

### 3. Start the Frontend

```bash
# Start development server
npm start
```

The frontend will be available at: `http://localhost:3000`

## Running the Application

### 1. Start the Backend
```bash
cd backend
mvn tomcat7:run
```

### 2. Start the Frontend (in a new terminal)
```bash
cd frontend
npm start
```

### 3. Access the Application
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8080/student-management/api

## Default Login Credentials

- **Username**: admin
- **Password**: admin123

## API Endpoints

### Student Management
- `GET /api/students` - Get all students
- `GET /api/students/{id}` - Get student by ID
- `POST /api/students` - Add new student
- `PUT /api/students/{id}` - Update student
- `DELETE /api/students/{id}` - Delete student

### Dashboard
- `GET /api/dashboard/stats` - Get dashboard statistics

## Troubleshooting

### Common Issues

#### 1. Database Connection Issues
```bash
# Check MySQL service
sudo systemctl status mysql  # Linux
brew services list | grep mysql  # macOS

# Test connection
mysql -u root -p -e "SELECT 1"
```

#### 2. Port Conflicts
```bash
# Check if ports are in use
lsof -i :8080  # Backend port
lsof -i :3000  # Frontend port
lsof -i :3306  # MySQL port
```

#### 3. Maven Build Issues
```bash
# Clean and rebuild
mvn clean
mvn compile
mvn package
```

#### 4. Node.js Issues
```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Logs and Debugging

#### Backend Logs
- Check Tomcat logs: `$TOMCAT_HOME/logs/catalina.out`
- Application logs are configured with SLF4J and Logback

#### Frontend Logs
- Check browser console for JavaScript errors
- Check network tab for API call failures

## Production Deployment

### Backend Production Setup
1. **Configure production database**
2. **Set up connection pooling**
3. **Configure logging levels**
4. **Set up monitoring**

### Frontend Production Build
```bash
cd frontend
npm run build
# Deploy the 'build' folder to your web server
```

## Security Considerations

1. **Change default passwords**
2. **Use HTTPS in production**
3. **Configure CORS properly**
4. **Set up proper authentication**
5. **Use environment variables for sensitive data**

## Support

For issues and questions:
1. Check the logs for error messages
2. Verify all prerequisites are installed
3. Ensure database is running and accessible
4. Check firewall settings for port access
