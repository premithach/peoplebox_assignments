create database peoplebox;
use peoplebox;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- insert the values
INSERT INTO Categories (category_name) VALUES 
('Electronics'),
('Books'),
('Clothing'),
('Home Appliances'),
('Toys');

INSERT INTO Products (product_name, description, price, stock, category_id) VALUES 
('Smartphone', 'Latest model with 5G support', 699.99, 50, 1),
('Laptop', 'High-performance laptop with 16GB RAM', 999.99, 30, 1),
('Headphones', 'Noise-canceling over-ear headphones', 199.99, 100, 1),
('Novel', 'Best-selling fiction novel', 19.99, 200, 2),
('Cookbook', 'Recipes from around the world', 24.99, 150, 2),
('T-shirt', '100% cotton, unisex', 9.99, 300, 3),
('Jeans', 'Slim-fit denim jeans', 49.99, 150, 3),
('Blender', 'High-speed kitchen blender', 89.99, 40, 4),
('Board Game', 'Family-friendly board game', 29.99, 80, 5),
('Action Figure', 'Collectible action figure', 14.99, 120, 5);

INSERT INTO Customers (first_name, last_name, email, phone_number, address) VALUES 
('Amit', 'Sharma', 'amit.sharma@example.com', '9876543210', '123 MG Road, Mumbai'),
('Priya', 'Kumar', 'priya.kumar@example.com', '9876501234', '456 Park Lane, Delhi'),
('Ravi', 'Verma', 'ravi.verma@example.com', '9988776655', '789 Lakeview St, Bangalore'),
('Sneha', 'Patel', 'sneha.patel@example.com', '9123456789', '101 Crescent Ave, Ahmedabad'),
('Raj', 'Gupta', 'raj.gupta@example.com', '9234567890', '202 Skyline Blvd, Kolkata'),
('Pooja', 'Joshi', 'pooja.joshi@example.com', '9345678901', '303 Rosewood Dr, Pune'),
('Ankit', 'Mehta', 'ankit.mehta@example.com', '9456789012', '404 Lotus Path, Jaipur'),
('Neha', 'Rao', 'neha.rao@example.com', '9567890123', '505 Jasmine Lane, Chennai');

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES 
(1, '2025-01-01', 750),
(2, '2025-01-02', 1050),
(3, '2025-01-03', 50),
(4, '2025-01-04', 150),
(5, '2025-01-05', 120),
(6, '2025-01-06', 20),
(7, '2025-01-07', 90),
(8, '2025-01-08', 45),
(1, '2025-01-09', 80),
(3, '2025-01-10', 1000),
(4, '2025-01-11', 60),
(5, '2025-01-12', 105);

INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES 
(1, 1, 1, 700),
(1, 3, 1, 200),
(1, 6, 3, 10),
(2, 2, 1, 1000),
(2, 7, 1, 50),
(3, 4, 2, 20),
(4, 5, 2, 25),
(4, 8, 1, 90),
(5, 9, 2, 30),
(5, 10, 1, 15),
(6, 4, 1, 20),
(7, 8, 1, 90),
(8, 9, 1, 30),
(8, 10, 1, 15),
(9, 7, 2, 50),
(10, 2, 1, 1000),
(11, 6, 3, 10),
(11, 10, 2, 15),
(12, 5, 3, 25),
(12, 9, 1, 30);


-- 4a.Find top 3 customers by order value
SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_order_value
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_order_value DESC
LIMIT 3;

-- 4b.List products with low stock (below 10)
SELECT product_name, stock FROM Products
WHERE stock <10;

-- 4c.Calculate revenue by category
SELECT cat.category_name, SUM(oi.quantity * oi.price) AS revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
JOIN Categories cat ON p.category_id = cat.category_id
GROUP BY cat.category_name;

-- 4d.Show orders with their items and total amount
SELECT o.order_id, o.order_date, c.first_name, c.last_name, 
       p.product_name, oi.quantity, oi.price, 
       (oi.quantity * oi.price) AS total_item_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;


-- 5a.query to create a view named 'order_summary'

CREATE VIEW order_summary AS
SELECT o.order_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_full_name,
       COUNT(DISTINCT oi.product_id) AS unique_products,
       SUM(oi.quantity) AS total_quantity,
       SUM(oi.quantity * oi.price) AS total_order_amount,
       o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY o.order_id;


-- 5b.Write a stored procedure to update stock levels
DELIMITER //
CREATE PROCEDURE UpdateStock(productid INT, quantity INT, operation CHAR(1))
BEGIN
    IF operation = 'I' THEN
        UPDATE Products SET stock = stock - quantity WHERE productid = productid;
    ELSEIF operation = 'D' THEN
        UPDATE Products SET stock = stock + quantity WHERE productid = productid;
    END IF;
END //
DELIMITER ;


-- 5c.Create triggers to call the stored procedure on insertion of new order_item and deletion of an order_item

DELIMITER //
CREATE TRIGGER AfterOrderItemInsert
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    CALL UpdateStock(NEW.product_id, NEW.quantity);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER AfterOrderItemDelete
AFTER DELETE ON Order_Items
FOR EACH ROW
BEGIN
    CALL UpdateStock(OLD.product_id, -OLD.quantity);
END //
DELIMITER ;
