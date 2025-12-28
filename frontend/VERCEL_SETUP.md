# 🚀 VERCEL DEPLOYMENT CONFIGURATION

## ✅ Environment Variables for Vercel

### **Add this in Vercel Dashboard:**

1. Go to: https://vercel.com/dashboard
2. Select your project
3. **Settings** → **Environment Variables**
4. Click **Add New**

---

## 📋 Copy-Paste This:

### **Variable Name:**
```
REACT_APP_API_URL
```

### **Value:**
```
https://student-management-system-bslx.onrender.com/student-management/api
```

### **Environments:**
- ✅ Production
- ✅ Preview  
- ✅ Development

---

## 🔄 After Adding Variable:

1. Click **Save**
2. Go to **Deployments** tab
3. Click **⋯** (three dots) on latest deployment
4. Select **Redeploy**
5. Wait 2-3 minutes

---

## ✅ Verification:

After redeploy, open browser console and check:
- You should see: `🔗 API Base URL: https://student-management-system-bslx.onrender.com/student-management/api`
- Try logging in
- Check Network tab for API calls

---

## 🆘 Troubleshooting:

### **Issue: "Network Error"**
✅ Wait 30-60 seconds (Render cold start)  
✅ Check backend is running: `curl https://student-management-system-bslx.onrender.com/student-management/api/students`

### **Issue: "CORS Error"**
✅ Backend CORS is already configured  
✅ Check URL doesn't have typos  
✅ Ensure using `https://` not `http://`

### **Issue: Environment variable not working**
✅ Variable name must be exact: `REACT_APP_API_URL`  
✅ Must start with `REACT_APP_`  
✅ Rebuild after adding variable

---

## 🎯 Final URL Structure:

**Frontend (Vercel):**
```
https://your-project.vercel.app
```

**Backend (Render):**
```
https://student-management-system-bslx.onrender.com/student-management/api
```

**Example API Call:**
```
https://student-management-system-bslx.onrender.com/student-management/api/students
```

---

**✅ READY TO DEPLOY!**
