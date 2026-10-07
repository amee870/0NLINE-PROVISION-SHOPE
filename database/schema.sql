-- ============================================================
-- Provision Shop Ordering System - Database Schema
-- Matches the ER design in the PSA Report (Section 7.1)
-- ============================================================
CREATE DATABASE IF NOT EXISTS provision_shop;
USE provision_shop;
-- ------------------------------------------------------------
-- Users (Staff / Admin) — role-based authentication
-- ------------------------------------------------------------
CREATE TABLE users (
user_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
username VARCHAR(50) NOT NULL UNIQUE,
password_hash VARCHAR(255) NOT NULL,
role ENUM('staff', 'admin') NOT NULL DEFAULT 'staff',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
-- ------------------------------------------------------------
-- Products — the catalog
-- ------------------------------------------------------------
CREATE TABLE products (
product_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(150) NOT NULL,
category VARCHAR(80) NOT NULL,
price DECIMAL(10,2) NOT NULL,
stock_qty INT NOT NULL DEFAULT 0,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
-- ------------------------------------------------------------
-- Orders — one per customer checkout
-- ------------------------------------------------------------
CREATE TABLE orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
Create file: auth.php
Location: inside the includes folder
Create file: login.php
Location: inside the admin folder
reference_no VARCHAR(20) NOT NULL UNIQUE,
customer_name VARCHAR(100) NOT NULL,
customer_contact VARCHAR(50) NOT NULL,
order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status ENUM('Pending', 'Prepared', 'Collected') NOT
NULL DEFAULT 'Pending',
total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB;
-- ------------------------------------------------------------
-- Order Items — junction table (Orders <-> Products)
-- ------------------------------------------------------------
CREATE TABLE order_items (
orderitem_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE
CASCADE,
FOREIGN KEY (product_id) REFERENCES products(product_id) ON
DELETE RESTRICT
) ENGINE=InnoDB;
-- ------------------------------------------------------------
-- Seed data: one admin account (username: admin / password:
admin123)
-- Password hash below = password_hash('admin123', PASSWORD_DEFAULT)
-- ------------------------------------------------------------
INSERT INTO users (full_name, username, password_hash, role)
VALUES ('System Administrator', 'admin',
'$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
'admin');
-- NOTE: this hash corresponds to the password "password" — change
it after first login,
-- or generate your own with: php -r "echo
password_hash('YOURPASSWORD', PASSWORD_DEFAULT);"
-- ------------------------------------------------------------
-- Seed data: sample products
-- ------------------------------------------------------------
INSERT INTO products (name, category, price, stock_qty) VALUES
('Rice (5kg)', 'Grains', 12.50, 40),
('Cooking Oil (1L)', 'Cooking', 4.75, 60),
('Sugar (1kg)', 'Baking', 1.80, 100),
('Milk Powder (400g)', 'Dairy', 6.20, 35),
('Bread Loaf', 'Bakery', 1.50, 25),
('Canned Tomatoes', 'Canned Goods',0.95, 80);