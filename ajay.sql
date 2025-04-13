-- 11.	cust_order: A list of orders placed by customers.
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);


-- 12.	order_line: A list of books that are part of each order.
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);


-- 13.	shipping_method: A list of possible shipping methods for an order.
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL
);


-- 14.	order_history: A record of the history of an order (e.g., ordered, cancelled, delivered).
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    changed_on DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);


-- 15.	order_status: A list of possible statuses for an order (e.g., pending, shipped, delivered).
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

--	Set up user groups and roles to control access to the database
-- Create a Admin for bookstore management
CREATE USER 'bookstore_staff'@'localhost' IDENTIFIED BY 'adminPass12345';

-- Granting of privileges to the admin user
GRANT SELECT, INSERT, UPDATE, DELETE ON BookstoreDB.* TO 'bookstore_staff'@'localhost';

--	Test the database by running queries to retrieve and analyze the data
-- a. Finding all books by a specific author
SELECT b.title 
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
WHERE a.last_name = 'Rowling';

-- b. List all orders and their current statuses
SELECT co.order_id, co.order_date, os.status_name
FROM cust_order co
JOIN order_status os ON co.status_id = os.status_id;

-- c. Count of books per language
SELECT bl.language_name, COUNT(b.book_id) AS book_count
FROM book_language bl
JOIN book b ON bl.language_id = b.language_id
GROUP BY bl.language_name;

-- d. Total sales per book
SELECT b.title, SUM(ol.quantity * ol.price) AS total_sales
FROM book b
JOIN order_line ol ON b.book_id = ol.book_id
GROUP BY b.title;

-- e. List of customers with their addresses
SELECT c.first_name, c.last_name, a.street, a.city, a.zip_code, a.country_id
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
WHERE ca.status_id = 1; -- Assuming 1 is the status for current addresses

