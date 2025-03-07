### Project 6: DVD Rental System (Complex Model)  

#### **Business Scenario**  
A DVD rental company manages a multi-store system with films, actors, customers, rentals, and payments. Stores have their own inventory, staff, and customers. Films belong to categories, and actors are associated with films. Track rentals, returns, late fees, and payments.  

---

#### **Questions**  
1. Design an **ER diagram** with tables:  
   - `films`, `actors`, `categories`, `inventory`, `stores`, `staff`, `customers`, `rentals`, `payments`  
   - Include relationships like `film_actor` (many-to-many) and `film_category` (many-to-one).  
2. Create tables with constraints (PKs, FKs, `CHECK` for rental duration and payment amounts).  
3. Insert sample data:  
   - 2 films, 3 actors, 2 categories, 2 stores, 3 staff, 2 customers.  
   - Assign films to actors and categories.  
4. Simulate a customer renting 2 DVDs from a store.  
5. Add a `loyalty_status` column to `customers`.  
6. Update a rental’s return date and calculate late fees.  
7. Delete a film and handle dependencies (e.g., inventory).  

---

#### **Answer Script**  

```sql  
-- 1. ER Diagram Description:  
-- films(film_id, title, release_year, rental_rate, category_id)  
-- actors(actor_id, first_name, last_name)  
-- film_actor(film_id, actor_id)  
-- categories(category_id, name)  
-- inventory(inventory_id, film_id, store_id)  
-- stores(store_id, address, city)  
-- staff(staff_id, first_name, last_name, store_id)  
-- customers(customer_id, first_name, last_name, email, loyalty_status)  
-- rentals(rental_id, inventory_id, customer_id, staff_id, rental_date, return_date)  
-- payments(payment_id, rental_id, amount, payment_date)  

-- 2. Create Tables  
CREATE TABLE categories (  
    category_id SERIAL PRIMARY KEY,  
    name VARCHAR(50) NOT NULL  
);  

CREATE TABLE films (  
    film_id SERIAL PRIMARY KEY,  
    title VARCHAR(100) NOT NULL,  
    release_year INT,  
    rental_rate DECIMAL(4,2) CHECK (rental_rate > 0),  
    category_id INT REFERENCES categories(category_id)  
);  

CREATE TABLE actors (  
    actor_id SERIAL PRIMARY KEY,  
    first_name VARCHAR(50) NOT NULL,  
    last_name VARCHAR(50) NOT NULL  
);  

-- Junction table for many-to-many relationship  
CREATE TABLE film_actor (  
    film_id INT REFERENCES films(film_id) ON DELETE CASCADE,  
    actor_id INT REFERENCES actors(actor_id) ON DELETE CASCADE,  
    PRIMARY KEY (film_id, actor_id)  
);  

CREATE TABLE stores (  
    store_id SERIAL PRIMARY KEY,  
    address VARCHAR(100) NOT NULL,  
    city VARCHAR(50) NOT NULL  
);  

CREATE TABLE inventory (  
    inventory_id SERIAL PRIMARY KEY,  
    film_id INT REFERENCES films(film_id) ON DELETE CASCADE,  
    store_id INT REFERENCES stores(store_id)  
);  

CREATE TABLE staff (  
    staff_id SERIAL PRIMARY KEY,  
    first_name VARCHAR(50) NOT NULL,  
    last_name VARCHAR(50) NOT NULL,  
    store_id INT REFERENCES stores(store_id)  
);  

CREATE TABLE customers (  
    customer_id SERIAL PRIMARY KEY,  
    first_name VARCHAR(50) NOT NULL,  
    last_name VARCHAR(50) NOT NULL,  
    email VARCHAR(100) UNIQUE  
);  

CREATE TABLE rentals (  
    rental_id SERIAL PRIMARY KEY,  
    inventory_id INT REFERENCES inventory(inventory_id),  
    customer_id INT REFERENCES customers(customer_id),  
    staff_id INT REFERENCES staff(staff_id),  
    rental_date DATE DEFAULT CURRENT_DATE,  
    return_date DATE,  
    CHECK (return_date >= rental_date)  
);  

CREATE TABLE payments (  
    payment_id SERIAL PRIMARY KEY,  
    rental_id INT REFERENCES rentals(rental_id),  
    amount DECIMAL(5,2) CHECK (amount > 0),  
    payment_date DATE DEFAULT CURRENT_DATE  
);  

-- 3. Insert Sample Data  
-- Categories  
INSERT INTO categories (name) VALUES ('Action'), ('Comedy');  

-- Films  
INSERT INTO films (title, release_year, rental_rate, category_id)  
VALUES  
('Space Warriors', 2023, 3.99, 1),  
('Laugh Festival', 2022, 2.99, 2);  

-- Actors  
INSERT INTO actors (first_name, last_name)  
VALUES  
('Tom', 'Holland'),  
('Zendaya', 'Coleman'),  
('Ryan', 'Reynolds');  

-- Assign actors to films  
INSERT INTO film_actor (film_id, actor_id)  
VALUES (1, 1), (1, 2), (2, 3);  

-- Stores  
INSERT INTO stores (address, city)  
VALUES  
('123 Main St', 'New York'),  
('456 Oak Ave', 'Los Angeles');  

-- Inventory  
INSERT INTO inventory (film_id, store_id)  
VALUES (1, 1), (1, 1), (2, 2);  

-- Staff  
INSERT INTO staff (first_name, last_name, store_id)  
VALUES  
('John', 'Doe', 1),  
('Jane', 'Smith', 2),  
('Bob', 'Brown', 1);  

-- Customers  
INSERT INTO customers (first_name, last_name, email)  
VALUES  
('Alice', 'Johnson', 'alice@example.com'),  
('Mike', 'Davis', 'mike@example.com');  

-- 4. Simulate a Rental  
INSERT INTO rentals (inventory_id, customer_id, staff_id)  
VALUES (1, 1, 1), (3, 2, 2);  

-- 5. Add Loyalty Status  
ALTER TABLE customers  
ADD COLUMN loyalty_status VARCHAR(20) DEFAULT 'Bronze';  

-- 6. Update Return Date with Late Fee  
UPDATE rentals  
SET return_date = CURRENT_DATE + 7  
WHERE rental_id = 1;  

-- Simulate a payment with a late fee (assumes $1/day late fee)  
INSERT INTO payments (rental_id, amount)  
VALUES (1, 3.99 + (7 * 1.00));  

-- 7. Delete a Film (Cascades to Inventory and film_actor)  
DELETE FROM films WHERE film_id = 2;  
```  

---

#### **Key Complexity Notes**  
- **Multi-Store Inventory**: Tracks which DVDs belong to which store.  
- **Staff-Store Relationship**: Staff are assigned to specific stores.  
- **Cascading Deletes**: Deleting a film removes its inventory and actor associations.  
- **Late Fee Calculation**: Manual example in `payments` (can be automated with triggers).  
