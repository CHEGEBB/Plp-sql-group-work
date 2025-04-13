# Bookstore Database Project

## Overview
This project implements a comprehensive MySQL database for a bookstore management system. It contains the complete database schema, sample data, and example queries to demonstrate the functionality.

## Project Structure
- `bookstore.sql` - Main SQL file containing database schema, tables, relationships, user roles, and sample data
- `bookstore_queries.sql` - Collection of sample queries demonstrating various database operations
- `README.md` - This documentation file

## Entity Relationship Diagram (ERD)
The following diagram illustrates the relationships between tables in our bookstore database:

![erd](https://github.com/user-attachments/assets/9e00714a-acca-4bec-bdac-ace0e14b6aec)


## Database Schema

The database consists of the following tables:

### Book-Related Tables
1. **book** - Stores information about books (title, ISBN, price, etc.)
2. **author** - Contains author information
3. **book_author** - Junction table for the many-to-many relationship between books and authors
4. **book_language** - List of languages books are available in
5. **publisher** - Information about book publishers

### Customer-Related Tables
6. **customer** - Customer information (name, contact details)
7. **address** - Addresses for shipping and billing
8. **customer_address** - Junction table linking customers to their addresses
9. **address_status** - Statuses for addresses (current, previous, etc.)
10. **country** - List of countries for addresses

### Order-Related Tables
11. **cust_order** - Order information (customer, date, total, etc.)
12. **order_line** - Individual items in each order
13. **order_status** - Possible statuses for orders
14. **order_history** - Timeline of status changes for orders
15. **shipping_method** - Available shipping methods

## User Roles
The database implements three user roles with different permission levels:
- **bookstore_admin**: Full access to all database functions
- **bookstore_manager**: Can view, add, and modify data but cannot delete records
- **bookstore_employee**: Limited access - can view all data but only update order statuses

## Sample Data
The database includes sample data for all tables, including:
- Books, authors, and publishers
- Customers and addresses
- Orders with order lines and statuses
- Reference data like countries, languages, and shipping methods

## How to Use

### Setting Up the Database
1. Install MySQL Server and MySQL Workbench (or use any MySQL-compatible client)
2. Open a MySQL connection
3. Run the `bookstore.sql` script to create the database schema and load sample data
4. Run the `bookstore_queries.sql` script to test various queries

### Running Sample Queries
The `bookstore_queries.sql` file contains 15 example queries demonstrating:
- Basic data retrieval
- Table joins
- Aggregation functions
- Data filtering and sorting
- Complex queries combining multiple SQL features

## Project Requirements
This project was created to fulfill the requirements for the Database Design & Programming with SQL course project. It demonstrates:
- Database design and normalization
- Implementation of relationships (one-to-many, many-to-many)
- User roles and security
- SQL queries for data retrieval and analysis

## Contributors
- Brian Chege - Github - https://github.com/CHEGEB
- Verra Achieng -Github - https://github.com/CHEGEB

## Submission Date
April 13, 2025
