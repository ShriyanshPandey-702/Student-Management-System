# Student Login & Marks/Attendance System Implementation Plan

## Overview
This implementation adds student login/registration with marks and attendance tracking features.

## Database Changes (COMPLETED)
✅ Updated schema.sql with:
- Added `password` and `roll_number` to students table
- Created `subjects` table
- Created `marks` table with foreign keys
- Created `attendance` table with foreign keys
- Added sample data for 8 courses and 10 subjects

## Backend Implementation

### Model Classes (COMPLETED)
✅ Subject.java - Model for subjects
✅ Marks.java - Model for marks with percentage calculation
✅ Attendance.java - Model for attendance
✅ Updated Student.java with password and rollNumber fields

### DAO Classes (IN PROGRESS)
✅ SubjectDAO.java - CRUD for subjects
⏳ MarksDAO.java - CRUD for marks
⏳ AttendanceDAO.java - CRUD for attendance  
⏳ Update StudentDAO.java for login/register

### Servlet/API Endpoints (PENDING)
⏳ StudentAuthServlet.java - Student login/register endpoints
⏳ MarksServlet.java - Admin adds marks, student views marks
⏳ AttendanceServlet.java - Admin marks attendance, student views
⏳ SubjectServlet.java - Get subjects by course

## Frontend Implementation (PENDING)

### New Components
⏳ StudentLogin.js - Student login page
⏳ StudentRegister.js - Student registration page
⏳ StudentDashboard.js - Student dashboard with charts
⏳ MarksChart.js - Chart component for marks visualization
⏳ AttendanceChart.js - Chart component for attendance
⏳ AdminMarks.js - Admin page to add/edit marks
⏳ AdminAttendance.js - Admin page to mark attendance

### Dependencies to Install
- recharts (for charts and graphs)
- react-chartjs-2 & chart.js (alternative charting library)

### Routing Updates
⏳ Add routes for student login, register, dashboard
⏳ Add routes for admin marks and attendance management

## Features

### Student Features
1. Login with roll number/email and password
2. View personal dashboard with:
   - Overall marks in all subjects (bar chart)
   - Attendance percentage per subject (pie chart)
   - Recent marks list
   - Attendance calendar view
3. Filter marks by exam type (Regular, Mid-term, Final)

### Admin Features
1. Add/edit marks for students by subject
2. Mark daily attendance for students
3. View attendance reports
4. Bulk attendance marking

## Next Steps
1. Create MarksDAO and AttendanceDAO
2. Update StudentDAO for authentication
3. Create servlets for all APIs
4. Update database with new schema
5. Install frontend chart libraries
6. Create React components
7. Update routing
8. Test end-to-end functionality
