# Student Management System

A full-stack web application for managing students with React frontend and Java Servlet backend.

## Project Structure

```
Student management system/
├── frontend/                 # React application
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   └── utils/
│   ├── package.json
│   └── tailwind.config.js
├── backend/                  # Java Servlet application
│   ├── src/
│   │   └── main/
│   │       ├── java/
│   │       └── webapp/
│   ├── pom.xml
│   └── web.xml
├── database/                 # Database scripts
│   └── schema.sql
└── README.md
```

## Features

- **Frontend**: React with TailwindCSS
- **Backend**: Java Servlets with JDBC
- **Database**: MySQL
- **Authentication**: Admin login
- **CRUD Operations**: Create, Read, Update, Delete students
- **Form Validation**: Client-side validation
- **Responsive Design**: Modern UI with TailwindCSS

## Setup Instructions

### Database Setup
1. Create MySQL database: `student_management`
2. Run the SQL script in `database/schema.sql`

### Backend Setup
1. Navigate to `backend/` directory
2. Run `mvn clean install`
3. Deploy to Tomcat server
4. Backend will run on `http://localhost:8080/student-management`

### Frontend Setup
1. Navigate to `frontend/` directory
2. Run `npm install`
3. Run `npm start`
4. Frontend will run on `http://localhost:3000`

## API Endpoints

- `POST /students` - Add new student
- `GET /students` - Get all students
- `GET /students/{id}` - Get student by ID
- `PUT /students/{id}` - Update student
- `DELETE /students/{id}` - Delete student

## Default Admin Credentials
- Username: admin
- Password: admin123
