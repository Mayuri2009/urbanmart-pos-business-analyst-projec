# UrbanMart POS — Data Model & Data Dictionary Overview

## 1. Data Model Overview

The UrbanMart POS analytical solution uses a relational data model designed around the business requirements and operational processes identified during the Business Analysis phase.

The data model supports analysis of:

- Customers
- Stores
- Product Categories
- Products
- Sales Transactions
- Transaction Details
- Payments
- Returns
- Inventory
- Loyalty Transactions
- Promotions
- Reconciliation

The model is designed to support PostgreSQL SQL analysis and Power BI reporting.

The primary analytical reporting period is:

**January 2025 – December 2025**

Store opening dates use a separate historical period:

**February 2022 – March 2025**

---

# 2. Data Modeling Approach

The UrbanMart data model follows a relational modeling approach.

The design principles are:

- Master data is stored separately from transactional data.
- Transaction headers and transaction details are separated.
- Primary keys uniquely identify records.
- Foreign keys establish relationships between entities.
- Repeated information is minimized.
- Business processes are represented through appropriate entities.
- The model supports SQL analysis and Power BI reporting.
- The model is designed around business questions rather than randomly creating tables.

The overall approach is:

```text
Business Requirements
        ↓
Business Processes
        ↓
Business Questions
        ↓
Data Entities
        ↓
Relationships
        ↓
PostgreSQL
        ↓
SQL Analysis
        ↓
Power BI
