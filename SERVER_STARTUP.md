# Server Startup Guide

## ✅ Current Status

### 1. **MySQL Database** - ✅ RUNNING
- Status: Already running (PID: 558)
- Default Port: 3306
- No action needed

### 2. **Frontend (React)** - ✅ RUNNING
- Status: Successfully started
- URL: http://localhost:3000
- Network: http://192.168.0.100:3000
- Logs: /tmp/frontend.log

### 3. **Backend (Java Servlet)** - ⚠️ NEEDS MAVEN

## 🔧 Installing Maven

Since Maven is not installed on your system, you have a few options:

### Option 1: Install Homebrew (Recommended)
```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then install Maven
brew install maven
```

### Option 2: Download Maven Manually
1. Download Maven from: https://maven.apache.org/download.cgi
2. Extract to a location (e.g., ~/apache-maven-3.9.9)
3. Add to PATH:
   ```bash
   export PATH=~/apache-maven-3.9.9/bin:$PATH
   ```

### Option 3: Use the project's existing compiled code
Since the backend has already been compiled (target/ directory exists), you can try:

```bash
cd "/Users/shriyansh/Desktop/Student Management System/backend"
java -cp "target/classes:target/student-management/WEB-INF/lib/*" org.apache.catalina.startup.Tomcat
```

## 🚀 Once Maven is Installed

### Start Backend Server:
```bash
cd "/Users/shriyansh/Desktop/Student Management System/backend"
mvn clean tomcat7:run
```

The backend will start on: **http://localhost:8080/student-management**

## 📊 Full System URLs

Once all three are running:

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8080/student-management/api
- **MySQL Database**: localhost:3306

## 🗄️ Database Setup

Make sure the database is initialized:

```bash
mysql -u root -p < "/Users/shriyansh/Desktop/Student Management System/database/schema.sql"
```

Default database credentials (update in DatabaseConfig.java if different):
- Database: student_management
- Username: root
- Password: password

## 🎯 Quick Start Commands

### Check All Servers:
```bash
# Check Frontend
curl http://localhost:3000

# Check Backend (once running)
curl http://localhost:8080/student-management/api/students

# Check MySQL
mysql -u root -p -e "SHOW DATABASES;"
```

### Stop Servers:
```bash
# Stop Frontend
pkill -f "react-scripts"

# Stop Backend
pkill -f "tomcat7"

# Stop MySQL (if needed)
brew services stop mysql
# or
sudo /usr/local/mysql/support-files/mysql.server stop
```

## 🔍 Troubleshooting

### Frontend Issues:
```bash
# View logs
tail -f /tmp/frontend.log

# Restart
pkill -f "react-scripts"
cd frontend && npm start
```

### Backend Issues:
```bash
# View logs
tail -f /tmp/backend.log

# Check if port 8080 is in use
lsof -i :8080

# Clean and rebuild
cd backend
mvn clean install
mvn tomcat7:run
```

### Database Issues:
```bash
# Check MySQL status
mysql.server status

# Restart MySQL
mysql.server restart

# Check if database exists
mysql -u root -p -e "SHOW DATABASES LIKE 'student_management';"
```

## ✨ What's Working Now

1. **Frontend** is live at http://localhost:3000 with:
   - ✅ Dark mode toggle
   - ✅ Animated background
   - ✅ All pages styled with proper contrast
   - ✅ Login, Dashboard, Students, Add/Edit forms

2. **Database** is running and ready

3. **Backend** just needs Maven to be installed, then it will serve the REST API

## 🎨 Features to Test Once Backend is Running

- Login with: admin / admin123
- Add new students with gender, DOB, and city fields
- View students table with all new fields
- Edit student information
- Delete students
- Test dark mode across all pages
