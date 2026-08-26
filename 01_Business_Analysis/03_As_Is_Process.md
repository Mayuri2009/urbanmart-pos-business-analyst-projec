# UrbanMart POS — As-Is Process

## Process 1 — Customer Identification

The process begins when a customer makes a purchase through an UrbanMart store or digital sales channel.

The customer may be identified as an existing customer, loyalty customer, or guest customer.

Customer information may include:

- Customer ID
- Name
- Email
- Phone
- Loyalty ID
- Customer segment
- Customer status

### Current Challenge

Customer information may not be available for every transaction, which limits customer-level analysis and loyalty tracking.

---

## Process 2 — Product Selection

The customer selects one or more products for purchase.

The POS identifies each product using its product code/SKU and retrieves the corresponding product information.

Product information includes:

- Product ID
- Product code
- Product name
- Category
- Brand
- Unit price
- Tax rate
- Cost price
- Product status

### Current Challenge

Product and transaction information are maintained separately, requiring data relationships to analyze product performance.

---

## Process 3 — POS Transaction Creation

After the customer selects products, the POS creates a transaction.

The transaction captures:

- Transaction ID
- Store
- Customer
- Transaction date
- Sales channel
- Cashier
- Subtotal
- Discount
- Tax
- Total amount
- Transaction status

Individual products within the transaction are captured separately as transaction details.

### Current Challenge

Incomplete transactions may occur and require separate investigation and exception reporting.

---

## Process 4 — Payment Processing

After the transaction is created, the customer makes payment using an available payment method.

UrbanMart supports payment methods such as:

- Credit Card
- Debit Card
- Cash
- Mobile Wallet

Payment information includes:

- Payment ID
- Transaction ID
- Payment date
- Payment method
- Payment amount
- Payment status
- Gateway reference
- Authorization code

### Current Challenge

Incomplete payments can create payment exceptions and may result in reconciliation differences that require Finance team investigation.

---

## Process 5 — Inventory Management

When products are sold, inventory information needs to reflect product availability at the relevant store.

Inventory information includes:

- Store
- Product
- Available quantity
- Reserved quantity
- Reorder level
- Last updated date
- Inventory status

Inventory may be classified as:

- In Stock
- Low Stock
- Out of Stock

### Current Challenge

Without centralized monitoring, inventory teams may have difficulty identifying products that require replenishment or stores experiencing stock shortages.

---

## Process 6 — Customer & Loyalty Management

When an eligible customer completes a transaction, loyalty activity may be generated.

Loyalty activity can include:

- Points earned
- Points redeemed
- Points reversed

Customer and loyalty information can be used to understand customer engagement and loyalty behavior.

### Current Challenge

Without consolidated analysis, it can be difficult to identify:

- Active customers
- Inactive customers
- Customer segments
- Loyalty engagement
- Points activity

---

## Process 7 — Promotions Management

UrbanMart runs promotional campaigns to encourage sales and customer engagement.

Promotion information includes:

- Promotion ID
- Promotion name
- Promotion type
- Discount percentage
- Start date
- End date
- Minimum quantity
- Promotion status

Promotions may include percentage discounts, quantity-based discounts, and loyalty discounts.

### Current Challenge

The business may need additional analysis to understand promotion performance and its relationship with sales, products, and customer activity.

---

## Process 8 — Product Returns

Customers may return products after completing a purchase.

The return process identifies the original transaction and the product being returned.

Return information includes:

- Return ID
- Transaction ID
- Transaction detail ID
- Product ID
- Return date
- Return quantity
- Return reason
- Refund amount
- Return channel
- Approval status

Returns can be approved or rejected.

### Current Challenge

Management needs visibility into return volume, return reasons, frequently returned products, rejected returns, and refund amounts.

---

## Process 9 — Payment Reconciliation

The Finance team compares POS transaction totals with payment totals to identify discrepancies.

The reconciliation process includes:

1. Reviewing POS transactions.
2. Calculating POS transaction count and total.
3. Reviewing payment records.
4. Calculating payment totals.
5. Comparing POS and payment values.
6. Calculating variance.
7. Identifying reconciliation exceptions.
8. Investigating the exception.
9. Resolving the issue.

Reconciliation information includes:

- Reconciliation ID
- Store
- Reconciliation date
- POS transaction count
- POS total
- Payment total
- Variance amount
- Reconciliation status
- Exception reason
- Resolved by
- Resolved date

### Current Challenge

Payment variances and incomplete payments may require manual investigation, increasing Finance team effort.

---

## Process 10 — Management Reporting & Decision-Making

Operational information from sales, products, stores, customers, inventory, payments, returns, loyalty, promotions, and reconciliation is used for management reporting.

The current reporting flow is:

```text
Operational Data
       ↓
Multiple Business Tables
       ↓
Data Extraction
       ↓
Manual / Ad-Hoc Analysis
       ↓
Individual Reports
       ↓
Management Review
       ↓
Business Decision

## Current Challenge

Management does not have a single consolidated analytical view across all major business processes.
