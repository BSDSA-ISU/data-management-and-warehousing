# Laboratory Activity No. 2: Data Lifecycle Management Plan

![2hu](https://media1.tenor.com/m/rV0g2rBy7bYAAAAC/touhou-chen.gif)

> planned but planless

## Part A – Planning the Data

| Question | Answer |
| --- | --- |
| **Organization** | Grand Horizon Hotel & Resort |
| **Dataset** | Hotel Guest Reservation & Check-in Dataset |
| **Why does the organization need this data?** | To manage room allocations, process payments, facilitate smooth check-ins/check-outs, personalize guest services (e.g., room preferences, dietary needs), track occupancy rates, and maintain legal guest registries for local law enforcement and tax authorities. |
| **Who will use the data?** | Front Desk Clerks, Reservation Managers, Housekeeping Team, Billing/Accounting Personnel, Hotel Management, and Marketing Staff. |
| **Is the data confidential? Explain.** | **Yes.** It contains Personally Identifiable Information (PII) such as full names, home addresses, phone numbers, email addresses, government ID copies, and sensitive financial data (credit card numbers). Unauthorized disclosure leads to privacy violations and financial theft. |
| **What regulations or policies should protect the data?** | Data Privacy Act of 2012 (R.A. 10173), Payment Card Industry Data Security Standard (PCI-DSS), and internal Hotel Data Protection and Guest Confidentiality Policies. |

---

## Part B – Identify the Data Lifecycle

| Lifecycle Stage | What Happens to the Data? |
| --- | --- |
| **Plan** | Define necessary data fields (e.g., guest name, contact details, payment info, stay dates), establish access permissions, and select a secure Property Management System (PMS) compliant with PCI-DSS. |
| **Capture / Collect** | Guest details are gathered via online booking engines, third-party sites (e.g., Agoda, Booking.com), or front desk check-in forms. |
| **Store** | Reservation records are saved into the central Hotel Property Management System (PMS) database hosted on an encrypted local server and backed up to a secure cloud server. |
| **Process / Maintain** | Data is updated during the guest’s stay (e.g., room changes, room service charges, key card generation) and audited nightly to resolve record inconsistencies. |
| **Use / Analyze** | Front desk uses data to check guests in; accounting uses it to finalize invoices; management analyzes room occupancy trends, average daily rates (ADR), and guest preferences for marketing. |
| **Publish / Share** | Non-sensitive guest count summaries are shared internally with department heads. Specific guest details are securely transmitted to payment gateways for settlement or to local authorities/police if legally required. |
| **Archive** | After check-out and invoice settlement, guest records are moved from the active operational database to an encrypted, read-only cold storage archive after 1 year of inactivity. |
| **Purge / Destroy** | Once the statutory retention period (e.g., 5 years for financial records) expires, guest PII and payment data are permanently erased from all primary systems and backups using digital shredding algorithms. |

---

## Part C – Governance Responsibilities

| Lifecycle Stage | Responsible Person/Role | Responsibility |
| --- | --- | --- |
| **Plan** | Data Governance Officer | Establishes hotel data privacy policies, regulatory compliance guidelines, and system access boundaries. |
| **Capture** | End User (Front Desk Agent / Reservation Staff) | Accurately inputs guest details, verifies government IDs, and ensures guest consent forms are signed. |
| **Store** | Database Administrator (DBA) | Configures database encryption, manages database access levels, and sets up automated daily backups. |
| **Process** | Data Engineer / System Administrator | Maintains PMS integration pipelines, ensures continuous sync between web booking tools and the internal database, and runs routine error checks. |
| **Use** | Data Analyst / Department Head | Analyzes occupancy trends and guest demographics to generate business reports without exposing raw PII. |
| **Share** | Data Steward | Authorizes external transfers (e.g., to tax auditors or law enforcement) ensuring compliance with legal requests. |
| **Archive** | System Administrator | Executes scheduled data migration from active PMS databases to encrypted, long-term archive storage. |
| **Purge** | System Administrator / DBA | Permanently deletes expired archived files following approved cryptographic destruction protocols. |

---

## Part D – Retention Policy

| Question | Answer |
| --- | --- |
| **How long should the data remain active?** | **1 Year.** Remains in the active Property Management System (PMS) to facilitate repeat bookings, manage refunds, and handle accounting reconciliations. |
| **When should it be archived?** | Exactly **12 months** after the guest’s check-out date. |
| **Why should it be archived?** | To maintain historical records for tax compliance, legal liability protection, and annual financial auditing while keeping the primary PMS lightweight and fast. |
| **When should it be permanently deleted?** | **5 Years** after the check-out date (aligning with typical corporate tax retention laws and privacy regulations). |
| **What method should be used for secure deletion?** | **DoD 5220.22-M (Data Sanitization Standard)** or cryptographic erasure (destroying the encryption key for the archived data block) for cloud-based backups. Physical paper records (if any) will be cross-cut shredded. |

---

## Part E – Risk Assessment

| Lifecycle Stage | Possible Risk | Preventive Control |
| --- | --- | --- |
| **Plan** | Inadequate privacy controls leading to non-compliance with data privacy laws. | Conduct a comprehensive Privacy Impact Assessment (PIA) prior to deploying system changes. |
| **Capture** | Front desk error or deliberate input of fake guest information/unauthorized payment details. | Implement mandatory field validation checks and automated credit card pre-authorization in the PMS. |
| **Store** | Unauthorized internal access or database breach leaking credit card and PII data. | Implement AES-256 encryption at rest and strict Role-Based Access Control (RBAC). |
| **Process** | Data corruption or loss during synchronization between online booking portals and the PMS. | Use transaction logging, automated validation scripts, and routine database integrity audits. |
| **Use** | Front desk or marketing staff downloading and misusing guest contact lists for personal gain. | Disable file exports/USB access on front-desk terminals and enforce strict logging of data access. |
| **Share** | Interception of guest credit card data during processing with external payment gateways. | Encrypt all data in transit using TLS 1.3 protocol and adhere strictly to PCI-DSS standards. |
| **Archive** | Unencrypted archive files exposed to unauthorized personnel or ransomware attacks. | Store archives offsite on immutable, air-gapped, encrypted read-only storage mediums. |
| **Purge** | Incomplete data wiping leaving leftover copies in system backups or temporary caches. | Enforce certified multi-pass digital overwriting and maintain a formal Certificate of Destruction log. |

---

## Part F – Lifecycle Comparison & Reflection

### 1. How is the Data Lifecycle different from the Data Journey?

* **Data Lifecycle:** Focuses on the **governance, administration, and policy management** of a dataset from a structural standpoint (how data is planned, stored, protected, retained, and eventually destroyed by the system).
* **Data Journey:** Focuses on the **lineage and flow** of the data as it moves physically or logically across business units, transformation pipelines, analytics tools, and end-user touchpoints (how data is transformed into insights).

### 2. Which lifecycle stage do you think is the most critical? Why?

The **Plan stage** is the most critical. Every operational risk, security flaw, and compliance failure later in the lifecycle traces back to poor planning. Establishing clear rules for data collection, privacy policies, storage architecture, and access rights from the start prevents costly data breaches and system inefficiencies.

### 3. What could happen if an organization never archives its data?

* **Degraded Performance:** The operational Property Management System (PMS) becomes bloated, leading to slow query speeds, system lag during guest check-in, and longer backup times.
* **Increased Vulnerability:** Retaining massive amounts of active data increases the organization's "attack surface"—if a breach occurs, far more historical guest data is exposed.
* **Storage Costs:** Hosting stale data on high-performance primary storage is significantly more expensive than using cold storage archives.

### 4. Why is secure deletion just as important as secure storage?

Storing data securely protects it while it has operational value, but holding onto data beyond its lifecycle creates unnecessary liability. If old datasets are simply thrown in a digital trash bin without cryptographic erasure or secure overwriting, attackers can recover leftover files (via forensic tools). Secure deletion ensures data cannot be exploited even if hardware or cloud servers are decommissioned.

### 5. What role does data governance play throughout the lifecycle?

Data Governance acts as the **overseeing framework and authority**. It defines *who* owns the data, *who* is allowed to access it, *what* safety compliance guidelines must be followed, and *how* risks are mitigated at every step from initial planning down to final destruction.

---

## Key Submission Deliverables Guide

To finish the remaining submission items for your group:

1. **One-page Data Lifecycle Diagram:** Draw a circular flowchart connecting the 8 stages (`Plan` $\rightarrow$ `Capture` $\rightarrow$ `Store` $\rightarrow$ `Process` $\rightarrow$ `Use` $\rightarrow$ `Publish/Share` $\rightarrow$ `Archive` $\rightarrow$ `Purge`). Under each node, add 2–3 brief bullet points from **Part B** above.

2. **5–7 Minute Presentation Structure:**

* **Slide 1:** Title & Group Introduction (Dataset: Hotel Guest Reservation Data)

* **Slide 2:** Planning & Context (Why the hotel needs PII and card data & privacy laws involved)
* **Slide 3:** Data Lifecycle Overview (Briefly walk through Plan $\rightarrow$ Purge)
* **Slide 4:** Roles & Retention Policy (Highlight key roles like Data Steward/DBA and the 5-year destruction rule)
* **Slide 5:** Risk Assessment & Key Takeaways (Highlight 2 major risks and your reflection)
