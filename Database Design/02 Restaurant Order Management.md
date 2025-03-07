### Restaurant Order Management  

#### **Business Scenario**  
A restaurant wants to track menu items, customer orders, and order details. Each order can include multiple dishes, and the system should calculate total prices.  

---

#### **Questions**  
1. Design an ER diagram with `menu_items`, `orders`, and `order_details`.  
2. Create tables with PKs/FKs. Ensure prices are positive.  
3. Insert 3 menu items and 2 customers.  
4. Place an order with 2 items.  
5. Add a `loyalty_points` column to customers.  
6. Update the price of a menu item.  
7. Delete a menu item and handle dependent records.  

---

#### **Answer Script**  
```sql
-- 1. ER Diagram Description:
-- menu_items(item_id, name, category, price)
-- customers(customer_id, name, phone, loyalty_points)
-- orders(order_id, customer_id, order_date, total_amount)
-- order_details(detail_id, order_id, item_id, quantity)

-- 2. Create Tables
CREATE TABLE menu_items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category VARCHAR(20) CHECK (category IN ('Appetizer', 'Main', 'Dessert')),
    price DECIMAL(10,2) CHECK (price > 0)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2)
);

CREATE TABLE order_details (
    detail_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    item_id INT REFERENCES menu_items(item_id),
    quantity INT NOT NULL
);

-- 3. Insert Sample Data
INSERT INTO menu_items (name, category, price) 
VALUES 
('Bruschetta', 'Appetizer', 8.99),
('Grilled Salmon', 'Main', 22.50),
('Tiramisu', 'Dessert', 6.99);

INSERT INTO customers (name, phone) 
VALUES 
('Sophia Lee', '555-1234'),
('Daniel Kim', '555-5678');

-- 4. Place an Order
INSERT INTO orders (customer_id) VALUES (1);
INSERT INTO order_details (order_id, item_id, quantity) 
VALUES (1, 1, 2), (1, 3, 1);

-- 5. Alter Customers Table
ALTER TABLE customers 
ADD COLUMN loyalty_points INT DEFAULT 0;

-- 6. Update Menu Item Price
UPDATE menu_items 
SET price = 9.99 
WHERE item_id = 1;

-- 7. Delete a Menu Item (Cascades to Order Details)
DELETE FROM menu_items 
WHERE item_id = 3;
```

---