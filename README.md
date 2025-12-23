# Vehicle Rental System – Database Design & SQL Queries

## Project Overview

The **Vehicle Rental System** is a PostgreSQL-based database project designed to manage vehicle rental operations efficiently. It handles user management, vehicle inventory, and booking records while demonstrating the use of relational database concepts and advanced SQL queries.

This project showcases:

- Proper database normalization
- ENUM data types
- Primary & foreign key relationships
- SQL queries using JOIN, EXISTS, WHERE, GROUP BY, and HAVING

---

## Technologies Used

- Database: PostgreSQL
- Language: SQL
- Tools: Beekeeper Studio

---

## Database Name

vehicle_rental_system

---

## Database Schema

### users

Stores system users (Admins and Customers).

- user_id (PK)
- name
- email (unique)
- phone
- role (ENUM: Admin, Customer)
- password

---

### vehicles

Stores rental vehicle information.

- vehicle_id (PK)
- name
- type (ENUM: car, bike, truck)
- model
- registration_number (unique)
- rental_price
- vehicle_availability (ENUM: available, rented, maintenance)

---

### bookings

Stores booking details.

- booking_id (PK)
- user_id (FK → users)
- vehicle_id (FK → vehicles)
- start_date
- end_date
- booking_status (ENUM: pending, confirmed, completed, cancelled)
- total_cost

---

## queries.sql – Explanation

The `queries.sql` file contains all SQL commands and solutions required for this project:

### 1. Database & ENUM Creation

Creates the database and ENUM types for:

- user role
- vehicle type
- vehicle status
- booking status  
  This ensures data integrity and consistency.

### 2. Table Creation

Creates `users`, `vehicles`, and `bookings` tables with:

- Primary keys
- Foreign key relationships
- Proper constraints

### 3. Sample Data Insertion

Inserts demo data into all tables to simulate real-world rental scenarios.

### 4. Business Queries with Solutions

The file includes the following queries:

- **JOIN Query**  
  Retrieve booking details with customer and vehicle names.

- **EXISTS Query**  
  Find vehicles that have never been booked.

- **WHERE Query**  
  List all available vehicles of a specific type (e.g., car).

- **GROUP BY & HAVING Query**  
  Identify vehicles that have more than two bookings.

Each query is commented and written as a solution to a specific requirement.

---

## How to Run

1. Install **PostgreSQL**
2. Install **Beekeeper Studio**
3. Open Beekeeper Studio and connect to your PostgreSQL server
4. Open the `queries.sql` file in Beekeeper Studio
5. Run the SQL file to create database, tables, insert data, and execute queries
