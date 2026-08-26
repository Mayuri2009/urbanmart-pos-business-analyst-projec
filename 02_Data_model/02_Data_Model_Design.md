# UrbanMart POS — Data Model Design

[02_Data_Model_Design.docx](https://github.com/user-attachments/files/31488579/02_Data_Model_Design.docx)

## 1. Purpose

The purpose of this document is to define the logical and relational design of the UrbanMart POS data model.

The design translates the business requirements and business processes into structured data entities, attributes, keys, and relationships.

The model is designed to support:

- PostgreSQL implementation
- SQL analysis
- UAT validation
- Business reporting
- Requirements traceability
- Future Power BI reporting

---

# 2. Data Model Design Approach

The UrbanMart data model follows a relational database approach.

The design process is:

```text
Business Requirements
        ↓
Business Processes
        ↓
Business Entities
        ↓
Attributes
        ↓
Primary Keys
        ↓
Foreign Keys
        ↓
Relationships
        ↓
Relational Database
