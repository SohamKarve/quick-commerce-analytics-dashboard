DROP DATABASE IF EXISTS e_commerce;
CREATE DATABASE e_commerce;
USE e_commerce;
CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(50) NOT NULL,
	gender VARCHAR(50) NOT NULL,
	age INT NOT NULL,
	city VARCHAR(50) NOT NULL,
	signup_date DATE NOT NULL
);
CREATE TABLE product(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	category VARCHAR(50) NOT NULL,
	price DECIMAL(10,2) NOT NULL
    );
CREATE TABLE orders(
	order_id INT PRIMARY KEY,
    customer_id INT,
	FOREIGN KEY (customer_id) references customer(customer_id),
	order_date DATE NOT NULL,
	total_amount DECIMAL(10,2),
	payment_mode VARCHAR(50)
    );
    
CREATE TABLE order_detail(
	order_detail_id INT PRIMARY KEY,
    order_id INT,
	product_id INT,	
	FOREIGN KEY (order_id) references orders(order_id),
	FOREIGN KEY (product_id) references product(product_id),
	quantity INT,
	subtotal DECIMAL(10,2)
    );
INSERT INTO customer values
	(1, 'John Doe', 'Male', 28, 'New York', '2025-01-15'),
	(2, 'Jane Smith', 'Female', 34, 'Los Angeles', '2025-01-18'),
	(3, 'Michael Brown', 'Male', 45, 'Chicago', '2025-01-20'),
	(4, 'Emily Davis', 'Female', 22, 'Houston', '2025-01-22'),
	(5, 'David Wilson', 'Male', 31, 'Phoenix', '2025-01-25'),
	(6, 'Sarah Martinez', 'Female', 29, 'Philadelphia', '2025-01-28'),
	(7, 'James Anderson', 'Male', 38, 'San Antonio', '2025-02-02'),
	(8, 'Amanda Thomas', 'Female', 26, 'San Diego', '2025-02-05'),
	(9, 'Robert Jackson', 'Male', 50, 'Dallas', '2025-02-10'),
	(10, 'Lisa White', 'Female', 33, 'San Jose', '2025-02-12')
    ;
 INSERT INTO product values  
	(101, 'Wireless Mouse', 'Electronics', 25.99),
	(102, 'Mechanical Keyboard', 'Electronics', 89.99),
	(103, 'Bluetooth Headphones', 'Electronics', 59.50),
	(104, 'Running Shoes', 'Apparel', 120.00),
	(105, 'Cotton T-Shirt', 'Apparel', 19.99),
	(106, 'Denim Jeans', 'Apparel', 49.99),
	(107, 'Coffee Maker', 'Home Appliances', 79.95),
	(108, 'Air Fryer', 'Home Appliances', 119.99),
	(109, 'Blender', 'Home Appliances', 39.99),
	(110, 'Yoga Mat', 'Sports', 25.00)
    ;
INSERT INTO orders VALUES
	(501, 1, '2025-01-20', 51.98, 'Credit Card'),
	(502, 2, '2025-01-22', 89.99, 'PayPal'),
	(503, 3, '2025-01-25', 119.99, 'Debit Card'),
	(504, 4, '2025-01-26', 19.99, 'Credit Card'),
	(505, 5, '2025-02-01', 50.00, 'UPI'),
	(506, 6, '2025-02-03', 179.94, 'Credit Card'),
	(507, 7, '2025-02-06', 45.00, 'PayPal'),
	(508, 8, '2025-02-10', 39.99, 'Debit Card'),
	(509, 9, '2025-02-14', 199.99, 'Credit Card'),
	(510, 10, '2025-02-15', 74.98, 'UPI')
    ;
INSERT INTO order_detail VALUES 
	(1001, 501, 101, 2, 51.98),
	(1002, 502, 102, 1, 89.99),
	(1003, 503, 108, 1, 119.99),
	(1004, 504, 105, 1, 19.99),
	(1005, 505, 110, 2, 50.00),
	(1006, 506, 103, 3, 179.94),
	(1007, 507, 107, 1, 45.00),
	(1008, 508, 109, 1, 39.99),
	(1009, 509, 106, 1, 199.99),
	(1010, 510, 110, 2, 70.00)
    ;
SELECT * FROM customer;
SELECT COUNT(customer_id)
FROM customer;
SELECT COUNT(product_id)
FROM product;
SELECT COUNT(order_id)
FROM orders;
SELECT SUM(total_amount)
FROM orders;
SELECT AVG(total_amount)
FROM orders;
SELECT MAX(total_amount)
FROM orders;
SELECT MIN(total_amount)
FROM orders;
SELECT * FROM customer
WHERE age>30;

SELECT city,
SUM(total_amount) as total_revenue
FROM customer
LEFT JOIN orders
ON customer.customer_id=orders.customer_id
GROUP BY city;

SELECT customer.customer_id, COUNT(order_id)
FROM customer
LEFT JOIN orders
ON customer.customer_id=orders.customer_id
GROUP BY customer_id;

SELECT customer.customer_id, SUM(total_amount)
FROM customer
LEFT JOIN orders
ON customer.customer_id=orders.customer_id
GROUP BY customer_id
ORDER BY SUM(total_amount) DESC
LIMIT 5;
    
SELECT 
    customer.customer_name,
    product.product_name,
    order_detail.quantity,
    order_detail.subtotal,
    orders.payment_mode,
    orders.order_date

FROM customer

LEFT JOIN orders
ON customer.customer_id = orders.customer_id

LEFT JOIN order_detail
ON orders.order_id = order_detail.order_id

LEFT JOIN product
ON order_detail.product_id = product.product_id;

SELECT 
    product.product_name,
    SUM(order_detail.quantity) AS net
FROM order_detail

LEFT JOIN orders
ON orders.order_id = order_detail.order_id

LEFT JOIN product
ON order_detail.product_id = product.product_id
GROUP BY product_name
ORDER BY net DESC
LIMIT 5;

    
