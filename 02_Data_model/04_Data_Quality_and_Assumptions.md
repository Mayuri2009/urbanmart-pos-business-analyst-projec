# UrbanMart POS — Data Quality and Assumptions

[04_Data_Quality_and_Assumptions.docx](https://github.com/user-attachments/files/31514246/04_Data_Quality_and_Assumptions.docx)

<img width="1024" height="1536" alt="04_Data_Quality_and_Assumptions" src="https://github.com/user-attachments/assets/e9b4ae24-7c25-463b-bead-26ce3ea309e6" />

## 1. Purpose

This document defines the data quality rules, business rules, assumptions, and constraints applied to the UrbanMart POS data model.

The objective is to ensure that the data is accurate, consistent, reliable, traceable, and suitable for:

- SQL analysis
- Business reporting
- UAT
- Requirements traceability
- Business decision-making

---

# 2. Data Quality Objectives

UrbanMart aims to maintain high-quality data across its operational and analytical processes.

Data should be:

| Quality Dimension | Objective |
|---|---|
| Accuracy | Data should correctly represent the business event |
| Completeness | Required information should be captured |
| Consistency | Values should follow common formats and rules |
| Validity | Values should follow defined business rules |
| Uniqueness | Duplicate records should be prevented where required |
| Integrity | Relationships between tables should remain valid |
| Timeliness | Data should be available within the required reporting period |
| Traceability | Data should be traceable from source through analysis |

---

# 3. Data Quality Rules

## 3.1 Validity

- Status fields must contain only approved values.
- Dates must be valid calendar dates.
- Numeric fields must contain valid numeric values.
- Monetary fields must use valid decimal values.
- Foreign keys must reference valid parent records.

## 3.2 Completeness

- Mandatory fields should not be null.
- Primary keys must always be populated.
- Required business information should be captured.
- Critical reporting fields should not contain unexpected missing values.

## 3.3 Uniqueness

- Primary keys must be unique.
- Product codes should be unique where required.
- Other business identifiers should not contain unintended duplicates.

## 3.4 Consistency

- Table and column naming should follow consistent conventions.
- Status values should be standardized.
- Currency should consistently use USD.
- Date formats should follow the defined project standard.
- Business terminology should remain consistent across tables.

## 3.5 Referential Integrity

- Every transaction must reference a valid store.
- Transaction details must reference valid transactions.
- Transaction details must reference valid products.
- Payments must reference valid transactions.
- Returns must reference valid transactions and products.
- Inventory must reference valid stores and products.
- Loyalty transactions must reference valid customers.
- Reconciliation records must reference valid stores.

---

# 4. Business Rules

## 4.1 Sales

Only completed transactions should be treated as completed sales.

```text
transaction_status = 'Completed'
