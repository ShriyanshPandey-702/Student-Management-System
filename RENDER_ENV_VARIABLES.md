# ⚠️ RENDER ENVIRONMENT VARIABLES (COPY-PASTE READY)

## 🔐 Get Your Railway MySQL Credentials First:
1. Go to Railway Dashboard
2. Click on MySQL service
3. Go to "Variables" tab
4. Copy these values: MYSQLHOST, MYSQLPORT, MYSQLDATABASE, MYSQLUSER, MYSQLPASSWORD

---

## 📋 COPY THESE TO RENDER (Replace values in <brackets>)

### **Variable 1: DB_URL**
```
DB_URL
```
**Value:**
```
jdbc:mysql://<MYSQLHOST>:<MYSQLPORT>/<MYSQLDATABASE>?useSSL=true&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true
```

**Example:**
```
jdbc:mysql://containers-us-west-123.railway.app:6543/railway?useSSL=true&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true
```

---

### **Variable 2: DB_USER**
```
DB_USER
```
**Value:**
```
<MYSQLUSER>
```

**Example:**
```
root
```

---

### **Variable 3: DB_PASS**
```
DB_PASS
```
**Value:**
```
<MYSQLPASSWORD>
```

**Example:**
```
YourRailwayPassword123
```

---

### **Variable 4: PORT (IMPORTANT)**
```
PORT
```
**Value:**
```
10000
```

**⚠️ DO NOT USE 3306 - That's the MySQL port, not your app port!**

---

## ✅ VERIFICATION CHECKLIST

After adding variables:
- [ ] All 4 variables added (DB_URL, DB_USER, DB_PASS, PORT)
- [ ] No typos in variable names
- [ ] DB_URL starts with `jdbc:mysql://`
- [ ] DB_URL ends with `?useSSL=true&serverTimezone=Asia/Kolkata`
- [ ] PORT is set to `10000` (not 3306, not 8080)
- [ ] No extra spaces in values
- [ ] Variables applied to "Production" environment

---

## 🚀 After Setting Variables:

1. Click "Save Changes"
2. Go to "Manual Deploy" → "Deploy latest commit"
3. Wait 5-10 minutes
4. Check logs for:
   - ✅ "Database connection pool initialized successfully"
   - ✅ "Server startup in [X] milliseconds"

---

## 🔗 VERCEL FRONTEND CONFIGURATION

After backend is deployed, update Vercel:

**Variable Name:**
```
REACT_APP_API_URL
```

**Value Format:**
```
https://<your-render-url>.onrender.com/student-management/api
```

**Example:**
```
https://student-management-backend-abc123.onrender.com/student-management/api
```

**⚠️ Important:**
- Include `/student-management/api` at the end
- Use `https://` (not http)
- No trailing slash

---

## ⚡ QUICK REFERENCE

| Platform | Variable | Example Value |
|----------|----------|---------------|
| **Render Backend** | DB_URL | `jdbc:mysql://railway-host:6543/railway?useSSL=true...` |
| **Render Backend** | DB_USER | `root` |
| **Render Backend** | DB_PASS | `YourPassword123` |
| **Render Backend** | PORT | `10000` |
| **Vercel Frontend** | REACT_APP_API_URL | `https://your-app.onrender.com/student-management/api` |

---

## 🆘 COMMON MISTAKES TO AVOID

❌ **WRONG:**
```
PORT = 3306                    # This is MySQL port!
PORT = 8080                    # Won't work on Render
DB_URL = jdbc:mysql://localhost...  # Won't work in cloud
REACT_APP_API_URL = .../api    # Missing /student-management
```

✅ **CORRECT:**
```
PORT = 10000
DB_URL = jdbc:mysql://railway-host:port/db?useSSL=true...
REACT_APP_API_URL = https://your-app.onrender.com/student-management/api
```

---

**🎯 READY TO DEPLOY!**
