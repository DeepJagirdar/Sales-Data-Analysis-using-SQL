create database Salesdata;
use Salesdata;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE,
    customer_id INT,
    product_id INT,
    quantity INT,
    total DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(100)
);

# Data Insertion:

INSERT INTO regions (region_name) VALUES
('North America'),
('Europe'),
('Asia'),
('South America');

INSERT INTO customers (customer_name, email, gender, age, region_id) VALUES
('John Doe', 'john@example.com', 'Male', 30, 1),
('Jane Smith', 'jane@example.com', 'Female', 25, 2),
('David Brown', 'david@example.com', 'Male', 40, 3);

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Headphones', 'Accessories', 150.00);

INSERT INTO sales (sale_date, customer_id, product_id, quantity, total) VALUES
('2023-07-10', 1, 1, 1, 1200.00),
('2023-07-11', 2, 2, 2, 1600.00),
('2023-07-12', 3, 3, 1, 150.00);

select * from customers;
select * from sales;
select * from products;
select * from regions;

# Queries:

# Total Sales by Region:
SELECT r.region_name, SUM(s.total) AS total_sales
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN regions r ON c.region_id = r.region_id
GROUP BY r.region_name;

# Top 5 Best-Selling Products:
SELECT p.product_name, SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 5;

# Monthly Sales Trend:
SELECT DATE_FORMAT(s.sale_date, '%Y-%m') AS month, SUM(s.total) AS total_sales
FROM sales s
GROUP BY month
ORDER BY month;

# Customer Demographics Breakdown:
SELECT gender, COUNT(*) AS customer_count
FROM customers
GROUP BY gender;

# Revenue by product category:
SELECT p.category, SUM(s.total) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category;







