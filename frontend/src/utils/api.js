import axios from 'axios';

// Base URL for API calls
const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080/student-management/api';

// Create axios instance with default configuration
const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Add request interceptor to include auth token
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('authToken');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Add response interceptor to handle errors
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Handle unauthorized access
      localStorage.removeItem('authToken');
      localStorage.removeItem('userData');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

// API functions for student management
export const studentAPI = {
  // Get all students
  getAllStudents: () => api.get('/students'),
  
  // Get student by ID
  getStudentById: (id) => api.get(`/students/${id}`),
  
  // Add new student
  addStudent: (studentData) => api.post('/students', studentData),
  
  // Update student
  updateStudent: (id, studentData) => api.put(`/students/${id}`, studentData),
  
  // Delete student
  deleteStudent: (id) => api.delete(`/students/${id}`),
};

// API functions for dashboard statistics
export const dashboardAPI = {
  // Get dashboard statistics
  getStats: () => api.get('/dashboard/stats'),
};

// Student authentication API
export const studentAuthAPI = {
  login: (credentials) => api.post('/student/auth/login', credentials),
  register: (studentData) => api.post('/student/auth/register', studentData),
  checkRegistration: (emailOrRoll) => api.get('/student/auth/check-registration', { 
    params: { emailOrRoll } 
  }),
};

// Marks API
export const marksAPI = {
  getByStudentId: (studentId) => api.get(`/marks/student/${studentId}`),
  getAllMarks: () => api.get('/marks'),
  addMarks: (data) => api.post('/marks', data),
  updateMarks: (id, data) => api.put(`/marks/${id}`, data),
  deleteMarks: (id) => api.delete(`/marks/${id}`),
};

// Attendance API
export const attendanceAPI = {
  getByStudentId: (studentId) => api.get(`/attendance/student/${studentId}`),
  getPercentage: (studentId) => api.get(`/attendance/student/${studentId}/percentage`),
  getAllAttendance: () => api.get('/attendance'),
  markAttendance: (data) => api.post('/attendance', data),
  deleteAttendance: (id) => api.delete(`/attendance/${id}`),
};

// Subjects API
export const subjectAPI = {
  getAllSubjects: () => api.get('/subjects'),
  getSubjectsByCourse: (course) => api.get(`/subjects/course/${course}`),
};

export default api;
