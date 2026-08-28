-- ============================================================
-- URBANMART POS
-- PostgreSQL Table Creation Script
-- File: 02_Table_Creation.sql
-- ============================================================

-- ============================================================
-- 1. USE URBANMART SCHEMA
-- ============================================================

SET search_path TO urbanmart;


-- ============================================================
-- 2. PRODUCT CATEGORIES
-- ============================================================

CREATE TABLE product_categories (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL
);


-- ============================================================
-- 3. CUSTOMERS
-- ============================================================

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20),
    loyalty_id INTEGER,
    customer_segment VARCHAR(50),
    created_date DATE,
    status VARCHAR(30) NOT NULL
);


-- ============================================================
-- 4. STORES
-- ============================================================

CREATE TABLE stores (
    store_id INTEGER PRIMARY KEY,
    store_name VARCHAR(150) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    store_type VARCHAR(50),
    opening_date DATE,
    status VARCHAR(30) NOT NULL
);


-- ============================================================
-- 5. PRODUCTS
-- ============================================================

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_code VARCHAR(50) UNIQUE NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    category_id INTEGER NOT NULL,
    brand VARCHAR(100),
    unit_price DECIMAL(12,2) NOT NULL,
    tax_rate DECIMAL(5,2),
    cost_price DECIMAL(12,2),
    status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES product_categories(category_id),

    CONSTRAINT chk_products_unit_price
        CHECK (unit_price >= 0),

    CONSTRAINT chk_products_cost_price
        CHECK (cost_price >= 0),

    CONSTRAINT chk_products_tax_rate
        CHECK (tax_rate >= 0)
);


-- ============================================================
-- 6. PROMOTIONS
-- ============================================================

CREATE TABLE promotions (
    promotion_id INTEGER PRIMARY KEY,
    promotion_name VARCHAR(150) NOT NULL,
    promotion_type VARCHAR(50),
    discount_percentage DECIMAL(5,2),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    minimum_quantity INTEGER,
    status VARCHAR(30),

    CONSTRAINT chk_promotion_dates
        CHECK (start_date <= end_date),

    CONSTRAINT chk_promotion_discount
        CHECK (
            discount_percentage IS NULL
            OR discount_percentage BETWEEN 0 AND 100
        ),

    CONSTRAINT chk_promotion_quantity
        CHECK (
            minimum_quantity IS NULL
            OR minimum_quantity > 0
        )
);


-- ============================================================
-- 7. TRANSACTIONS
-- ============================================================

CREATE TABLE transactions (
    transaction_id BIGINT PRIMARY KEY,
    store_id INTEGER NOT NULL,
    customer_id INTEGER,
    transaction_date TIMESTAMP NOT NULL,
    channel VARCHAR(30) NOT NULL,
    cashier_id INTEGER,
    subtotal DECIMAL(12,2) NOT NULL,
    discount_amount DECIMAL(12,2) DEFAULT 0,
    tax_amount DECIMAL(12,2) DEFAULT 0,
    total_amount DECIMAL(12,2) NOT NULL,
    transaction_status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_transactions_store
        FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CONSTRAINT fk_transactions_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT chk_transactions_subtotal
        CHECK (subtotal >= 0),

    CONSTRAINT chk_transactions_discount
        CHECK (discount_amount >= 0),

    CONSTRAINT chk_transactions_tax
        CHECK (tax_amount >= 0),

    CONSTRAINT chk_transactions_total
        CHECK (total_amount >= 0)
);


-- ============================================================
-- 8. TRANSACTION DETAILS
-- ============================================================

CREATE TABLE transaction_details (
    transaction_detail_id BIGINT PRIMARY KEY,
    transaction_id BIGINT NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    discount_amount DECIMAL(12,2) DEFAULT 0,
    tax_amount DECIMAL(12,2) DEFAULT 0,
    line_total DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_transaction_details_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id),

    CONSTRAINT fk_transaction_details_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT chk_transaction_details_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_transaction_details_unit_price
        CHECK (unit_price >= 0),

    CONSTRAINT chk_transaction_details_discount
        CHECK (discount_amount >= 0),

    CONSTRAINT chk_transaction_details_tax
        CHECK (tax_amount >= 0),

    CONSTRAINT chk_transaction_details_line_total
        CHECK (line_total >= 0)
);


-- ============================================================
-- 9. PAYMENTS
-- ============================================================

CREATE TABLE payments (
    payment_id BIGINT PRIMARY KEY,
    transaction_id BIGINT NOT NULL,
    payment_date TIMESTAMP NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_amount DECIMAL(12,2) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,
    gateway_reference VARCHAR(150),
    authorization_code VARCHAR(100),

    CONSTRAINT fk_payments_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id),

    CONSTRAINT chk_payment_amount
        CHECK (payment_amount >= 0)
);


-- ============================================================
-- 10. RETURNS
-- ============================================================

CREATE TABLE returns (
    return_id BIGINT PRIMARY KEY,
    transaction_id BIGINT NOT NULL,
    transaction_detail_id BIGINT NOT NULL,
    product_id INTEGER NOT NULL,
    return_date TIMESTAMP NOT NULL,
    return_quantity INTEGER NOT NULL,
    return_reason VARCHAR(150),
    refund_amount DECIMAL(12,2) NOT NULL,
    return_channel VARCHAR(30),
    approval_status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_returns_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id),

    CONSTRAINT fk_returns_transaction_detail
        FOREIGN KEY (transaction_detail_id)
        REFERENCES transaction_details(transaction_detail_id),

    CONSTRAINT fk_returns_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT chk_return_quantity
        CHECK (return_quantity > 0),

    CONSTRAINT chk_refund_amount
        CHECK (refund_amount >= 0)
);


-- ============================================================
-- 11. INVENTORY
-- ============================================================

CREATE TABLE inventory (
    inventory_id BIGINT PRIMARY KEY,
    store_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    available_quantity INTEGER NOT NULL,
    reserved_quantity INTEGER DEFAULT 0,
    reorder_level INTEGER NOT NULL,
    last_updated TIMESTAMP,
    inventory_status VARCHAR(30),

    CONSTRAINT fk_inventory_store
        FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT chk_inventory_available
        CHECK (available_quantity >= 0),

    CONSTRAINT chk_inventory_reserved
        CHECK (reserved_quantity >= 0),

    CONSTRAINT chk_inventory_reorder
        CHECK (reorder_level >= 0),

    CONSTRAINT uq_inventory_store_product
        UNIQUE (store_id, product_id)
);


-- ============================================================
-- 12. LOYALTY TRANSACTIONS
-- ============================================================

CREATE TABLE loyalty_transactions (
    loyalty_transaction_id BIGINT PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    transaction_id BIGINT,
    transaction_type VARCHAR(50) NOT NULL,
    points_earned INTEGER DEFAULT 0,
    points_redeemed INTEGER DEFAULT 0,
    points_reversed INTEGER DEFAULT 0,
    transaction_date TIMESTAMP NOT NULL,

    CONSTRAINT fk_loyalty_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_loyalty_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id),

    CONSTRAINT chk_points_earned
        CHECK (points_earned >= 0),

    CONSTRAINT chk_points_redeemed
        CHECK (points_redeemed >= 0),

    CONSTRAINT chk_points_reversed
        CHECK (points_reversed >= 0)
);


-- ============================================================
-- 13. RECONCILIATION
-- ============================================================

CREATE TABLE reconciliation (
    reconciliation_id BIGINT PRIMARY KEY,
    store_id INTEGER NOT NULL,
    reconciliation_date DATE NOT NULL,
    pos_transaction_count INTEGER NOT NULL,
    pos_total DECIMAL(12,2) NOT NULL,
    payment_total DECIMAL(12,2) NOT NULL,
    variance_amount DECIMAL(12,2) NOT NULL,
    reconciliation_status VARCHAR(30) NOT NULL,
    exception_reason VARCHAR(250),
    resolved_by VARCHAR(100),
    resolved_date DATE,

    CONSTRAINT fk_reconciliation_store
        FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CONSTRAINT chk_reconciliation_count
        CHECK (pos_transaction_count >= 0)
);


-- ============================================================
-- 14. TABLE CREATION VALIDATION
-- ============================================================

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'urbanmart'
ORDER BY table_name;


-- ============================================================
-- 15. EXPECTED TABLES
-- ============================================================

-- customers
-- inventory
-- loyalty_transactions
-- payments
-- product_categories
-- products
-- promotions
-- reconciliation
-- returns
-- stores
-- transaction_details
-- transactions


-- ============================================================
-- END OF SCRIPT
-- ============================================================
