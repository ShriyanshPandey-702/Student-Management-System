# 🚀 PRODUCTION DEPLOYMENT GUIDE - RENDER

## ✅ PRE-DEPLOYMENT CHECKLIST

- [x] Railway MySQL Database deployed
- [x] Database schema imported
- [x] Dockerfile fixed with dynamic PORT support
- [x] Docker-compose.yml updated with backend service
- [x] Frontend configured with environment variables
- [x] All files committed to GitHub

---

## 📋 RENDER DEPLOYMENT STEPS

### **STEP 1: Deploy Backend Web Service**

1. **Go to Render Dashboard** → [https://dashboard.render.com/](https://dashboard.render.com/)

2. **Create New Web Service**:
   - Click **"New +"** → **"Web Service"**
   - **Connect Repository**: Select your GitHub repo
   - **Branch**: `main`
   - **Root Directory**: Leave EMPTY (or `.`)
   - **Environment**: **Docker**
   - **Region**: **Singapore** (closest to India)
   - **Instance Type**: **Free** (or paid if you prefer)

3. **Configure Build Settings**:
   ```
   Build Command: (leave empty - Docker handles it)
   Start Command: (leave empty - Docker handles it)
   Dockerfile Path: ./Dockerfile
   Docker Context: .
   ```

4. **Add Environment Variables** (CRITICAL):
   ```
   DB_URL = jdbc:mysql://<RAILWAY_HOST>:<RAILWAY_PORT>/<DB_NAME>?useSSL=true&serverTimezone=Asia/Kolkata
   DB_USER = <RAILWAY_MYSQL_USER>
   DB_PASS = <RAILWAY_MYSQL_PASSWORD>
   PORT = 10000
   ```

   **Example with Railway values:**
   ```
   DB_URL = jdbc:mysql://containers-us-west-123.railway.app:6543/railway?useSSL=true&serverTimezone=Asia/Kolkata
   DB_USER = root
   DB_PASS = YourRailwayPassword123
   PORT = 10000
   ```

5. **Advanced Settings**:
   - **Auto-Deploy**: Yes
   - **Health Check Path**: `/student-management/api/students`
   - **Docker Command**: (leave empty)

6. **Click "Create Web Service"**

---

### **STEP 2: Wait for Build (5-15 minutes)**

**Monitor Logs** - You should see:
```
✓ Downloading Maven dependencies
✓ Compiling Java source files
✓ Building WAR file: student-management.war
✓ Starting Tomcat on port 10000
✓ Database connection pool initialized
✓ Server startup in [X] milliseconds
```

**Success Message**: `Deploy live 🎉`

---

### **STEP 3: Get Your Backend URL**

After successful deployment, Render provides:
```
https://student-management-backend-XXXXX.onrender.com
```

Your API will be available at:
```
https://student-management-backend-XXXXX.onrender.com/student-management/api
```

---

### **STEP 4: Update Frontend on Vercel**

1. Go to **Vercel Dashboard** → Your Project → **Settings** → **Environment Variables**

2. Add/Update:
   ```
   Key: REACT_APP_API_URL
   Value: https://student-management-backend-XXXXX.onrender.com/student-management/api
   ```

3. Apply to: **Production**, **Preview**, **Development**

4. **Redeploy** your frontend

---

### **STEP 5: Test Your Application**

1. Open your Vercel frontend URL
2. Try to login (admin/admin123)
3. View students list
4. Add a new student
5. Check attendance and marks

---

## 🔧 TROUBLESHOOTING

### **Issue 1: "Port scan timeout" or "Failed to bind to port"**
**Solution**: 
- Ensure `PORT=10000` is set in Render environment variables
- Check Dockerfile has dynamic PORT configuration
- Redeploy

### **Issue 2: "Database connection failed"**
**Solution**:
- Verify Railway MySQL is running
- Check DB_URL format is correct
- Ensure Railway allows external connections
- Test connection: `mysql -h <HOST> -P <PORT> -u <USER> -p`

### **Issue 3: "CORS error" in frontend**
**Solution**:
- CORS filter already configured to accept all origins
- Check browser console for actual error
- Verify API URL is correct in Vercel

### **Issue 4: "404 Not Found" for API endpoints**
**Solution**:
- Ensure URL includes `/student-management/api`
- Example: `https://your-app.onrender.com/student-management/api/students`
- NOT: `https://your-app.onrender.com/api/students`

### **Issue 5: Free tier sleeps after 15 minutes**
**Solution**:
- First request takes 30-60 seconds (cold start)
- Upgrade to paid tier for always-on service
- Or use a ping service to keep it awake

---

## 📊 RENDER FREE TIER LIMITS

- ✅ **Free hours**: 750 hours/month
- ✅ **Memory**: 512 MB
- ✅ **Builds**: Unlimited
- ⚠️ **Auto-sleep**: After 15 mins inactivity
- ⚠️ **Build time**: Up to 15 minutes
- ⚠️ **Cold start**: 30-60 seconds

---

## 🔐 SECURITY BEST PRACTICES

1. **Never commit** `.env` file to Git ✅ (Already in .gitignore)
2. **Use strong passwords** for production database
3. **Enable SSL** for database connections (useSSL=true)
4. **Keep dependencies updated** (check for CVEs)
5. **Use Railway private networking** if possible

---

## 📝 ENVIRONMENT VARIABLES REFERENCE

### **Required for Render:**
| Variable | Description | Example |
|----------|-------------|---------|
| DB_URL | JDBC connection string | `jdbc:mysql://host:port/db?useSSL=true` |
| DB_USER | Database username | `root` |
| DB_PASS | Database password | `YourPassword123` |
| PORT | Application port | `10000` (Render default) |

### **Required for Vercel (Frontend):**
| Variable | Description | Example |
|----------|-------------|---------|
| REACT_APP_API_URL | Backend API URL | `https://your-app.onrender.com/student-management/api` |

---

## 🎯 FINAL CHECKLIST

- [ ] Backend deployed on Render
- [ ] Environment variables set correctly
- [ ] Build completed successfully
- [ ] Health check passing
- [ ] Frontend updated with backend URL
- [ ] Frontend redeployed on Vercel
- [ ] Can login to application
- [ ] Can view/add/edit students
- [ ] No CORS errors
- [ ] No database connection errors

---

## 🆘 NEED HELP?

**Check Render Logs**:
- Dashboard → Your Service → Logs tab
- Look for ERROR or Exception messages
- Check database connection logs

**Common Log Messages**:
- ✅ "Database connection pool initialized successfully"
- ✅ "Server startup in [X] milliseconds"
- ❌ "Failed to get database connection"
- ❌ "Communications link failure"

---

## 🌐 FINAL URLs

**Frontend**: `https://your-project.vercel.app`  
**Backend**: `https://your-app.onrender.com/student-management/api`  
**Database**: `Railway MySQL (private connection)`

**API Endpoints**:
- GET `/student-management/api/students` - List all students
- POST `/student-management/api/students` - Add student
- GET `/student-management/api/students/{id}` - Get student
- PUT `/student-management/api/students/{id}` - Update student
- DELETE `/student-management/api/students/{id}` - Delete student

---

**✅ DEPLOYMENT COMPLETE!** 🎉
