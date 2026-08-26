# UrbanMart POS — Business Problem

## 1. Business Background

UrbanMart is a fictional U.S.-based retail company operating multiple physical stores and digital sales channels.

The company processes customer transactions through its Point-of-Sale (POS) environment and maintains operational data related to sales, products, customers, inventory, payments, returns, promotions, loyalty, and reconciliation.

As the business grows, management requires a structured way to analyze operational performance and identify exceptions that may affect revenue, customer experience, inventory availability, and financial reconciliation.

---

## 2. Current Business Problem

UrbanMart's operational data contains information across multiple business processes, but management does not have a centralized analytical view of the business.

This makes it difficult to quickly answer important business questions such as:

- Which stores generate the highest revenue?
- Which stores are underperforming?
- Which products contribute the most revenue?
- Which products have inventory shortages?
- Which customers are actively participating in the loyalty program?
- What are the major reasons for product returns?
- How many returns are rejected?
- How many transactions are incomplete?
- How many payments are incomplete?
- Which stores have payment reconciliation exceptions?
- Which sales channel performs best?

Without a structured analytical solution, management may spend significant time manually reviewing operational data and may not identify important business exceptions quickly.

---

## 3. Business Impact

The current challenges can result in:

- Delayed management reporting
- Limited visibility into store performance
- Difficulty identifying inventory risks
- Delayed identification of payment exceptions
- Limited visibility into customer behavior
- Difficulty monitoring return trends
- Manual reconciliation effort
- Inconsistent decision-making
- Reduced ability to identify operational improvement opportunities

---

## 4. Business Need

UrbanMart requires an analytical solution that can consolidate POS-related operational data and provide management with reliable, understandable, and actionable information.

The proposed solution should enable users to:

1. Analyze sales performance.
2. Compare store performance.
3. Analyze product and category performance.
4. Monitor inventory availability.
5. Analyze customer and loyalty activity.
6. Monitor return trends.
7. Identify incomplete transactions.
8. Identify incomplete payments.
9. Monitor reconciliation exceptions.
10. Analyze sales channels.
11. Support data-driven business decisions.

---

## 5. Project Objective

The objective of this project is to design and demonstrate an end-to-end analytical solution for UrbanMart's POS environment.

The solution will cover:

- Business requirements analysis
- Stakeholder analysis
- Process analysis
- Data modeling
- Data dictionary
- PostgreSQL database implementation
- SQL analysis
- Power BI reporting
- User Acceptance Testing
- Requirement Traceability
- Business insights and recommendations

---

## 6. Reporting Period

The analytical dataset covers:

**January 2025 – December 2025**

Store opening dates are maintained separately and cover:

**February 2022 – March 2025**

---

## 7. Success Criteria

The project will be considered successful when:

- Business requirements are clearly documented.
- The data model supports the identified business questions.
- The dataset contains the required business entities and relationships.
- PostgreSQL successfully stores and analyzes the data.
- SQL queries answer key business questions.
- Power BI provides management-level reporting.
- Data quality and exception scenarios are validated.
- UAT confirms that key requirements are satisfied.
- Requirements can be traced from business need through implementation and testing.
- Final insights provide actionable recommendations.

---

## 8. Project Scope

### In Scope

- POS sales transactions
- Transaction details
- Stores
- Products
- Product categories
- Customers
- Payments
- Returns
- Inventory
- Loyalty transactions
- Promotions
- Reconciliation
- SQL analysis
- Power BI reporting
- UAT
- RTM
- Business insights

### Out of Scope

- Live POS integration
- Real payment processing
- Real customer information
- Production deployment
- Real-time inventory synchronization
- Actual financial settlement processing
- Integration with external banking systems

---

## 9. Business Analyst Perspective

The project follows a business-first approach.

The data model and analytical solution are designed around business questions and operational processes rather than creating tables or reports without a defined business purpose.

The overall approach is:

Business Problem → Requirements → Processes → Data Model → SQL → Reporting → Testing → Insights
