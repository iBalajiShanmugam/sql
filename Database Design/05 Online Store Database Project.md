# Online Store Database Project

## Business Requirements

You have been hired to design a database for an online store. The store sells a variety of products and needs to track customers, orders, products, and inventory. The system should be able to:

1. Store information about products including name, description, price, and current inventory levels
2. Maintain customer information including name, email, shipping address, and purchase history
3. Process orders with multiple items, including payment information and shipping status
4. Track product categories and suppliers
5. Generate reports on best-selling products, customer purchasing patterns, and inventory levels

## ER Diagram Description

The database should consist of the following entities and relationships:

- **Customers**: Contains information about registered customers
- **Products**: Contains details about each product in the store
- **Categories**: Contains different product categories
- **Suppliers**: Contains information about product suppliers
- **Orders**: Contains the main order information
- **OrderItems**: Contains details about each product in an order
- **Inventory**: Tracks the stock levels of products

Relationships:
- A Product belongs to exactly one Category (many-to-one)
- A Product is supplied by exactly one Supplier (many-to-one)
- A Customer can place multiple Orders (one-to-many)
- An Order belongs to exactly one Customer (many-to-one)
- An Order contains multiple Products through OrderItems (many-to-many)
- A Product can be in multiple Orders through OrderItems (many-to-many)
- A Product has one Inventory record (one-to-one)

## Required Tasks

1. Create all necessary tables with appropriate columns and data types
2. Define primary keys and foreign keys to establish proper relationships
3. Add constraints where necessary (NOT NULL, UNIQUE, CHECK constraints)
4. Write queries to insert sample data
5. Write queries to update and delete data
6. Create queries to retrieve information from multiple tables using JOINs

## Solution

### Step 1: Create Database Tables

```sql
-- Create the Suppliers table
CREATE TABLE Suppliers (
    supplier_id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create the Categories table
CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    parent_category_id INTEGER REFERENCES Categories(category_id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create the Products table
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    sku VARCHAR(50) UNIQUE NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    weight_kg NUMERIC(8, 3),
    category_id INTEGER NOT NULL REFERENCES Categories(category_id) ON UPDATE CASCADE,
    supplier_id INTEGER NOT NULL REFERENCES Suppliers(supplier_id) ON UPDATE CASCADE,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create the Inventory table
CREATE TABLE Inventory (
    inventory_id SERIAL PRIMARY KEY,
    product_id INTEGER UNIQUE NOT NULL REFERENCES Products(product_id) ON UPDATE CASCADE,
    quantity_in_stock INTEGER NOT NULL DEFAULT 0 CHECK (quantity_in_stock >= 0),
    reorder_level INTEGER NOT NULL DEFAULT 5 CHECK (reorder_level >= 0),
    last_restock_date TIMESTAMP,
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create the Customers table
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

-- Create the CustomerAddresses table
CREATE TABLE CustomerAddresses (
    address_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES Customers(customer_id) ON DELETE CASCADE,
    address_type VARCHAR(20) NOT NULL CHECK (address_type IN ('BILLING', 'SHIPPING')),
    address_line1 VARCHAR(100) NOT NULL,
    address_line2 VARCHAR(100),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(50) NOT NULL,
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE (customer_id, address_type, is_default)
);

-- Create the Orders table
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES Customers(customer_id) ON UPDATE CASCADE,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    shipping_address_id INTEGER NOT NULL REFERENCES CustomerAddresses(address_id) ON UPDATE CASCADE,
    billing_address_id INTEGER NOT NULL REFERENCES CustomerAddresses(address_id) ON UPDATE CASCADE,
    shipping_method VARCHAR(50) NOT NULL,
    order_status VARCHAR(20) NOT NULL DEFAULT 'PENDING' CHECK (order_status IN ('PENDING', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED')),
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'UNPAID' CHECK (payment_status IN ('UNPAID', 'PAID', 'REFUNDED')),
    order_total NUMERIC(10, 2) NOT NULL CHECK (order_total >= 0),
    shipping_cost NUMERIC(10, 2) NOT NULL DEFAULT 0 CHECK (shipping_cost >= 0),
    tax_amount NUMERIC(10, 2) NOT NULL DEFAULT 0 CHECK (tax_amount >= 0)
);

-- Create the OrderItems table
CREATE TABLE OrderItems (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES Orders(order_id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES Products(product_id) ON UPDATE CASCADE,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    subtotal NUMERIC(10, 2) NOT NULL CHECK (subtotal >= 0),
    UNIQUE (order_id, product_id)
);
```

### Step 2: Add Sample Data

```sql
-- Insert sample suppliers
INSERT INTO Suppliers (company_name, contact_name, contact_email, contact_phone, address) VALUES
('Tech Gadgets Inc.', 'Robert Johnson', 'robert@techgadgets.com', '555-123-4567', '123 Tech St, Silicon Valley, CA 94025'),
('Fashion Forward Ltd.', 'Emily Chen', 'emily@fashionforward.com', '555-234-5678', '456 Style Ave, New York, NY 10001'),
('Home Essentials Co.', 'David Wilson', 'david@homeessentials.com', '555-345-6789', '789 Home Blvd, Chicago, IL 60601'),
('Outdoor Adventures', 'Sarah Brown', 'sarah@outdooradv.com', '555-456-7890', '101 Adventure Rd, Denver, CO 80201'),
('Gourmet Foods Inc.', 'Michael Smith', 'michael@gourmetfoods.com', '555-567-8901', '202 Flavor St, San Francisco, CA 94110');

-- Insert sample categories
INSERT INTO Categories (name, description, parent_category_id) VALUES
('Electronics', 'Electronic devices and accessories', NULL),
('Clothing', 'Apparel and fashion items', NULL),
('Home & Kitchen', 'Home goods and kitchen supplies', NULL),
('Smartphones', 'Mobile phones and accessories', 1),
('Laptops', 'Portable computers', 1),
('Men''s Clothing', 'Clothing items for men', 2),
('Women''s Clothing', 'Clothing items for women', 2),
('Cookware', 'Pots, pans, and cooking utensils', 3),
('Bedding', 'Sheets, comforters, and pillows', 3);

-- Insert sample products
INSERT INTO Products (name, description, sku, price, weight_kg, category_id, supplier_id) VALUES
('Smartphone X', 'Latest smartphone with advanced features', 'PHONE-X-001', 899.99, 0.25, 4, 1),
('Laptop Pro', '15-inch laptop with high performance', 'LAPTOP-PRO-001', 1299.99, 2.5, 5, 1),
('Men''s Casual Shirt', 'Comfortable cotton shirt for everyday wear', 'MENS-SHIRT-001', 39.99, 0.3, 6, 2),
('Women''s Dress', 'Elegant dress for special occasions', 'WOMENS-DRESS-001', 79.99, 0.5, 7, 2),
('Non-stick Frying Pan', 'Durable non-stick cookware', 'COOKWARE-PAN-001', 49.99, 1.2, 8, 3),
('Queen Size Comforter', 'Soft and warm bedding for queen size beds', 'BEDDING-COM-001', 89.99, 2.0, 9, 3),
('Hiking Backpack', 'Durable backpack for outdoor adventures', 'OUTDOOR-PACK-001', 129.99, 1.5, 3, 4),
('Gourmet Coffee Beans', 'Premium coffee beans from South America', 'FOOD-COFFEE-001', 24.99, 0.5, 3, 5);

-- Insert sample inventory
INSERT INTO Inventory (product_id, quantity_in_stock, reorder_level, last_restock_date) VALUES
(1, 50, 10, CURRENT_TIMESTAMP - INTERVAL '10 days'),
(2, 25, 5, CURRENT_TIMESTAMP - INTERVAL '15 days'),
(3, 100, 20, CURRENT_TIMESTAMP - INTERVAL '5 days'),
(4, 75, 15, CURRENT_TIMESTAMP - INTERVAL '8 days'),
(5, 60, 15, CURRENT_TIMESTAMP - INTERVAL '12 days'),
(6, 40, 10, CURRENT_TIMESTAMP - INTERVAL '20 days'),
(7, 30, 10, CURRENT_TIMESTAMP - INTERVAL '7 days'),
(8, 80, 20, CURRENT_TIMESTAMP - INTERVAL '3 days');

-- Insert sample customers
INSERT INTO Customers (first_name, last_name, email, phone, password_hash) VALUES
('John', 'Doe', 'john.doe@email.com', '555-111-2222', 'hashed_password_1'),
('Jane', 'Smith', 'jane.smith@email.com', '555-222-3333', 'hashed_password_2'),
('Alex', 'Johnson', 'alex.johnson@email.com', '555-333-4444', 'hashed_password_3'),
('Maria', 'Garcia', 'maria.garcia@email.com', '555-444-5555', 'hashed_password_4');

-- Insert sample customer addresses
INSERT INTO CustomerAddresses (customer_id, address_type, address_line1, city, state, postal_code, country, is_default) VALUES
(1, 'SHIPPING', '123 Main St', 'Austin', 'TX', '78701', 'USA', TRUE),
(1, 'BILLING', '123 Main St', 'Austin', 'TX', '78701', 'USA', TRUE),
(2, 'SHIPPING', '456 Oak Ave', 'Seattle', 'WA', '98101', 'USA', TRUE),
(2, 'BILLING', '456 Oak Ave', 'Seattle', 'WA', '98101', 'USA', TRUE),
(3, 'SHIPPING', '789 Pine Rd', 'Boston', 'MA', '02108', 'USA', TRUE),
(3, 'BILLING', '789 Pine Rd', 'Boston', 'MA', '02108', 'USA', TRUE),
(4, 'SHIPPING', '101 Maple Dr', 'Miami', 'FL', '33101', 'USA', TRUE),
(4, 'BILLING', '101 Maple Dr', 'Miami', 'FL', '33101', 'USA', TRUE);

-- Insert sample orders
INSERT INTO Orders (customer_id, shipping_address_id, billing_address_id, shipping_method, order_status, payment_method, payment_status, order_total, shipping_cost, tax_amount) VALUES
(1, 1, 2, 'Standard', 'DELIVERED', 'CREDIT_CARD', 'PAID', 949.99, 10.00, 40.00),
(2, 3, 4, 'Express', 'SHIPPED', 'PAYPAL', 'PAID', 129.98, 15.00, 15.00),
(3, 5, 6, 'Standard', 'PROCESSING', 'CREDIT_CARD', 'PAID', 174.98, 10.00, 25.00),
(4, 7, 8, 'Express', 'PENDING', 'CREDIT_CARD', 'UNPAID', 1389.99, 20.00, 70.00);

-- Insert sample order items
INSERT INTO OrderItems (order_id, product_id, quantity, unit_price, subtotal) VALUES
(1, 1, 1, 899.99, 899.99),
(2, 3, 2, 39.99, 79.98),
(2, 8, 2, 24.99, 49.98),
(3, 5, 1, 49.99, 49.99),
(3, 6, 1, 89.99, 89.99),
(4, 2, 1, 1299.99, 1299.99);
```

### Step 3: Alter Table Examples

```sql
-- Add a new column to the Products table
ALTER TABLE Products ADD COLUMN discount_percentage NUMERIC(5, 2) DEFAULT 0 CHECK (discount_percentage >= 0 AND discount_percentage <= 100);

-- Add a new column to the Customers table
ALTER TABLE Customers ADD COLUMN loyalty_points INTEGER NOT NULL DEFAULT 0 CHECK (loyalty_points >= 0);

-- Change column constraint
ALTER TABLE Products ALTER COLUMN description SET NOT NULL;

-- Add a new constraint to the OrderItems table
ALTER TABLE OrderItems ADD CONSTRAINT check_quantity_limit CHECK (quantity <= 10);

-- Add a composite index for faster querying
CREATE INDEX idx_order_items_order_product ON OrderItems(order_id, product_id);
```

### Step 4: Update Data

```sql
-- Update product prices
UPDATE Products SET price = 849.99, discount_percentage = 5.5 WHERE product_id = 1;
UPDATE Products SET price = 1199.99, discount_percentage = 7.7 WHERE product_id = 2;

-- Update inventory levels
UPDATE Inventory SET quantity_in_stock = quantity_in_stock - 5, last_updated = CURRENT_TIMESTAMP WHERE product_id = 3;
UPDATE Inventory SET quantity_in_stock = quantity_in_stock + 20, last_restock_date = CURRENT_TIMESTAMP, last_updated = CURRENT_TIMESTAMP WHERE product_id = 4;

-- Update order status
UPDATE Orders SET order_status = 'DELIVERED', payment_status = 'PAID' WHERE order_id = 3;

-- Update customer information
UPDATE Customers SET phone = '555-999-8888', last_login = CURRENT_TIMESTAMP WHERE customer_id = 4;

-- Add loyalty points to customers
UPDATE Customers SET loyalty_points = loyalty_points + 100 WHERE customer_id IN (1, 2);
```

### Step 5: Delete Data

```sql
-- Delete an order (will cascade to OrderItems due to foreign key constraints)
DELETE FROM Orders WHERE order_id = 4;

-- Delete a product (this will fail if the product is referenced in OrderItems or Inventory)
DELETE FROM Products WHERE product_id = 7 AND NOT EXISTS (SELECT 1 FROM OrderItems WHERE product_id = 7);

-- Delete inventory first, then the product
DELETE FROM Inventory WHERE product_id = 7;
DELETE FROM Products WHERE product_id = 7;

-- Delete a category that has no products
DELETE FROM Categories WHERE category_id NOT IN (SELECT DISTINCT category_id FROM Products);
```

### Step 6: Complex Queries

```sql
-- Find the top 5 best-selling products
SELECT p.product_id, p.name, p.category_id, c.name AS category_name, 
       SUM(oi.quantity) AS total_quantity_sold, 
       SUM(oi.subtotal) AS total_revenue
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
JOIN Categories c ON p.category_id = c.category_id
WHERE o.order_status != 'CANCELLED'
GROUP BY p.product_id, p.name, p.category_id, c.name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Find products that need to be restocked
SELECT p.product_id, p.name, i.quantity_in_stock, i.reorder_level, 
       s.company_name AS supplier_name, s.contact_name, s.contact_email
FROM Products p
JOIN Inventory i ON p.product_id = i.product_id
JOIN Suppliers s ON p.supplier_id = s.supplier_id
WHERE i.quantity_in_stock <= i.reorder_level
ORDER BY i.quantity_in_stock ASC;

-- Find customers who haven't placed an order in the last 90 days
SELECT c.customer_id, c.first_name, c.last_name, c.email, 
       MAX(o.order_date) AS last_order_date,
       CURRENT_TIMESTAMP - MAX(o.order_date) AS days_since_last_order
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING MAX(o.order_date) < (CURRENT_TIMESTAMP - INTERVAL '90 days')
   OR MAX(o.order_date) IS NULL
ORDER BY last_order_date ASC NULLS FIRST;

-- Calculate average order value by month
SELECT 
    DATE_TRUNC('month', o.order_date) AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.order_total) AS total_revenue,
    AVG(o.order_total) AS average_order_value
FROM Orders o
WHERE o.order_status != 'CANCELLED'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY month DESC;
```

### Step 7: Drop Tables

```sql
-- Drop all tables (in reverse order of dependencies)
DROP TABLE OrderItems;
DROP TABLE Orders;
DROP TABLE CustomerAddresses;
DROP TABLE Customers;
DROP TABLE Inventory;
DROP TABLE Products;
DROP TABLE Categories;
DROP TABLE Suppliers;
```