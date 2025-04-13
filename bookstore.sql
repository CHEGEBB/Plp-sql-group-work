-- 1. Create the database
CREATE DATABASE IF NOT EXISTS bookstore;
USE bookstore;

-- 2. Create tables for the bookstore database

-- Country table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- Address table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_number VARCHAR(10),
    street_name VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Address status table
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(30) NOT NULL
);

-- Customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Customer address junction table
CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Shipping method table
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);

-- Order status table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Customer order table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_address_id INT NOT NULL,
    shipping_method_id INT NOT NULL,
    order_total DECIMAL(10, 2) NOT NULL,
    status_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Order history table
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Publisher table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(200) NOT NULL,
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20)
);

-- Book language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

-- Author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT
);

-- Book table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_date DATE,
    price DECIMAL(10, 2) NOT NULL,
    publisher_id INT NOT NULL,
    language_id INT NOT NULL,
    page_count INT,
    description TEXT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- Book-Author junction table (many-to-many)
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Order line table (books in an order)
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 3. Create user roles and permissions
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'admin_password';
CREATE USER 'bookstore_manager'@'localhost' IDENTIFIED BY 'manager_password';
CREATE USER 'bookstore_employee'@'localhost' IDENTIFIED BY 'employee_password';

-- Grant all privileges to admin
GRANT ALL PRIVILEGES ON bookstore.* TO 'bookstore_admin'@'localhost';

-- Grant select, insert, update to manager (no delete)
GRANT SELECT, INSERT, UPDATE ON bookstore.* TO 'bookstore_manager'@'localhost';

-- Grant select and limited update to employee
GRANT SELECT ON bookstore.* TO 'bookstore_employee'@'localhost';
GRANT UPDATE ON bookstore.cust_order TO 'bookstore_employee'@'localhost';
GRANT UPDATE ON bookstore.order_history TO 'bookstore_employee'@'localhost';

FLUSH PRIVILEGES;

-- 4. Insert sample data

-- Insert countries
INSERT INTO country (country_name) VALUES 
('United States'), ('Canada'), ('United Kingdom'), ('Australia'), ('Germany');

-- Insert address statuses
INSERT INTO address_status (status_name) VALUES 
('Current'), ('Previous'), ('Shipping'), ('Billing');

-- Insert shipping methods
INSERT INTO shipping_method (method_name, cost) VALUES 
('Standard', 5.99), ('Express', 12.99), ('Overnight', 19.99);

-- Insert order statuses
INSERT INTO order_status (status_name) VALUES 
('Pending'), ('Processing'), ('Shipped'), ('Delivered'), ('Cancelled');

-- Insert publishers
INSERT INTO publisher (publisher_name, contact_email, contact_phone) VALUES 
('Penguin Random House', 'contact@penguinrandomhouse.com', '212-555-1000'),
('HarperCollins', 'info@harpercollins.com', '212-555-2000'),
('Simon & Schuster', 'sales@simonschuster.com', '212-555-3000');

-- Insert book languages
INSERT INTO book_language (language_name) VALUES 
('English'), ('Spanish'), ('French'), ('German'), ('Chinese');

-- Insert authors
INSERT INTO author (first_name, last_name, biography) VALUES 
('J.K.', 'Rowling', 'British author best known for the Harry Potter series.'),
('Stephen', 'King', 'American author of horror, supernatural fiction, suspense, and fantasy novels.'),
('Agatha', 'Christie', 'English writer known for her 66 detective novels and 14 short story collections.');

