-- Create the required tables for the retail store database based on the tables structure and relationships. (0.5 Grade)
CREATE DATABASE retailStore;

CREATE TABLE IF NOT EXISTS suppliers (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    contactNumber TEXT
);

CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255), 
    price DECIMAL,
    stockQuantity INT,
    supplierId INT, 
    FOREIGN KEY (supplierId) REFERENCES suppliers (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS sales (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    productId INT,
    quantitySold INT,
    saleDate DATE,
    FOREIGN KEY (productId) REFERENCES products (id) ON UPDATE CASCADE ON DELETE CASCADE
);





ALTER TABLE products ADD category VARCHAR(255);



ALTER TABLE products DROP COLUMN category;


ALTER TABLE suppliers MODIFY contactNumber VARCHAR(15);

-- 5- Add a NOT NULL constraint to ProductName. (0.5 Grade)
ALTER TABLE products MODIFY name VARCHAR(255) NOT NULL;


INSERT INTO suppliers (name, contactNumber) VALUES ('FreshFoods', '01001234567');
INSERT INTO products (name, price, stockQuantity, supplierId) VALUES 
    ('Milk', 15, 50, 1),
    ('Bread', 10, 30, 1),
    ('Eggs', 20, 40, 1);
INSERT INTO sales (productId, quantitySold, saleDate) VALUES (1, 2, '2025-05-20');

-- 7- Update the price of 'Bread' to 25.00. (0.5 Grade)
UPDATE products SET price = 25 WHERE id = 2;

-- 8- Delete the product 'Eggs'. (0.5 Grade)
DELETE FROM products WHERE id = 3;

-- 9- Retrieve the total quantity sold for each product. (0.5 Grade)
SELECT SUM(quantitySold) FROM sales;
SELECT quantitySold, productId FROM sales JOIN products ON sales.productId = products.id;

-- 10- Get the product with the highest stock. (0.5 Grade)
SELECT * FROM products ORDER BY stockQuantity DESC LIMIT 1;

-- 11- Find suppliers with names starting with 'F'. (0.5 Grade)
SELECT * FROM suppliers WHERE name LIKE "F%";

-- 12- Show all products that have never been sold. (0.5 Grade)
SELECT products.* FROM products LEFT JOIN sales ON products.id = sales.productId WHERE sales.quantitySold IS NULL;

-- 13- Get all sales along with product name and sale date. (0.5 Grade)
SELECT p.name, p.price, p.id AS product_id, s.id AS sales_id, s.saleDate FROM products p RIGHT JOIN sales s ON p.id = s.productId;
SELECT p.name, p.price, p.id AS product_id, s.id AS sales_id, s.saleDate FROM products AS p RIGHT JOIN sales AS s ON p.id = s.productId;

-- 14- Create a user “store_manager” and give them SELECT, INSERT, and UPDATE permissions on all tables. (0.5 Grade)
CREATE USER 'store_manager'@'localhost' IDENTIFIED BY 'myPassword';
GRANT SELECT, INSERT, UPDATE ON retailStore.* TO 'store_manager'@'localhost';

-- 15- Revoke UPDATE permission from “store_manager”. (0.5 Grade)
REVOKE UPDATE ON retailStore.* FROM 'store_manager'@'localhost';

-- 16- Grant DELETE permission to “store_manager” only on the Sales table. (0.5 Grade)
GRANT DELETE ON retailStore.sales To 'store_manager'@'localhost';