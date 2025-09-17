# E-Commerce Servlet Application

A complete e-commerce web application built with Java Servlets, JSP, HTML, CSS, and MySQL database.

## Quick Start (Windows)

Follow these steps to run the project locally.

### Prerequisites
- JDK 11 or higher (set JAVA_HOME)
- Maven 3.6+ in PATH
- MySQL 8.0+ running locally (or compatible MySQL server)

### 1) Database setup
1. Create a MySQL database named `ecommerce` (or choose your own name).
2. Create a MySQL user with privileges or use an existing one.
3. Update the credentials in `src/main/java/com/ecommerce/util/DatabaseConnection.java`:
   - URL (default in repo): `jdbc:mysql://localhost:3306/ecommerce`
   - USERNAME
   - PASSWORD

If you want to keep credentials out of source code, consider changing DatabaseConnection to read from env vars, but the current code uses constants.

Tables expected by the app include: users, products, cart_items (and others used by DAOs/JSPs). If you don't have a schema yet, you can create minimal tables to get the product list and cart working. Example minimal schema:

```sql
-- Create the database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS ecommerce_db;

-- Switch to the newly created database
USE ecommerce_db;

-- ----------------------------
-- User and Admin Management
-- ----------------------------

-- Table for customer user accounts 
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for administrator accounts 
CREATE TABLE admins (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'admin', -- For multi-role admin access later [cite: 26]
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for user addresses (shipping/billing) 
CREATE TABLE addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    address_type ENUM('shipping', 'billing') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


-- ----------------------------
-- Product Catalog
-- ----------------------------

-- Table for product categories 
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Table for products 
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    stock_quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Table for multiple product images 
CREATE TABLE product_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);


-- ----------------------------
-- Shopping Cart
-- ----------------------------

-- Table representing a user's shopping cart 
CREATE TABLE carts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table for items within a shopping cart 
CREATE TABLE cart_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);


-- ----------------------------
-- Order and Payment Processing
-- ----------------------------

-- Table for customer orders 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending', -- e.g., 'Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'
    shipping_address_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (shipping_address_id) REFERENCES addresses(id) ON DELETE SET NULL
);

-- Table for items within an order 
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL, -- Price of the product when the order was placed
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Table for payment transactions 
CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method VARCHAR(50),
    amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL, -- e.g., 'Completed', 'Failed', 'Pending'
    transaction_id VARCHAR(255),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);


-- ----------------------------
-- Additional Features
-- ----------------------------

-- Table for discount coupons 
CREATE TABLE coupons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) NOT NULL UNIQUE,
    discount_type ENUM('percentage', 'fixed') NOT NULL,
    discount_value DECIMAL(10, 2) NOT NULL,
    expiry_date DATE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Table for product reviews 
CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


-- ----------------------------
-- Logging
-- ----------------------------

-- Table for auditing important actions 
CREATE TABLE audit_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT, -- Can be a customer
    admin_id INT, -- Or an admin
    action VARCHAR(255) NOT NULL, -- e.g., 'USER_LOGIN', 'PRODUCT_UPDATE', 'ORDER_CANCELLED'
    details TEXT, -- Can store details of the action, e.g., old and new values in JSON format
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE SET NULL
);

INSERT INTO categories (id, name) VALUES (1, 'Electronics') ON DUPLICATE KEY UPDATE name=name;
INSERT INTO categories (id, name) VALUES (2, 'Books') ON DUPLICATE KEY UPDATE name=name;

ALTER TABLE products ADD COLUMN image_url VARCHAR(255);]

-- Insert a sample admin with a placeholder hashed password.
-- The password is 'adminpass' (it will be hashed by our placeholder function).
INSERT INTO admins (name, email, password_hash, role) VALUES ('Administrator', 'admin@example.com', 'hashed_adminpass', 'superadmin');

```

### 2) Run the app (embedded Tomcat via Maven)
This project is packaged as a WAR and already includes the Tomcat 7 Maven plugin for development.

- In a terminal (PowerShell) at the project root, run:

```
mvn clean package
mvn tomcat7:run
```

- The app will start at: http://localhost:8080/ecommerce

### 3) Access URLs
- Product catalog: http://localhost:8080/ecommerce/products
- Login: http://localhost:8080/ecommerce/login
- Cart: http://localhost:8080/ecommerce/cart

Note: The welcome file points to `products`, so visiting http://localhost:8080/ecommerce should redirect/render products.

### Alternative: Deploy WAR to a standalone Tomcat
1. Build the WAR:
```
mvn clean package
```
2. Copy `target/ecommerce-app.war` to your Tomcat `webapps` folder.
3. Start Tomcat and access at `http://localhost:8080/ecommerce-app` (context may differ by filename).

## Troubleshooting
- Port 8080 is busy: change the port in `pom.xml` under `tomcat7-maven-plugin`.
- DB connection errors: verify MySQL is running, credentials in `DatabaseConnection.java`, and the schema exists.
- JDBC driver errors: Maven will download `mysql-connector-java` automatically; ensure you ran `mvn package` at least once.

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/ecommerce/
│   │       ├── dao/          # Data Access Objects
│   │       ├── model/        # Entity classes
│   │       ├── servlet/      # Servlet controllers
│   │       └── util/         # Utility classes
│   ├── webapp/
│   │   ├── WEB-INF/
│   │   │   ├── views/        # JSP pages
│   │   │   └── web.xml       # Web application configuration
│   │   ├── css/              # CSS stylesheets
│   │   └── images/           # Static images
│   └── resources/            # Configuration files
```

## Development
To run in development mode with embedded Tomcat:

```
mvn tomcat7:run
```

This will start the application on `http://localhost:8080/ecommerce`.

## License
This project is licensed under the MIT License.
