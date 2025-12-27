package com.studentmanagement.config;

/**
 * Database configuration class for managing database connection properties
 * This class contains all database-related configuration constants
 */
public class DatabaseConfig {
    // Database connection properties
    public static final String DB_URL = "jdbc:mysql://localhost:3306/student_management";
    public static final String DB_USERNAME = "root";
    public static final String DB_PASSWORD = "Shriyansh@123"; // Change this to your MySQL password
    
    // Connection pool properties
    public static final int MAX_POOL_SIZE = 20;
    public static final int MIN_POOL_SIZE = 5;
    public static final long CONNECTION_TIMEOUT = 30000; // 30 seconds
    public static final long IDLE_TIMEOUT = 600000; // 10 minutes
    public static final long MAX_LIFETIME = 1800000; // 30 minutes
    
    // Database driver
    public static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // Private constructor to prevent instantiation
    private DatabaseConfig() {
        throw new UnsupportedOperationException("Utility class cannot be instantiated");
    }
}
