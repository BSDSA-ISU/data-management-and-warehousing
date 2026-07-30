# Topic 2: The Data Lifecycle

 **Table of contents:**

- [Topic 2: The Data Lifecycle](#topic-2-the-data-lifecycle)
  - [2.1 What Is the Data Lifecycle?](#21-what-is-the-data-lifecycle)
  - [2.2 Common Data Lifecycle Stages](#22-common-data-lifecycle-stages)
  - [2.3 Why Lifecycle Management Matters](#23-why-lifecycle-management-matters)
    - [Cost control](#cost-control)
    - [Regulatory compliance](#regulatory-compliance)
    - [Risk reduction](#risk-reduction)
    - [Data quality](#data-quality)
  - [2.4 Comparing Data Lifecycle Models](#24-comparing-data-lifecycle-models)
  - [2.5 Data Governance Across the Lifecycle](#25-data-governance-across-the-lifecycle)
    - [Policies](#policies)
    - [Standards](#standards)
    - [Roles and accountability](#roles-and-accountability)
    - [Monitoring and audit](#monitoring-and-audit)
  - [2.6 Data Retention and Disposal](#26-data-retention-and-disposal)
    - [Legal and regulatory requirements](#legal-and-regulatory-requirements)
    - [Business need](#business-need)
    - [Storage cost](#storage-cost)
    - [Risk exposure](#risk-exposure)
  - [2.7 Extended Case Study: Lifecycle of a Patient Health Record](#27-extended-case-study-lifecycle-of-a-patient-health-record)
    - [Plan](#plan)
    - [Capture](#capture)
    - [Store](#store)
    - [Maintain](#maintain)
    - [Use](#use)
    - [Share](#share)
    - [Archive](#archive)
    - [Purge](#purge)
  - [2.8 Review Questions](#28-review-questions)

---

![Koishi Koishi](./koishi-komeiji-touhou.gif)

> Koishi Koishi

---

## 2.1 What Is the Data Lifecycle?

The data lifecycle refers to the sequence of stages that data passes through from a management perspective how it should be planned for, governed, maintained, and eventually retired. While the data journey describes the physical or logical path data actually takes, the data lifecycle describes the managerial responsibilities and controls that should be applied at each stage of that journey.

A helpful distinction: the data journey answers "where does the data go and what happens to it," while the data lifecycle answers "what should we be doing to manage it responsibly at each point in time."

## 2.2 Common Data Lifecycle Stages

| Stage | Description | Typical Activities |
| :--- | :--- | :--- |
| Plan | Defining what data is needed, why it is needed, and how it will be governed before any data is collected. | Requirements gathering, data governance planning, defining standards |
| Capture / Collect | Acquiring data from an original source, whether generated internally or obtained externally. | Manual entry, sensor readings, transactions, web forms, APIs |
| Store | Placing data into a repository where it can be retrieved, secured, and maintained. | Databases, data warehouses, data lakes, file systems |
| Process / Maintain | Transforming, validating, and updating data so it remains fit for use. | Cleaning, transformation, enrichment, quality checks |
| Use / Analyze | Applying data to support decisions, operations, or analytical insight. | Reporting, dashboards, statistical analysis, machine learning |
| Publish / Share | Making data available to other users, departments, or organizations. | Data sharing agreements, APIs, exports, dissemination |
| Archive | Moving inactive data to long-term, lower-cost storage while preserving it for future reference. | Cold storage, compliance retention, historical backups |
| Purge / Destroy | Permanently and securely removing data once it is no longer needed or legally required. | Secure deletion, media destruction, compliance sign-off |

## 2.3 Why Lifecycle Management Matters

### Cost control

- storing every piece of data forever on high-performance systems is expensive; lifecycle policies move data to cheaper storage as it ages.

### Regulatory compliance

- laws such as data privacy regulations often require organizations to retain or delete personal data within specific timeframes.

### Risk reduction

- outdated or unnecessary data that is retained indefinitely increases exposure in the event of a data breach.

### Data quality

- active lifecycle management ensures data is reviewed and maintained rather than left to decay silently.

## 2.4 Comparing Data Lifecycle Models

Different fields have developed their own frameworks for describing the data lifecycle, though they share the same underlying logic. Being familiar with more than one model helps you recognize the concept regardless of which vocabulary a particular organization uses.

| Model | Focus | Typical Context of Use |
| :--- | :--- | :--- |
| DAMA-DMBOK Lifecycle | Treats data as an asset managed through business-oriented stages: plan, enable, create/obtain, store, maintain, use, and dispose. | Corporate data management and governance programs |
| DCC Curation Lifecycle Model | Emphasizes long-term digital preservation and re-use, with continuous actions such as description and community watch running throughout. | Research data management and archival institutions |
| Generic IT Lifecycle | A simplified version focused on the technical stages: collect, store, process, analyze, archive, delete. | Software systems and database administration |

## 2.5 Data Governance Across the Lifecycle

Effective lifecycle management does not happen automatically. It is enabled by data governance: the set of policies, roles, and standards that determine who may access data, how it must be protected, how long it should be kept, and who is accountable for it at each stage. A data steward is often assigned responsibility for specific data domains to ensure lifecycle policies are actually followed.

Governance typically operates through a small set of recurring mechanisms across the lifecycle:

### Policies

- formal, written rules describing how data must be handled (for example, a retention policy or an access-control policy).

### Standards

- agreed-upon formats, definitions, and naming conventions that keep data consistent as it moves between stages.

### Roles and accountability

- clearly assigned ownership so that every dataset has someone responsible for its condition.

### Monitoring and audit

- periodic checks to confirm that lifecycle policies are actually being followed in practice, not just on paper.

## 2.6 Data Retention and Disposal

Retention policies specify how long different categories of data must, or may, be kept before they are archived or destroyed. Retention periods are influenced by several factors working together:

### Legal and regulatory requirements

- certain records (for example, financial or medical records) must be kept for a legally mandated minimum period.

### Business need

- data that is still actively used to support decisions should remain readily accessible.

### Storage cost

- keeping large volumes of inactive data on expensive, high-performance storage is often not cost-effective.

### Risk exposure

- the longer sensitive data is retained, the greater the potential impact if it is ever breached.

When data reaches the end of its useful and legally required life, it should be disposed of through a controlled, documented, and secure process not simply left to accumulate indefinitely. Secure disposal may involve cryptographic erasure, physical destruction of storage media, or certified deletion procedures, depending on the sensitivity of the data.

## 2.7 Extended Case Study: Lifecycle of a Patient Health Record

Healthcare provides a clear illustration of lifecycle management because the stakes of mishandling data are high and regulations are strict.

### Plan

- A hospital defines what patient data it must collect and the security and privacy controls required before any system is built.

### Capture

- A patient's vital signs, diagnosis, and treatment history are recorded during a clinical visit.

### Store

- The record is stored in an electronic health record (EHR) system with strict access controls.

### Maintain

- Clinicians update the record on each subsequent visit; outdated information (such as an old address) is corrected.

### Use

- Doctors, nurses, and billing staff access the record to support treatment decisions and insurance claims.

### Share

- With the patient's consent, portions of the record may be shared with a specialist or referred facility.

### Archive

- After the patient stops receiving care, the record is moved to long-term secure storage, still accessible if needed.

### Purge

- Once the legally mandated retention period expires (which can be decades for medical records), the record is securely destroyed.

This case shows how lifecycle stages are rarely a ### strict straight line —records are revisited, updated, and reused multiple times before they are finally retired.

## 2.8 Review Questions

Explain the difference between the data journey and the data lifecycle in your own words.

- List the eight lifecycle stages introduced in this section and give a one-sentence description of each.
- Why is data governance necessary for lifecycle management to actually work in practice?
- Name three factors that influence how long an organization should retain a piece of data.
Why might secure disposal be considered just as important as secure storage?

> Discussion: Why might an organization choose to archive data rather than delete it immediately once it is no longer actively used? What risks does archiving avoid, and what new risks does it introduce?
