-- ============================================================
-- URBANMART POS
-- PostgreSQL Data Validation Script
-- File: 04_Data_Validation.sql
-- ============================================================

SET search_path TO urbanmart;


-- ============================================================
-- 1. DATABASE / SCHEMA VALIDATION
-- ============================================================

SELECT current_database() AS database_name;

SELECT current_schema() AS schema_name;


-- ============================================================
-- 2. TABLE EXISTENCE CHECK
-- ============================================================

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'urbanmart'
ORDER BY table_name;


-- ============================================================
-- 3. ROW COUNT VALIDATION
-- ============================================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM customers

UNION ALL

SELECT 'stores', COUNT(*)
FROM stores

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'product_categories', COUNT(*)
FROM product_categories

UNION ALL

SELECT 'promotions', COUNT(*)
FROM promotions

UNION ALL

SELECT 'transactions', COUNT(*)
FROM transactions

UNION ALL

SELECT 'transaction_details', COUNT(*)
FROM transaction_details

UNION ALL

SELECT 'payments', COUNT(*)
FROM payments

UNION ALL

SELECT 'returns', COUNT(*)
FROM returns

UNION ALL

SELECT 'inventory', COUNT(*)
FROM inventory

UNION ALL

SELECT 'loyalty_transactions', COUNT(*)
FROM loyalty_transactions

UNION ALL

SELECT 'reconciliation', COUNT(*)
FROM reconciliation;


-- ============================================================
-- 4. PRIMARY KEY NULL CHECK
-- ============================================================

SELECT COUNT(*) AS null_customer_ids
FROM customers
WHERE customer_id IS NULL;

SELECT COUNT(*) AS null_store_ids
FROM stores
WHERE store_id IS NULL;

SELECT COUNT(*) AS null_product_ids
FROM products
WHERE product_id IS NULL;

SELECT COUNT(*) AS null_transaction_ids
FROM transactions
WHERE transaction_id IS NULL;


-- ============================================================
-- 5. DUPLICATE PRIMARY KEY CHECK
-- ============================================================

SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT store_id, COUNT(*) AS duplicate_count
FROM stores
GROUP BY store_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT transaction_id, COUNT(*) AS duplicate_count
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 6. PRODUCT CODE DUPLICATE CHECK
-- ============================================================

SELECT product_code, COUNT(*) AS duplicate_count
FROM products
GROUP BY product_code
HAVING COUNT(*) > 1;


-- ============================================================
-- 7. CUSTOMER EMAIL DUPLICATE CHECK
-- ============================================================

SELECT email, COUNT(*) AS duplicate_count
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;


-- ============================================================
-- 8. PRODUCT CATEGORY FOREIGN-KEY VALIDATION
-- ============================================================

SELECT p.product_id,
       p.category_id
FROM products p
LEFT JOIN product_categories c
       ON p.category_id = c.category_id
WHERE c.category_id IS NULL;


-- ============================================================
-- 9. TRANSACTION STORE FOREIGN-KEY VALIDATION
-- ============================================================

SELECT t.transaction_id,
       t.store_id
FROM transactions t
LEFT JOIN stores s
       ON t.store_id = s.store_id
WHERE s.store_id IS NULL;


-- ============================================================
-- 10. TRANSACTION CUSTOMER FOREIGN-KEY VALIDATION
-- ============================================================

SELECT t.transaction_id,
       t.customer_id
FROM transactions t
LEFT JOIN customers c
       ON t.customer_id = c.customer_id
WHERE t.customer_id IS NOT NULL
  AND c.customer_id IS NULL;


-- ============================================================
-- 11. TRANSACTION DETAIL FOREIGN-KEY VALIDATION
-- ============================================================

SELECT td.transaction_detail_id,
       td.transaction_id
FROM transaction_details td
LEFT JOIN transactions t
       ON td.transaction_id = t.transaction_id
WHERE t.transaction_id IS NULL;


-- ============================================================
-- 12. TRANSACTION DETAIL PRODUCT VALIDATION
-- ============================================================

SELECT td.transaction_detail_id,
       td.product_id
FROM transaction_details td
LEFT JOIN products p
       ON td.product_id = p.product_id
WHERE p.product_id IS NULL;


-- ============================================================
-- 13. PAYMENT TRANSACTION VALIDATION
-- ============================================================

SELECT p.payment_id,
       p.transaction_id
FROM payments p
LEFT JOIN transactions t
       ON p.transaction_id = t.transaction_id
WHERE t.transaction_id IS NULL;


-- ============================================================
-- 14. RETURN TRANSACTION VALIDATION
-- ============================================================

SELECT r.return_id,
       r.transaction_id
FROM returns r
LEFT JOIN transactions t
       ON r.transaction_id = t.transaction_id
WHERE t.transaction_id IS NULL;


-- ============================================================
-- 15. RETURN TRANSACTION DETAIL VALIDATION
-- ============================================================

SELECT r.return_id,
       r.transaction_detail_id
FROM returns r
LEFT JOIN transaction_details td
       ON r.transaction_detail_id = td.transaction_detail_id
WHERE td.transaction_detail_id IS NULL;


-- ============================================================
-- 16. RETURN PRODUCT VALIDATION
-- ============================================================

SELECT r.return_id,
       r.product_id
FROM returns r
LEFT JOIN products p
       ON r.product_id = p.product_id
WHERE p.product_id IS NULL;


-- ============================================================
-- 17. INVENTORY STORE VALIDATION
-- ============================================================

SELECT i.inventory_id,
       i.store_id
FROM inventory i
LEFT JOIN stores s
       ON i.store_id = s.store_id
WHERE s.store_id IS NULL;


-- ============================================================
-- 18. INVENTORY PRODUCT VALIDATION
-- ============================================================

SELECT i.inventory_id,
       i.product_id
FROM inventory i
LEFT JOIN products p
       ON i.product_id = p.product_id
WHERE p.product_id IS NULL;


-- ============================================================
-- 19. LOYALTY CUSTOMER VALIDATION
-- ============================================================

SELECT l.loyalty_transaction_id,
       l.customer_id
FROM loyalty_transactions l
LEFT JOIN customers c
       ON l.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- ============================================================
-- 20. LOYALTY TRANSACTION VALIDATION
-- ============================================================

SELECT l.loyalty_transaction_id,
       l.transaction_id
FROM loyalty_transactions l
LEFT JOIN transactions t
       ON l.transaction_id = t.transaction_id
WHERE l.transaction_id IS NOT NULL
  AND t.transaction_id IS NULL;


-- ============================================================
-- 21. RECONCILIATION STORE VALIDATION
-- ============================================================

SELECT r.reconciliation_id,
       r.store_id
FROM reconciliation r
LEFT JOIN stores s
       ON r.store_id = s.store_id
WHERE s.store_id IS NULL;


-- ============================================================
-- 22. REQUIRED FIELD VALIDATION
-- ============================================================

SELECT COUNT(*) AS invalid_products
FROM products
WHERE product_name IS NULL
   OR product_code IS NULL
   OR category_id IS NULL;

SELECT COUNT(*) AS invalid_stores
FROM stores
WHERE store_name IS NULL
   OR city IS NULL
   OR state IS NULL;

SELECT COUNT(*) AS invalid_transactions
FROM transactions
WHERE store_id IS NULL
   OR transaction_date IS NULL
   OR channel IS NULL
   OR transaction_status IS NULL;


-- ============================================================
-- 23. NEGATIVE VALUE CHECK
-- ============================================================

SELECT *
FROM products
WHERE unit_price < 0
   OR cost_price < 0;

SELECT *
FROM transactions
WHERE subtotal < 0
   OR discount_amount < 0
   OR tax_amount < 0
   OR total_amount < 0;

SELECT *
FROM payments
WHERE payment_amount < 0;

SELECT *
FROM returns
WHERE refund_amount < 0;


-- ============================================================
-- 24. INVALID QUANTITY CHECK
-- ============================================================

SELECT *
FROM transaction_details
WHERE quantity <= 0;

SELECT *
FROM returns
WHERE return_quantity <= 0;

SELECT *
FROM inventory
WHERE available_quantity < 0
   OR reserved_quantity < 0;


-- ============================================================
-- 25. INVALID TAX RATE CHECK
-- ============================================================

SELECT *
FROM products
WHERE tax_rate < 0
   OR tax_rate > 100;


-- ============================================================
-- 26. PROMOTION DATE VALIDATION
-- ============================================================

SELECT *
FROM promotions
WHERE start_date > end_date;


-- ============================================================
-- 27. PROMOTION DISCOUNT VALIDATION
-- ============================================================

SELECT *
FROM promotions
WHERE discount_percentage < 0
   OR discount_percentage > 100;


-- ============================================================
-- 28. PROMOTION QUANTITY VALIDATION
-- ============================================================

SELECT *
FROM promotions
WHERE minimum_quantity IS NOT NULL
  AND minimum_quantity <= 0;


-- ============================================================
-- 29. INVENTORY DUPLICATE STORE-PRODUCT CHECK
-- ============================================================

SELECT store_id,
       product_id,
       COUNT(*) AS duplicate_count
FROM inventory
GROUP BY store_id, product_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 30. TRANSACTION TOTAL VALIDATION
-- ============================================================

SELECT transaction_id,
       subtotal,
       discount_amount,
       tax_amount,
       total_amount
FROM transactions
WHERE total_amount <>
      subtotal - discount_amount + tax_amount;


-- ============================================================
-- 31. TRANSACTION DETAIL TOTAL VALIDATION
-- ============================================================

SELECT transaction_detail_id,
       quantity,
       unit_price,
       discount_amount,
       tax_amount,
       line_total
FROM transaction_details
WHERE line_total <>
      (quantity * unit_price)
      - discount_amount
      + tax_amount;


-- ============================================================
-- 32. PAYMENT VS TRANSACTION TOTAL CHECK
-- ============================================================

SELECT
    t.transaction_id,
    t.total_amount,
    COALESCE(SUM(p.payment_amount), 0) AS payment_total
FROM transactions t
LEFT JOIN payments p
       ON t.transaction_id = p.transaction_id
GROUP BY
    t.transaction_id,
    t.total_amount
HAVING COALESCE(SUM(p.payment_amount), 0)
       <> t.total_amount;


-- ============================================================
-- 33. RETURN QUANTITY VS SOLD QUANTITY
-- ============================================================

SELECT
    r.return_id,
    r.transaction_detail_id,
    r.return_quantity,
    td.quantity AS sold_quantity
FROM returns r
JOIN transaction_details td
     ON r.transaction_detail_id = td.transaction_detail_id
WHERE r.return_quantity > td.quantity;


-- ============================================================
-- 34. RETURN PRODUCT VS SOLD PRODUCT
-- ============================================================

SELECT
    r.return_id,
    r.product_id AS return_product,
    td.product_id AS sold_product
FROM returns r
JOIN transaction_details td
     ON r.transaction_detail_id = td.transaction_detail_id
WHERE r.product_id <> td.product_id;


-- ============================================================
-- 35. INVENTORY STATUS VALIDATION
-- ============================================================

SELECT
    inventory_id,
    store_id,
    product_id,
    available_quantity,
    reorder_level,
    inventory_status
FROM inventory
WHERE
    (available_quantity = 0
     AND inventory_status <> 'Out of Stock')
 OR
    (available_quantity > 0
     AND available_quantity <= reorder_level
     AND inventory_status <> 'Low Stock');


-- ============================================================
-- 36. RECONCILIATION VARIANCE VALIDATION
-- ============================================================

SELECT
    reconciliation_id,
    pos_total,
    payment_total,
    variance_amount
FROM reconciliation
WHERE variance_amount <>
      pos_total - payment_total;


-- ============================================================
-- 37. RECONCILIATION COUNT VALIDATION
-- ============================================================

SELECT
    r.reconciliation_id,
    r.pos_transaction_count,
    COUNT(t.transaction_id) AS actual_transaction_count
FROM reconciliation r
LEFT JOIN transactions t
       ON r.store_id = t.store_id
      AND DATE(t.transaction_date) = r.reconciliation_date
GROUP BY
    r.reconciliation_id,
    r.pos_transaction_count
HAVING r.pos_transaction_count
       <> COUNT(t.transaction_id);


-- ============================================================
-- 38. PAYMENT STATUS VALIDATION
-- ============================================================

SELECT *
FROM payments
WHERE payment_status IS NULL
   OR payment_method IS NULL;


-- ============================================================
-- 39. TRANSACTION STATUS VALIDATION
-- ============================================================

SELECT *
FROM transactions
WHERE transaction_status IS NULL
   OR channel IS NULL;


-- ============================================================
-- 40. CHANNEL VALUE VALIDATION
-- ============================================================

SELECT DISTINCT channel
FROM transactions
ORDER BY channel;


-- ============================================================
-- 41. INVENTORY STATUS VALUE VALIDATION
-- ============================================================

SELECT DISTINCT inventory_status
FROM inventory
ORDER BY inventory_status;


-- ============================================================
-- 42. PAYMENT METHOD VALUE VALIDATION
-- ============================================================

SELECT DISTINCT payment_method
FROM payments
ORDER BY payment_method;


-- ============================================================
-- 43. DATE NULL CHECK
-- ============================================================

SELECT COUNT(*) AS missing_transaction_dates
FROM transactions
WHERE transaction_date IS NULL;

SELECT COUNT(*) AS missing_payment_dates
FROM payments
WHERE payment_date IS NULL;

SELECT COUNT(*) AS missing_return_dates
FROM returns
WHERE return_date IS NULL;


-- ============================================================
-- 44. BASIC DATA QUALITY SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_transactions,
    COUNT(transaction_id) AS transactions_with_id,
    COUNT(store_id) AS transactions_with_store,
    COUNT(transaction_date) AS transactions_with_date,
    COUNT(total_amount) AS transactions_with_amount
FROM transactions;


-- ============================================================
-- 45. PAYMENT DATA QUALITY SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_payments,
    COUNT(payment_id) AS payments_with_id,
    COUNT(transaction_id) AS payments_with_transaction,
    COUNT(payment_amount) AS payments_with_amount
FROM payments;


-- ============================================================
-- 46. INVENTORY DATA QUALITY SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_inventory_records,
    COUNT(store_id) AS records_with_store,
    COUNT(product_id) AS records_with_product,
    COUNT(available_quantity) AS records_with_quantity
FROM inventory;


-- ============================================================
-- 47. FINAL VALIDATION STATUS
-- ============================================================

SELECT
    'UrbanMart POS Database Validation Completed'
    AS validation_status;


-- ============================================================
-- END OF SCRIPT
-- ============================================================
