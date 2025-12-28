# 🐳 LOCAL DEVELOPMENT GUIDE

## 🚀 Quick Start with Docker Compose

### **Option 1: Full Stack with Docker Compose** (Recommended)

```bash
# 1. Start all services (database + backend)
docker-compose up -d

# 2. Check logs
docker-compose logs -f backend

# 3. Access application
# Backend: http://localhost:8080/student-management/api
# Database: localhost:3306
```

**What this does:**
- ✅ Starts MySQL database on port 3306
- ✅ Imports schema.sql automatically
- ✅ Builds and starts backend on port 8080
- ✅ Creates network for service communication

---

### **Option 2: Database Only (If running backend in IDE)**

```bash
# Start only MySQL
docker-compose up db -d

# Your .env should use:
DB_URL=jdbc:mysql://localhost:3306/student_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
DB_USER=root
DB_PASS=Shriyansh@123
```

Then run backend from your IDE (Eclipse/IntelliJ/VS Code)

---

## 📝 Environment Configuration

### **For Docker Compose (both services):**
```env
# .env file
MYSQL_ROOT_PASSWORD=Shriyansh@123
MYSQL_DATABASE=student_management

# Backend will automatically use 'db' as hostname
```

### **For Local IDE Development (database only):**
```env
# .env file
DB_URL=jdbc:mysql://localhost:3306/student_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
DB_USER=root
DB_PASS=Shriyansh@123
```

---

## 🔧 Useful Docker Commands

```bash
# View running containers
docker ps

# View all containers (including stopped)
docker ps -a

# View logs
docker-compose logs -f backend
docker-compose logs -f db

# Stop services
docker-compose down

# Stop and remove volumes (fresh start)
docker-compose down -v

# Rebuild backend after code changes
docker-compose up -d --build backend

# Access MySQL shell
docker exec -it sms_db mysql -uroot -pShriyansh@123 student_management

# Check backend health
curl http://localhost:8080/student-management/api/students
```

---

## 🧪 Testing Backend Locally

```bash
# 1. Check health
curl http://localhost:8080/student-management/api/students

# 2. Admin login
curl -X POST http://localhost:8080/student-management/api/auth/admin/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'

# 3. Get all students
curl http://localhost:8080/student-management/api/students

# 4. Add student
curl -X POST http://localhost:8080/student-management/api/students \
  -H "Content-Type: application/json" \
  -d '{
    "name":"Test Student",
    "email":"test@test.com",
    "phone":"1234567890",
    "course":"Computer Science",
    "gender":"Male",
    "dob":"2000-01-01",
    "city":"Mumbai"
  }'
```

---

## 🎯 Frontend Development

```bash
# Navigate to frontend
cd frontend

# Install dependencies
npm install

# Create .env.local file
echo "REACT_APP_API_URL=http://localhost:8080/student-management/api" > .env.local

# Start development server
npm start

# Build for production
npm run build
```

---

## 📊 Database Schema

The schema is automatically imported from `database/schema.sql` when MySQL container starts for the first time.

**Manual import:**
```bash
# If you need to reimport
docker exec -i sms_db mysql -uroot -pShriyansh@123 student_management < database/schema.sql
```

---

## 🔍 Troubleshooting Local Development

### **Issue: "Port 3306 already in use"**
**Solution**: Stop local MySQL service
```bash
# macOS
brew services stop mysql

# Linux
sudo systemctl stop mysql

# Windows
net stop MySQL80
```

### **Issue: "Port 8080 already in use"**
**Solution**: Change port in docker-compose.yml
```yaml
backend:
  ports:
    - "8081:8080"  # Use 8081 instead
```

### **Issue: "Database connection refused"**
**Solution**: Wait for MySQL to fully start
```bash
# Check MySQL logs
docker-compose logs db

# Wait for: "mysqld: ready for connections"
```

### **Issue: "Cannot connect to Docker daemon"**
**Solution**: Start Docker Desktop
```bash
# Ensure Docker Desktop is running
docker info
```

---

## 🧹 Clean Up

```bash
# Stop all services
docker-compose down

# Remove volumes (database data)
docker-compose down -v

# Remove images
docker rmi $(docker images -q student-management-system*)

# Clean Docker system
docker system prune -a
```

---

## 🎨 IDE Configuration

### **VS Code**
Install extensions:
- Java Extension Pack
- Spring Boot Extension Pack
- Docker
- REST Client

### **IntelliJ IDEA**
- Configure JDK 21
- Enable Maven auto-import
- Set project SDK to Java 21

### **Eclipse**
- Install Java EE Tools
- Configure Tomcat server
- Set Java compiler to 21

---

## 📈 Performance Tips

1. **Use Docker layer caching** - Don't change pom.xml frequently
2. **Use `.dockerignore`** - Exclude unnecessary files
3. **Allocate more resources** - Docker Desktop Settings → Resources
4. **Use named volumes** - Faster than bind mounts

---

**✅ HAPPY CODING!** 🚀
