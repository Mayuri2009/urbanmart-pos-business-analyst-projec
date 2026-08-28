# UrbanMart POS — PostgreSQL

## 1. Overview

This folder contains the PostgreSQL database implementation for the UrbanMart POS Business Analyst portfolio project.

The database provides the structured data layer required to support:

- POS transaction management
- Sales analysis
- Inventory analysis
- Payment tracking
- Returns analysis
- Customer and loyalty analysis
- Promotion analysis
- Reconciliation
- Data-quality validation
- Future reporting and dashboard development

The dataset used in this project is synthetic and created for portfolio demonstration purposes.

---

# 2. PostgreSQL Role in the Project

PostgreSQL is used as the relational database layer between the source data and downstream analysis/reporting.

```text
Business Requirements
        ↓
Data Model
        ↓
Data Dictionary
        ↓
PostgreSQL
        ↓
Data Validation
        ↓
SQL Analysis
        ↓
Reporting / Power BI
        ↓
UAT
        ↓
RTM
