# Student Login & Marks/Attendance System - Implementation Guide

## ✅ COMPLETED STEPS

### 1. Database Schema
- ✅ Updated `students` table with `password` and `roll_number` fields
- ✅ Created `subjects` table with 10 sample subjects
- ✅ Created `marks` table with foreign keys to students and subjects
- ✅ Created `attendance` table with unique constraint
- ✅ Added 8 courses to courses table

### 2. Backend Models
- ✅ Created `Subject.java` model
- ✅ Created `Marks.java` model with percentage calculation
- ✅ Created `Attendance.java` model
- ✅ Updated `Student.java` with password and rollNumber fields

### 3. Backend DAOs
- ✅ Created `SubjectDAO.java` - Get all subjects, by course, by ID
- ✅ Created `MarksDAO.java` - Add, update, delete, get marks for students
- ✅ Created `AttendanceDAO.java` - Mark attendance, get records, calculate percentage

## 🔄 NEXT STEPS TO COMPLETE

### Step 1: Update Database Schema
Run these SQL commands in MySQL:

```bash
cd "/Users/shriyansh/Desktop/Student Management System/database"
/usr/local/mysql/bin/mysql -u root -pShriyansh@123 student_management < schema.sql
```

### Step 2: Update StudentDAO for Authentication
Add these methods to `StudentDAO.java`:

```java
// Student login
public Student studentLogin(String emailOrRoll, String password) throws SQLException {
    String query = "SELECT * FROM students WHERE (email = ? OR roll_number = ?) AND password = ?";
    // Implementation similar to existing getStudentById
}

// Student registration
public int registerStudent(Student student) throws SQLException {
    String query = "INSERT INTO students (name, email, phone, course, gender, dob, city, password, roll_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    // Implementation similar to existing addStudent
}
```

### Step 3: Create Backend Servlets
Need to create 3 new servlets:

1. **StudentAuthServlet.java** - Handles `/api/student/login` and `/api/student/register`
2. **MarksServlet.java** - Handles `/api/marks` (GET all, GET by student, POST add, PUT update, DELETE)
3. **AttendanceServlet.java** - Handles `/api/attendance` (GET, POST, DELETE)
4. **SubjectServlet.java** - Handles `/api/subjects` (GET all, GET by course)

### Step 4: Update web.xml
Add servlet mappings for new servlets.

### Step 5: Install Frontend Dependencies
```bash
cd frontend
npm install recharts react-router-dom@latest
```

### Step 6: Create Frontend Components

#### Authentication Pages:
- `StudentLogin.js` - Student login form
- `StudentRegister.js` - Student registration form

#### Student Dashboard:
- `StudentDashboard.js` - Main dashboard with charts
- `MarksView.js` - Detailed marks view with filters
- `AttendanceView.js` - Attendance calendar/list view

#### Admin Pages:
- `AdminMarks.js` - Add/edit marks for students
- `AdminAttendance.js` - Mark daily attendance

### Step 7: Update Frontend Routing
Add routes in `App.js`:
```javascript
<Route path="/student/login" element={<StudentLogin />} />
<Route path="/student/register" element={<StudentRegister />} />
<Route path="/student/dashboard" element={<StudentDashboard />} />
<Route path="/admin/marks" element={<AdminMarks />} />
<Route path="/admin/attendance" element={<AdminAttendance />} />
```

### Step 8: Create API Client Functions
Add to `frontend/src/utils/api.js`:
```javascript
// Student authentication
export const studentAuthAPI = {
  login: (credentials) => api.post('/student/login', credentials),
  register: (studentData) => api.post('/student/register', studentData),
};

// Marks API
export const marksAPI = {
  getMyMarks: () => api.get('/marks/my'),
  getAllMarks: () => api.get('/marks'),
  addMarks: (data) => api.post('/marks', data),
  updateMarks: (id, data) => api.put(`/marks/${id}`, data),
  deleteMarks: (id) => api.delete(`/marks/${id}`),
};

// Attendance API
export const attendanceAPI = {
  getMyAttendance: () => api.get('/attendance/my'),
  getAllAttendance: () => api.get('/attendance'),
  markAttendance: (data) => api.post('/attendance', data),
  getPercentage: () => api.get('/attendance/percentage'),
};

// Subjects API
export const subjectAPI = {
  getAllSubjects: () => api.get('/subjects'),
  getSubjectsByCourse: (course) => api.get(`/subjects/course/${course}`),
};
```

## 📊 FEATURES OVERVIEW

### Student Portal Features:
1. **Login/Register** - Secure authentication with roll number or email
2. **Dashboard** - Overview cards showing:
   - Total subjects
   - Average marks
   - Overall attendance percentage
   - Recent exams
3. **Marks View** - Bar chart and table showing:
   - Marks by subject
   - Exam-wise performance
   - Percentage and grade
4. **Attendance View** - Pie chart and calendar showing:
   - Attendance by subject
   - Monthly attendance trends
   - Present/Absent/Late days

### Admin Portal Features:
1. **Marks Management** - Add/edit marks with:
   - Select student and subject
   - Enter marks obtained and total marks
   - Choose exam type (Regular, Mid-term, Final)
   - Set exam date
2. **Attendance Management** - Mark attendance with:
   - Select date and subject
   - Bulk mark all students
   - Individual status (Present/Absent/Late)
   - View attendance reports

## 🚀 QUICK START COMMANDS

### To update database:
```bash
cd "/Users/shriyansh/Desktop/Student Management System"
/usr/local/mysql/bin/mysql -u root -pShriyansh@123 student_management < database/schema.sql
```

### To rebuild backend:
```bash
cd backend
mvn clean compile
```

### To install frontend dependencies:
```bash
cd frontend
npm install recharts
```

### To run all servers:
```bash
# Terminal 1 - MySQL (already running)
# Terminal 2 - Backend
cd backend && mvn jetty:run

# Terminal 3 - Frontend
cd frontend && npm start
```

## 📝 SAMPLE DATA TO INSERT

After schema update, you can add sample data:

```sql
-- Add passwords to existing students
UPDATE students SET 
    password = 'student123',
    roll_number = CONCAT('STU', LPAD(id, 4, '0'))
WHERE password IS NULL;

-- Add sample marks
INSERT INTO marks (student_id, subject_id, marks_obtained, total_marks, exam_type, exam_date) VALUES
(1, 1, 85.5, 100, 'Mid-term', '2025-10-15'),
(1, 2, 90.0, 100, 'Mid-term', '2025-10-16'),
(1, 3, 78.5, 100, 'Mid-term', '2025-10-17');

-- Add sample attendance
INSERT INTO attendance (student_id, subject_id, attendance_date, status) VALUES
(1, 1, '2025-10-20', 'Present'),
(1, 1, '2025-10-21', 'Present'),
(1, 1, '2025-10-22', 'Absent');
```

## ⚠️ IMPORTANT NOTES

1. **Security**: In production, passwords should be hashed (use BCrypt)
2. **Validation**: Add proper validation on both frontend and backend
3. **Authorization**: Ensure students can only view their own data
4. **Error Handling**: Add comprehensive error handling
5. **Testing**: Test all endpoints before deploying

## 📚 RESOURCES

- Recharts Documentation: https://recharts.org/
- React Router: https://reactrouter.com/
- Java Servlets: https://docs.oracle.com/javaee/7/api/javax/servlet/package-summary.html

---

Would you like me to:
1. Create the complete servlet implementations?
2. Create the complete React component implementations?
3. Both?

Let me know and I'll continue with the implementation!
