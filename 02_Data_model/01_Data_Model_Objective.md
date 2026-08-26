# UrbanMart POS — Data Model Objective

[01_Data_Model_Objective.docx](https://github.com/user-attachments/files/31488219/01_Data_Model_Objective.docx)

## 1. Purpose

The purpose of the UrbanMart POS data model is to define a structured and business-oriented representation of the data required to support UrbanMart's retail Point-of-Sale operations.

The data model provides the foundation for:

- PostgreSQL database implementation
- SQL analysis
- Business reporting
- UAT validation
- Requirements traceability
- Future Power BI reporting

The model is designed around **business processes and business questions**, rather than simply creating tables based on available data.

---

## 2. Business Objective

The data model should enable UrbanMart to understand and analyze:

- Sales performance
- Store performance
- Product performance
- Customer behavior
- Returns and refunds
- Inventory availability
- Payment activity
- Loyalty activity
- Promotions
- Financial reconciliation

---

## 3. Key Business Questions

The model should allow UrbanMart to answer questions such as:

- How much did each store sell?
- Which stores generate the most revenue?
- Which products and categories perform best?
- Which customers generate the most revenue?
- What percentage of customers are inactive?
- What is the return rate?
- Which products have high return activity?
- Which stores have inventory risks?
- Which products are low in stock or out of stock?
- Which payments are incomplete?
- Which payment methods are most frequently used?
- How many loyalty points are earned and redeemed?
- Which customer segments generate the most revenue?
- Which stores have reconciliation exceptions?
- What is the variance between POS totals and payment totals?

---

## 4. Data Model Scope

The UrbanMart relational model contains 12 primary business entities:

```text
CUSTOMERS
STORES
PRODUCT_CATEGORIES
PRODUCTS
TRANSACTIONS
TRANSACTION_DETAILS
PAYMENTS
RETURNS
INVENTORY
LOYALTY_TRANSACTIONS
PROMOTIONS
RECONCILIATION
