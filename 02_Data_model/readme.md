# UrbanMart POS — Data Model

## Overview

The Data Model defines the structure, relationships, data-quality rules, and business assumptions required to support the UrbanMart POS solution.

The model was designed from a **Business Analyst perspective**, starting with business requirements and business questions and translating them into structured relational data.

The database implementation is planned in **PostgreSQL**.

---

## Data Model Objective

The primary objective is to create a reliable relational data foundation that supports:

- Business analysis
- SQL analysis
- Data validation
- UAT
- Requirements traceability
- Business reporting
- Future Power BI analysis

The model is designed around the **business processes and questions**, rather than simply creating tables from the raw dataset.

---

## Core Business Entities

The UrbanMart POS data model contains 12 core entities:

| # | Entity | Purpose |
|---|---|---|
| 1 | CUSTOMERS | Customer master information |
| 2 | STORES | Store master information |
| 3 | PRODUCT_CATEGORIES | Product category information |
| 4 | PRODUCTS | Product master information |
| 5 | TRANSACTIONS | Sales transaction header |
| 6 | TRANSACTION_DETAILS | Products within transactions |
| 7 | PAYMENTS | Payment information |
| 8 | RETURNS | Product returns and refunds |
| 9 | INVENTORY | Store-product inventory |
| 10 | LOYALTY_TRANSACTIONS | Loyalty points activity |
| 11 | PROMOTIONS | Promotion information |
| 12 | RECONCILIATION | POS/payment reconciliation |

---

## Data Model Structure

The high-level relationship is:

```text
CUSTOMERS
    ↓
TRANSACTIONS
    ↓
TRANSACTION_DETAILS
    ↓
PRODUCTS
    ↓
PRODUCT_CATEGORIES
