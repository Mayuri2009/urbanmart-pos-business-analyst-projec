# UrbanMart POS — PostgreSQL Data Loading

## 1. Purpose

The purpose of this document is to define the process for loading the UrbanMart POS synthetic dataset into the PostgreSQL database.

The data-loading process ensures that:

- Source data is loaded into the correct tables.
- Parent tables are loaded before child tables.
- Primary and foreign-key relationships remain valid.
- Data types are compatible with PostgreSQL.
- Required fields are populated.
- Loaded data can be validated before SQL analysis begins.

---

# 2. Data Loading Flow

```text
Raw / Excel Data
       ↓
Review Source Data
       ↓
Map Source Columns
       ↓
Check Data Types
       ↓
Prepare CSV / Import Files
       ↓
Load Master Tables
       ↓
Load Transaction Tables
       ↓
Load Operational Tables
       ↓
Validate Loaded Data
       ↓
Ready for SQL Analysis
