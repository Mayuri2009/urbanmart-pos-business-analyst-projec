# UrbanMart POS — Entity Relationships

[03_Entity_Relationships.docx](https://github.com/user-attachments/files/31512092/03_Entity_Relationships.docx)

## 1. Purpose

This document defines the relationships between the 12 core UrbanMart POS entities.

It explains:

- How the entities connect
- Primary and foreign key relationships
- Relationship cardinality
- Why each relationship exists
- How relationships support business processes
- How relationships support SQL analysis and reporting

---

# 2. Core Relationship Model

The high-level relationship structure is:

CUSTOMERS → TRANSACTIONS → TRANSACTION_DETAILS → PRODUCTS → PRODUCT_CATEGORIES

STORES → TRANSACTIONS → PAYMENTS

TRANSACTIONS → RETURNS

STORES ↔ INVENTORY ↔ PRODUCTS

CUSTOMERS → LOYALTY_TRANSACTIONS

STORES → RECONCILIATION

---

# 3. Relationship Summary

| Parent Entity | Child Entity | Relationship |
|---|---|---|
| CUSTOMERS | TRANSACTIONS | One-to-Many |
| STORES | TRANSACTIONS | One-to-Many |
| TRANSACTIONS | TRANSACTION_DETAILS | One-to-Many |
| PRODUCTS | TRANSACTION_DETAILS | One-to-Many |
| PRODUCT_CATEGORIES | PRODUCTS | One-to-Many |
| TRANSACTIONS | PAYMENTS | One-to-Many |
| TRANSACTIONS | RETURNS | One-to-Many |
| TRANSACTION_DETAILS | RETURNS | One-to-Many |
| PRODUCTS | RETURNS | One-to-Many |
| STORES | INVENTORY | One-to-Many |
| PRODUCTS | INVENTORY | One-to-Many |
| CUSTOMERS | LOYALTY_TRANSACTIONS | One-to-Many |
| TRANSACTIONS | LOYALTY_TRANSACTIONS | One-to-Many |
| STORES | RECONCILIATION | One-to-Many |

---

# 4. CUSTOMERS → TRANSACTIONS

### Relationship

```text
CUSTOMERS 1 ───────────< TRANSACTIONS
