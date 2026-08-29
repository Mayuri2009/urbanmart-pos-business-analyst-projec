-- ============================================================
-- URBANMART POS
-- SQL Business Analysis Queries
-- File: 03_SQL_Queries.sql
-- Database: PostgreSQL
-- Schema: urbanmart
--
-- Purpose:
-- Answer the 15 prioritized UrbanMart business questions
-- using simple, readable and interview-friendly SQL.
-- ============================================================

SET search_path TO urbanmart;


-- ============================================================
-- SECTION 1: STORE PERFORMANCE
-- ============================================================

-- ============================================================
-- Q01. Which stores generate the highest revenue?
--
-- Business Purpose:
-- Identify the strongest revenue-generating stores.
--
-- SQL Concepts:
-- JOIN, GROUP BY, SUM, ORDER BY
-- ============================================================

SELECT
    s.store_id,
    s.store_name,
    SUM(t.total_amount) AS total_revenue
FROM stores s
JOIN transactions t
    ON s.store_id = t.store_id
WHERE t.transaction_status = 'Completed'
GROUP BY
    s.store_id,
    s.store_name
ORDER BY total_revenue DESC;


-- ============================================================
-- Q02. Which products generate the highest revenue?
--
-- Business Purpose:
-- Identify products contributing the most sales revenue.
--
-- SQL Concepts:
-- JOIN, GROUP BY, SUM
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(td.line_total) AS total_revenue
FROM products p
JOIN transaction_details td
    ON p.product_id = td.product_id
JOIN transactions t
    ON td.transaction_id = t.transaction_id
WHERE t.transaction_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC;


-- ============================================================
-- Q03. Which product categories perform best?
--
-- Business Purpose:
-- Compare revenue across product categories.
--
-- SQL Concepts:
-- JOIN, GROUP BY, SUM
-- ============================================================

SELECT
    pc.category_id,
    pc.category_name,
    SUM(td.line_total) AS total_revenue
FROM product_categories pc
JOIN products p
    ON pc.category_id = p.category_id
JOIN transaction_details td
    ON p.product_id = td.product_id
JOIN transactions t
    ON td.transaction_id = t.transaction_id
WHERE t.transaction_status = 'Completed'
GROUP BY
    pc.category_id,
    pc.category_name
ORDER BY total_revenue DESC;


-- ============================================================
-- SECTION 2: STORE KPI
-- ============================================================

-- ============================================================
-- Q04. What is the average transaction value by store?
--
-- Formula:
-- Total Revenue / Transaction Count
--
-- SQL Concepts:
-- JOIN, GROUP BY, COUNT, SUM, CASE
-- ============================================================

SELECT
    s.store_id,
    s.store_name,
    COUNT(t.transaction_id) AS transaction_count,
    SUM(t.total_amount) AS total_revenue,
    CASE
        WHEN COUNT(t.transaction_id) = 0 THEN 0
        ELSE SUM(t.total_amount) / COUNT(t.transaction_id)
    END AS average_transaction_value
FROM stores s
LEFT JOIN transactions t
    ON s.store_id = t.store_id
    AND t.transaction_status = 'Completed'
GROUP BY
    s.store_id,
    s.store_name
ORDER BY average_transaction_value DESC;


-- ============================================================
-- SECTION 3: INVENTORY ANALYSIS
-- ============================================================

-- ============================================================
-- Q05. Which products are low in stock?
--
-- Business Rule:
-- Available Quantity <= Reorder Level
--
-- SQL Concepts:
-- JOIN, WHERE, CASE
-- ============================================================

SELECT
    i.inventory_id,
    p.product_id,
    p.product_name,
    s.store_name,
    i.available_quantity,
    i.reorder_level,
    CASE
        WHEN i.available_quantity = 0
            THEN 'Out of Stock'
        WHEN i.available_quantity <= i.reorder_level
            THEN 'Low Stock'
        ELSE 'Healthy Stock'
    END AS stock_status
FROM inventory i
JOIN products p
    ON i.product_id = p.product_id
JOIN stores s
    ON i.store_id = s.store_id
WHERE i.available_quantity <= i.reorder_level
ORDER BY i.available_quantity ASC;


-- ============================================================
-- Q06. Which stores have the most low-stock products?
--
-- Business Purpose:
-- Identify stores that may require inventory attention.
--
-- SQL Concepts:
-- JOIN, WHERE, GROUP BY, COUNT
-- ============================================================

SELECT
    s.store_id,
    s.store_name,
    COUNT(i.product_id) AS low_stock_products
FROM stores s
JOIN inventory i
    ON s.store_id = i.store_id
WHERE i.available_quantity <= i.reorder_level
GROUP BY
    s.store_id,
    s.store_name
ORDER BY low_stock_products DESC;


-- ============================================================
-- SECTION 4: RETURN ANALYSIS
-- ============================================================

-- ============================================================
-- Q07. Which products have the highest return rate?
--
-- Formula:
-- Returned Quantity / Sold Quantity * 100
--
-- SQL Concepts:
-- JOIN, GROUP BY, SUM, CASE
-- ============================================================

SELECT
    p.product_id,
    p.product_name,

    SUM(td.quantity) AS units_sold,

    COALESCE(SUM(r.return_quantity), 0) AS units_returned,

    CASE
        WHEN SUM(td.quantity) = 0 THEN 0
        ELSE
            (COALESCE(SUM(r.return_quantity), 0)::DECIMAL
             / SUM(td.quantity)) * 100
    END AS return_rate_percentage

FROM products p

JOIN transaction_details td
    ON p.product_id = td.product_id

JOIN transactions t
    ON td.transaction_id = t.transaction_id

LEFT JOIN returns r
    ON td.transaction_detail_id = r.transaction_detail_id

WHERE t.transaction_status = 'Completed'

GROUP BY
    p.product_id,
    p.product_name

HAVING SUM(td.quantity) > 0

ORDER BY return_rate_percentage DESC;


-- ============================================================
-- Q08. Which stores have the highest return rate?
--
-- SQL Concepts:
-- JOIN, GROUP BY, SUM, CASE
-- ============================================================

SELECT
    s.store_id,
    s.store_name,

    SUM(td.quantity) AS units_sold,

    COALESCE(SUM(r.return_quantity), 0) AS units_returned,

    CASE
        WHEN SUM(td.quantity) = 0 THEN 0
        ELSE
            (COALESCE(SUM(r.return_quantity), 0)::DECIMAL
             / SUM(td.quantity)) * 100
    END AS return_rate_percentage

FROM stores s

JOIN transactions t
    ON s.store_id = t.store_id

JOIN transaction_details td
    ON t.transaction_id = td.transaction_id

LEFT JOIN returns r
    ON td.transaction_detail_id = r.transaction_detail_id

WHERE t.transaction_status = 'Completed'

GROUP BY
    s.store_id,
    s.store_name

HAVING SUM(td.quantity) > 0

ORDER BY return_rate_percentage DESC;


-- ============================================================
-- SECTION 5: PAYMENT / RECONCILIATION
-- ============================================================

-- ============================================================
-- Q09. Which payment transactions have reconciliation issues?
--
-- Business Rule:
-- Payment Total should match Transaction Total.
--
-- SQL Concepts:
-- JOIN, GROUP BY, SUM, HAVING, CASE
-- ============================================================

SELECT
    t.transaction_id,
    t.total_amount,
    COALESCE(SUM(p.payment_amount), 0) AS payment_total,

    t.total_amount
        - COALESCE(SUM(p.payment_amount), 0)
        AS variance,

    CASE
        WHEN COALESCE(SUM(p.payment_amount), 0)
             = t.total_amount
            THEN 'Matched'
        ELSE 'Exception'
    END AS reconciliation_status

FROM transactions t

LEFT JOIN payments p
    ON t.transaction_id = p.transaction_id

GROUP BY
    t.transaction_id,
    t.total_amount

HAVING
    COALESCE(SUM(p.payment_amount), 0)
    <> t.total_amount

ORDER BY ABS(
    t.total_amount
    - COALESCE(SUM(p.payment_amount), 0)
) DESC;


-- ============================================================
-- Q10. Which stores have reconciliation variances?
--
-- SQL Concepts:
-- JOIN, GROUP BY, SUM, CASE
-- ============================================================

SELECT
    s.store_id,
    s.store_name,

    SUM(r.pos_total) AS total_pos_amount,

    SUM(r.payment_total) AS total_payment_amount,

    SUM(r.variance_amount) AS total_variance,

    CASE
        WHEN SUM(r.variance_amount) = 0
            THEN 'Matched'
        ELSE 'Exception'
    END AS reconciliation_status

FROM stores s

JOIN reconciliation r
    ON s.store_id = r.store_id

GROUP BY
    s.store_id,
    s.store_name

HAVING SUM(r.variance_amount) <> 0

ORDER BY ABS(SUM(r.variance_amount)) DESC;


-- ============================================================
-- SECTION 6: CUSTOMER ANALYSIS
-- ============================================================

-- ============================================================
-- Q11. Which customer segments generate the highest revenue?
--
-- SQL Concepts:
-- JOIN, GROUP BY, SUM
-- ============================================================

SELECT
    c.customer_segment,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(t.transaction_id) AS transaction_count,
    SUM(t.total_amount) AS total_revenue
FROM customers c
JOIN transactions t
    ON c.customer_id = t.customer_id
WHERE t.transaction_status = 'Completed'
GROUP BY
    c.customer_segment
ORDER BY total_revenue DESC;


-- ============================================================
-- SECTION 7: CHANNEL ANALYSIS
-- ============================================================

-- ============================================================
-- Q12. Which transaction channel generates the highest revenue?
--
-- SQL Concepts:
-- GROUP BY, SUM, COUNT
-- ============================================================

SELECT
    channel,
    COUNT(transaction_id) AS transaction_count,
    SUM(total_amount) AS total_revenue
FROM transactions
WHERE transaction_status = 'Completed'
GROUP BY channel
ORDER BY total_revenue DESC;


-- ============================================================
-- SECTION 8: CROSS-FUNCTIONAL ANALYSIS
-- ============================================================

-- ============================================================
-- Q13. Which products have high sales but low inventory?
--
-- Business Logic:
-- High sales = product sales above overall average
-- Low inventory = available quantity <= reorder level
--
-- SQL Concepts:
-- CTE, JOIN, GROUP BY, aggregation
-- ============================================================

WITH product_sales AS (

    SELECT
        p.product_id,
        p.product_name,
        SUM(td.quantity) AS units_sold
    FROM products p
    JOIN transaction_details td
        ON p.product_id = td.product_id
    JOIN transactions t
        ON td.transaction_id = t.transaction_id
    WHERE t.transaction_status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name

),

average_sales AS (

    SELECT
        AVG(units_sold) AS average_units_sold
    FROM product_sales

)

SELECT
    ps.product_id,
    ps.product_name,
    ps.units_sold,
    i.available_quantity,
    i.reorder_level
FROM product_sales ps
JOIN inventory i
    ON ps.product_id = i.product_id
CROSS JOIN average_sales a
WHERE ps.units_sold > a.average_units_sold
  AND i.available_quantity <= i.reorder_level
ORDER BY ps.units_sold DESC;


-- ============================================================
-- Q14. Which products have low sales but high inventory?
--
-- Business Logic:
-- Low sales = below average units sold
-- High inventory = available quantity > reorder level
--
-- SQL Concepts:
-- CTE, JOIN, subquery-style analysis, aggregation
-- ============================================================

WITH product_sales AS (

    SELECT
        p.product_id,
        p.product_name,
        SUM(td.quantity) AS units_sold
    FROM products p
    JOIN transaction_details td
        ON p.product_id = td.product_id
    JOIN transactions t
        ON td.transaction_id = t.transaction_id
    WHERE t.transaction_status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name

)

SELECT
    ps.product_id,
    ps.product_name,
    ps.units_sold,
    i.available_quantity,
    i.reorder_level
FROM product_sales ps
JOIN inventory i
    ON ps.product_id = i.product_id
WHERE ps.units_sold <
      (
          SELECT AVG(units_sold)
          FROM product_sales
      )
AND i.available_quantity > i.reorder_level
ORDER BY i.available_quantity DESC;


-- ============================================================
-- Q15. Which business areas require management attention?
--
-- This query creates a simple management-risk classification.
--
-- Risk Areas:
-- 1. High return rate
-- 2. Low stock
-- 3. Reconciliation variance
--
-- SQL Concepts:
-- CTEs, CASE, JOINs, aggregation, window function
-- ============================================================

WITH store_sales AS (

    SELECT
        s.store_id,
        s.store_name,
        SUM(t.total_amount) AS revenue
    FROM stores s
    JOIN transactions t
        ON s.store_id = t.store_id
    WHERE t.transaction_status = 'Completed'
    GROUP BY
        s.store_id,
        s.store_name

),

store_returns AS (

    SELECT
        s.store_id,

        SUM(td.quantity) AS units_sold,

        COALESCE(SUM(r.return_quantity), 0)
            AS units_returned

    FROM stores s

    JOIN transactions t
        ON s.store_id = t.store_id

    JOIN transaction_details td
        ON t.transaction_id = td.transaction_id

    LEFT JOIN returns r
        ON td.transaction_detail_id = r.transaction_detail_id

    WHERE t.transaction_status = 'Completed'

    GROUP BY
        s.store_id

),

store_inventory AS (

    SELECT
        store_id,

        COUNT(*) AS low_stock_count

    FROM inventory

    WHERE available_quantity <= reorder_level

    GROUP BY store_id

),

store_reconciliation AS (

    SELECT
        store_id,

        SUM(ABS(variance_amount))
            AS reconciliation_variance

    FROM reconciliation

    GROUP BY store_id

),

store_ranking AS (

    SELECT
        ss.store_id,
        ss.store_name,
        ss.revenue,

        ROW_NUMBER() OVER (
            ORDER BY ss.revenue DESC
        ) AS revenue_rank

    FROM store_sales ss

)

SELECT
    sr.store_id,
    sr.store_name,
    sr.revenue,
    sr.revenue_rank,

    COALESCE(si.low_stock_count, 0)
        AS low_stock_count,

    COALESCE(sc.reconciliation_variance, 0)
        AS reconciliation_variance,

    CASE
        WHEN COALESCE(sc.reconciliation_variance, 0) > 0
             AND COALESCE(si.low_stock_count, 0) > 0
            THEN 'High Attention'

        WHEN COALESCE(sc.reconciliation_variance, 0) > 0
            THEN 'Finance Attention'

        WHEN COALESCE(si.low_stock_count, 0) > 0
            THEN 'Inventory Attention'

        ELSE 'Normal'
    END AS management_attention

FROM store_ranking sr

LEFT JOIN store_inventory si
    ON sr.store_id = si.store_id

LEFT JOIN store_reconciliation sc
    ON sr.store_id = sc.store_id

LEFT JOIN store_returns sret
    ON sr.store_id = sret.store_id

ORDER BY
    CASE
        WHEN COALESCE(sc.reconciliation_variance, 0) > 0
             AND COALESCE(si.low_stock_count, 0) > 0
            THEN 1
        WHEN COALESCE(sc.reconciliation_variance, 0) > 0
            THEN 2
        WHEN COALESCE(si.low_stock_count, 0) > 0
            THEN 3
        ELSE 4
    END,
    sr.revenue DESC;


-- ============================================================
-- SECTION 9: ADDITIONAL SUPPORTING QUERIES
-- ============================================================

-- ============================================================
-- SUPPORT Q01
-- Overall UrbanMart Revenue
-- ============================================================

SELECT
    SUM(total_amount) AS total_revenue
FROM transactions
WHERE transaction_status = 'Completed';


-- ============================================================
-- SUPPORT Q02
-- Total Transaction Count
-- ============================================================

SELECT
    COUNT(transaction_id) AS total_transactions
FROM transactions
WHERE transaction_status = 'Completed';


-- ============================================================
-- SUPPORT Q03
-- Average Transaction Value
-- ============================================================

SELECT
    AVG(total_amount) AS average_transaction_value
FROM transactions
WHERE transaction_status = 'Completed';


-- ============================================================
-- SUPPORT Q04
-- Total Units Sold
-- ============================================================

SELECT
    SUM(td.quantity) AS total_units_sold
FROM transaction_details td
JOIN transactions t
    ON td.transaction_id = t.transaction_id
WHERE t.transaction_status = 'Completed';


-- ============================================================
-- SUPPORT Q05
-- Overall Return Rate
-- ============================================================

SELECT

    CASE
        WHEN SUM(td.quantity) = 0 THEN 0
        ELSE
            (
                COALESCE(SUM(r.return_quantity), 0)::DECIMAL
                / SUM(td.quantity)
            ) * 100
    END AS overall_return_rate

FROM transaction_details td

JOIN transactions t
    ON td.transaction_id = t.transaction_id

LEFT JOIN returns r
    ON td.transaction_detail_id = r.transaction_detail_id

WHERE t.transaction_status = 'Completed';


-- ============================================================
-- SUPPORT Q06
-- Total Low Stock Products
-- ============================================================

SELECT
    COUNT(*) AS low_stock_records
FROM inventory
WHERE available_quantity <= reorder_level;


-- ============================================================
-- SUPPORT Q07
-- Total Reconciliation Variance
-- ============================================================

SELECT
    SUM(variance_amount) AS total_reconciliation_variance
FROM reconciliation;


-- ============================================================
-- SUPPORT Q08
-- Revenue Ranking by Store
--
-- SQL Concept:
-- Window Function
-- ============================================================

SELECT
    s.store_id,
    s.store_name,
    SUM(t.total_amount) AS total_revenue,

    RANK() OVER (
        ORDER BY SUM(t.total_amount) DESC
    ) AS revenue_rank

FROM stores s

JOIN transactions t
    ON s.store_id = t.store_id

WHERE t.transaction_status = 'Completed'

GROUP BY
    s.store_id,
    s.store_name

ORDER BY revenue_rank;


-- ============================================================
-- SUPPORT Q09
-- Revenue Contribution by Store
--
-- SQL Concepts:
-- CTE, Window Function
-- ============================================================

WITH store_revenue AS (

    SELECT
        s.store_id,
        s.store_name,
        SUM(t.total_amount) AS revenue

    FROM stores s

    JOIN transactions t
        ON s.store_id = t.store_id

    WHERE t.transaction_status = 'Completed'

    GROUP BY
        s.store_id,
        s.store_name
)

SELECT
    store_id,
    store_name,
    revenue,

    ROUND(
        revenue
        / SUM(revenue) OVER () * 100,
        2
    ) AS revenue_percentage

FROM store_revenue

ORDER BY revenue DESC;


-- ============================================================
-- SUPPORT Q10
-- Store Performance Classification
--
-- SQL Concepts:
-- CTE, CASE, Window Function
-- ============================================================

WITH store_revenue AS (

    SELECT
        s.store_id,
        s.store_name,
        SUM(t.total_amount) AS revenue

    FROM stores s

    JOIN transactions t
        ON s.store_id = t.store_id

    WHERE t.transaction_status = 'Completed'

    GROUP BY
        s.store_id,
        s.store_name
),

ranked_stores AS (

    SELECT
        *,
        RANK() OVER (
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM store_revenue
)

SELECT
    store_id,
    store_name,
    revenue,
    revenue_rank,

    CASE
        WHEN revenue_rank = 1
            THEN 'Top Performer'

        WHEN revenue_rank <= 3
            THEN 'Strong Performer'

        ELSE 'Standard Performer'
    END AS performance_category

FROM ranked_stores

ORDER BY revenue_rank;


-- ============================================================
-- END OF FILE
-- ============================================================
