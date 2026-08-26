# UrbanMart POS — Use Cases

## UC-001 — Analyze Store Sales

### Actor
Store Manager / Regional Manager

### Objective
Analyze store sales performance.

### Preconditions
Transaction data is available.

### Main Flow

1. User opens sales analysis.
2. User selects a store or region.
3. System retrieves completed transactions.
4. System calculates sales metrics.
5. System displays store performance.

### Expected Result

The user can identify high- and low-performing stores.

---

# UC-002 — Analyze Product Performance

### Actor
Store Manager / Inventory Manager

### Objective
Identify top-performing products.

### Main Flow

1. User opens product analysis.
2. User selects category or product.
3. System retrieves transaction details.
4. System calculates sales and quantity.
5. System ranks products.

### Expected Result

The user can identify products contributing to sales.

---

# UC-003 — Monitor Inventory

### Actor
Inventory Manager

### Objective
Identify inventory risks.

### Main Flow

1. User opens inventory analysis.
2. System retrieves inventory records.
3. System compares available quantity with reorder level.
4. System classifies inventory.
5. Dashboard displays low-stock and out-of-stock items.

### Expected Result

Inventory risks can be prioritized.

---

# UC-004 — Analyze Returns

### Actor
Operations Manager

### Objective
Understand return behavior.

### Main Flow

1. User opens return analysis.
2. System retrieves return records.
3. User filters by product, store, reason, or approval status.
4. System calculates return metrics.
5. Dashboard displays return trends.

### Expected Result

Recurring return patterns can be identified.

---

# UC-005 — Analyze Payment Exceptions

### Actor
Finance Analyst

### Objective
Identify incomplete payments.

### Main Flow

1. User opens payment analysis.
2. System retrieves payment records.
3. User filters payment status.
4. System identifies incomplete payments.
5. Dashboard displays payment exceptions.

### Expected Result

Finance can investigate payment exceptions.

---

# UC-006 — Reconcile Payments

### Actor
Finance Manager

### Objective
Identify differences between POS totals and payment totals.

### Main Flow

1. User selects store and reconciliation period.
2. System retrieves POS totals.
3. System retrieves completed payment totals.
4. System calculates variance.
5. System identifies exceptions.
6. Finance investigates the exception.

### Expected Result

Reconciliation issues can be identified and investigated.

---

# UC-007 — Analyze Customer Loyalty

### Actor
CRM / Marketing Manager

### Objective
Understand loyalty engagement.

### Main Flow

1. User opens customer analysis.
2. System retrieves customer information.
3. System retrieves loyalty transactions.
4. System calculates loyalty activity.
5. User analyzes customer segments.

### Expected Result

The business can identify customer engagement patterns.

---

# UC-008 — Executive Performance Review

### Actor
Senior Management

### Objective
Review overall business performance.

### Main Flow

1. Executive opens Power BI dashboard.
2. Dashboard displays key KPIs.
3. Executive reviews sales performance.
4. Executive reviews store performance.
5. Executive reviews inventory and operational exceptions.
6. Executive reviews payment and return trends.
7. Executive identifies areas requiring action.

### Expected Result

Management can make data-driven decisions using a consolidated view of the business.
