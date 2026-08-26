# UrbanMart POS — Business Requirements Document

## 1. Document Information

| Item | Details |
|---|---|
| Project | UrbanMart POS Analytical Solution |
| Business Domain | Retail |
| Country | United States |
| Role | Business Analyst |
| Reporting Period | January 2025 – December 2025 |
| Dataset Type | Synthetic |
| Database | PostgreSQL |
| Reporting Tool | Power BI |

---

# 2. Business Objective

The objective is to provide UrbanMart management with a structured analytical solution for monitoring sales, stores, products, inventory, customers, loyalty, returns, payments, promotions, and reconciliation.

---

# 3. Business Requirements

| ID | Business Requirement |
|---|---|
| BR-001 | The solution shall provide visibility into total sales performance. |
| BR-002 | The solution shall allow management to compare store performance. |
| BR-003 | The solution shall identify high-performing products and categories. |
| BR-004 | The solution shall provide inventory availability information. |
| BR-005 | The solution shall identify low-stock and out-of-stock products. |
| BR-006 | The solution shall provide customer segmentation information. |
| BR-007 | The solution shall provide loyalty activity analysis. |
| BR-008 | The solution shall provide return analysis. |
| BR-009 | The solution shall identify rejected returns. |
| BR-010 | The solution shall identify incomplete transactions. |
| BR-011 | The solution shall identify incomplete payments. |
| BR-012 | The solution shall support payment reconciliation analysis. |
| BR-013 | The solution shall provide channel performance analysis. |
| BR-014 | The solution shall support management decision-making through dashboards. |

---

# 4. Functional Requirements

## FR-001 — Sales Analysis

The system shall calculate total sales using completed transactions.

## FR-002 — Store Analysis

The system shall allow users to compare sales performance by store.

## FR-003 — Product Analysis

The system shall provide product and category-level sales analysis.

## FR-004 — Inventory Analysis

The system shall identify products based on available quantity and reorder level.

## FR-005 — Customer Analysis

The system shall provide customer segment and activity analysis.

## FR-006 — Loyalty Analysis

The system shall analyze loyalty points earned, redeemed, and reversed.

## FR-007 — Return Analysis

The system shall classify returns according to approval status and return reason.

## FR-008 — Transaction Exception Analysis

The system shall identify incomplete transactions.

## FR-009 — Payment Exception Analysis

The system shall identify incomplete payments.

## FR-010 — Reconciliation Analysis

The system shall compare POS totals with payment totals and identify variances.

## FR-011 — Channel Analysis

The system shall compare Store, Web, and Mobile sales performance.

## FR-012 — Dashboard Reporting

The system shall present key business metrics through Power BI.

---

# 5. Non-Functional Requirements

| ID | Requirement |
|---|---|
| NFR-001 | Reports should be understandable to business users. |
| NFR-002 | KPI definitions should be consistent across reports. |
| NFR-003 | Data should be validated before reporting. |
| NFR-004 | The data model should support relational analysis. |
| NFR-005 | Sensitive real customer information shall not be used. |
| NFR-006 | SQL queries should be maintainable and understandable. |
| NFR-007 | Dashboard information should support management decision-making. |

---

# 6. KPI Requirements

The analytical solution should provide metrics including:

- Total Sales
- Total Transactions
- Average Transaction Value
- Units Sold
- Store Sales
- Product Sales
- Return Rate
- Rejected Return Rate
- Inventory Risk
- Out-of-Stock Count
- Incomplete Transaction Count
- Incomplete Payment Count
- Reconciliation Variance
- Loyalty Points Earned
- Loyalty Points Redeemed

---

# 7. Business Rules

### BRULE-001

Only completed transactions should be included in completed sales reporting.

### BRULE-002

Incomplete transactions should be treated as transaction exceptions.

### BRULE-003

Incomplete payments should not be treated as successfully settled payments.

### BRULE-004

Rejected returns should not generate successful refund amounts.

### BRULE-005

Inventory should be considered low stock when available quantity is at or below the reorder level.

### BRULE-006

Out-of-stock inventory should have zero available quantity.

### BRULE-007

POS totals and completed payment totals should be compared during reconciliation.

### BRULE-008

Inactive customers should not generate new loyalty activity in the analytical dataset.

---

# 8. Assumptions

- UrbanMart is a fictional U.S.-based retailer.
- All customer and transaction data is synthetic.
- Monetary values are represented in U.S. dollars.
- Store locations use U.S. cities and states.
- The reporting period is January 2025 through December 2025.
- Store opening dates range from February 2022 through March 2025.
- PostgreSQL is used for relational data analysis.
- Power BI is used for dashboard reporting.

---

# 9. Constraints

- The dataset is synthetic.
- No live POS system is connected.
- No real payment gateway is connected.
- No real-time inventory integration exists.
- The project represents a portfolio demonstration rather than a production deployment.

---

# 10. Acceptance Criteria

The project will be considered acceptable when:

1. Required tables are available.
2. Data relationships are valid.
3. Required business questions can be answered.
4. SQL queries execute successfully.
5. Dashboard KPIs reconcile with SQL results.
6. Exception scenarios are correctly identified.
7. UAT test cases pass.
8. Requirements can be traced through the RTM.

---

# 11. Traceability

Business requirements will be linked to:

Business Requirement
→ Functional Requirement
→ User Story
→ Use Case
→ SQL Analysis
→ Power BI
→ UAT

This traceability will be documented in the Requirement Traceability Matrix.
