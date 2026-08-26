# UrbanMart POS — To-Be Process

## Process 1 — Customer & Loyalty Management

The future-state process will provide a structured view of customer and loyalty activity.

Customer information will be connected with transaction and loyalty data through the relational data model.

### Future-State Flow

Customer
↓
Customer Identification
↓
Customer Segment
↓
Transaction
↓
Loyalty Activity
↓
Points Earned / Redeemed / Reversed
↓
Customer & Loyalty Analysis
↓
Business Action

### Key Improvements

- Identify active and inactive customers.
- Analyze customers by segment.
- Track loyalty points activity.
- Connect customer activity with transactions.
- Identify customer engagement patterns.
- Support targeted marketing and CRM decisions.

---

## Process 2 — Product & Sales Management

The future-state process will provide a centralized view of product and sales performance.

Transaction headers and transaction details will be connected with stores, products, categories, customers, and dates.

### Future-State Flow

Product Selection
↓
POS Transaction
↓
Transaction Details
↓
Product / Category Mapping
↓
Sales Calculation
↓
Store / Product / Channel Analysis
↓
Power BI Reporting
↓
Management Decision

### Key Improvements

- Analyze total sales.
- Analyze transaction volume.
- Identify top-performing products.
- Compare product categories.
- Analyze sales by store.
- Analyze sales by channel.
- Identify underperforming products.

---

## Process 3 — Payment Processing & Exception Management

The future-state process will provide structured monitoring of payment transactions and payment exceptions.

Payment records will be connected with their corresponding transactions.

### Future-State Flow

Transaction
↓
Payment Processing
↓
Payment Record
↓
Payment Status Validation
↓
Completed / Incomplete
↓
Payment Exception Analysis
↓
Finance Investigation
↓
Resolution

### Key Improvements

- Identify incomplete payments.
- Analyze payment methods.
- Compare payment amounts with transaction amounts.
- Identify payment exceptions by store.
- Support Finance investigation.
- Improve payment visibility.

---

## Process 4 — Inventory Management

The future-state inventory process will provide centralized monitoring of stock availability.

Inventory records will be analyzed by store and product.

### Future-State Flow

Inventory Data
↓
Available Quantity
↓
Reserved Quantity
↓
Reorder Level Comparison
↓
Inventory Classification
↓
In Stock / Low Stock / Out of Stock
↓
Power BI Exception Reporting
↓
Inventory Action

### Key Improvements

- Identify low-stock products.
- Identify out-of-stock products.
- Compare inventory across stores.
- Monitor reorder levels.
- Identify inventory risks.
- Support replenishment decisions.

---

## Process 5 — Returns Management

The future-state return process will provide structured analysis of product returns and approval outcomes.

Return records will be connected with the original transactions and transaction details.

### Future-State Flow

Customer Return Request
↓
Original Transaction Identification
↓
Product / Quantity Validation
↓
Return Record
↓
Return Approval
↓
Approved / Rejected
↓
Refund Analysis
↓
Return Trend Analysis
↓
Business Action

### Key Improvements

- Calculate return rate.
- Analyze return reasons.
- Identify frequently returned products.
- Compare approved and rejected returns.
- Analyze refund amounts.
- Identify store-level return patterns.
- Support operational improvements.

---

## Process 6 — Promotions Management

The future-state process will connect promotion information with sales and product analysis where applicable.

Promotion information will provide a structured view of promotional activity.

### Future-State Flow

Promotion Created
↓
Promotion Type / Discount Defined
↓
Promotion Active Period
↓
Customer / Product Activity
↓
Sales Analysis
↓
Promotion Performance Analysis
↓
Business Review
↓
Future Promotion Planning

### Key Improvements

- Track active and expired promotions.
- Analyze promotion types.
- Analyze discount levels.
- Compare promotional sales activity.
- Identify opportunities for better promotional planning.
- Support Marketing decisions.

---

## Process 7 — Payment Reconciliation

The future-state reconciliation process will provide a structured approach for comparing POS transaction totals against completed payment totals.

### Future-State Flow

Completed POS Transactions
↓
POS Transaction Count & Total
↓
Completed Payment Records
↓
Payment Count & Total
↓
POS vs Payment Comparison
↓
Variance Calculation
↓
Reconciled / Exception
↓
Finance Investigation
↓
Resolution

### Key Improvements

- Identify reconciliation variances.
- Identify stores with exceptions.
- Monitor payment differences.
- Separate completed and incomplete payments.
- Track exception reasons.
- Track resolution ownership.
- Support Finance control activities.

---

## Process 8 — Management Reporting & Decision-Making

The future-state reporting process will convert validated operational data into business insights.

### Future-State Flow

Operational Data
↓
Data Validation
↓
PostgreSQL Database
↓
SQL Business Analysis
↓
Validated KPIs
↓
Power BI Dashboard
↓
Stakeholder Review
↓
Business Insights
↓
Management Decision

### Key Improvements

Management will have a consolidated view of:

- Sales performance
- Store performance
- Product performance
- Inventory risks
- Customer activity
- Loyalty performance
- Return trends
- Payment exceptions
- Reconciliation variances
- Promotion activity

---

# To-Be Process Summary

| Process # | To-Be Process | Primary Business Area |
|---|---|---|
| 1 | Customer & Loyalty Management | Customer / CRM |
| 2 | Product & Sales Management | Sales / Product |
| 3 | Payment Processing & Exception Management | Finance |
| 4 | Inventory Management | Inventory |
| 5 | Returns Management | Operations |
| 6 | Promotions Management | Marketing |
| 7 | Payment Reconciliation | Finance |
| 8 | Management Reporting & Decision-Making | Management |

---

# Overall To-Be Flow

```text
1. Customer & Loyalty Management
              ↓
2. Product & Sales Management
              ↓
3. Payment Processing & Exception Management
              ↓
4. Inventory Management
              ↓
5. Returns Management
              ↓
6. Promotions Management
              ↓
7. Payment Reconciliation
              ↓
8. Management Reporting & Decision-Making
