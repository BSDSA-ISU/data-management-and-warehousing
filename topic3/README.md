# Data Quality Concepts

**Table of Contents:**

- [Data Quality Concepts](#data-quality-concepts)
  - [3.1 Defining Data Quality](#31-defining-data-quality)
  - [3.2 The Core Dimensions of Data Quality](#32-the-core-dimensions-of-data-quality)
  - [3.3 Common Causes of Poor Data Quality](#33-common-causes-of-poor-data-quality)
  - [3.4 The Business Impact of Poor Data Quality](#34-the-business-impact-of-poor-data-quality)
  - [3.5 Measuring Data Quality](#35-measuring-data-quality)
    - [Completeness rate](#completeness-rate)
    - [Duplicate rate](#duplicate-rate)
    - [Validity rate](#validity-rate)
    - [Timeliness](#timeliness)
  - [3.6 Root Causes: Why Data Quality Problems Recur](#36-root-causes-why-data-quality-problems-recur)
    - [Process gaps](#process-gaps)
    - [System design flaws](#system-design-flaws)
    - [Lack of ownership](#lack-of-ownership)
    - [Organizational silos](#organizational-silos)
    - [Insufficient training](#insufficient-training)
  - [3.7 The Cost of Poor Data Quality](#37-the-cost-of-poor-data-quality)
  - [3.8 A Framework for Managing Data Quality: Total Data Quality Management (TDQM)](#38-a-framework-for-managing-data-quality-total-data-quality-management-tdqm)
    - [Define](#define)
    - [Measure](#measure)
    - [Analyze](#analyze)
    - [Improve](#improve)
  - [3.9 Extended Case Study: A Bank's Customer Address Problem](#39-extended-case-study-a-banks-customer-address-problem)
  - [3.10 Review Questions](#310-review-questions)

---

![a](https://media1.tenor.com/m/EivOkraibugAAAAC/youmu-sway.gif)

> Youmu happy.mp4

---

## 3.1 Defining Data Quality

Data quality refers to the degree to which data is fit for its intended purpose. Data does not have to be perfect to be high quality — it has to be accurate, complete, and reliable enough for the specific decisions or processes that depend on it. Data that is excellent for one purpose (for example, a rough estimate for internal planning) may be unacceptable for another (for example, financial reporting to regulators).

## 3.2 The Core Dimensions of Data Quality

Data quality is typically evaluated across several dimensions. The table below summarizes the most widely used dimensions.

| Dimension | Definition | Example of a Violation |
| :--- | :--- | :--- |
| Accuracy | The degree to which data correctly describes the real-world object or event it represents. | A customer's recorded birthdate does not match their actual birthdate. |
| Completeness | The extent to which all required data is present and no values are missing. | A sales record is missing the region field needed for regional reporting. |
| Consistency | The degree to which data values agree across different systems, tables, or time periods. | A customer's address differs between the CRM system and the billing system. |
| Timeliness | Whether data is up to date and available when needed for a given business process. | Inventory counts are updated only once a week, causing stockouts to go unnoticed. |
| Validity | Whether data conforms to the required format, type, or range defined by business rules. | A phone number field contains letters instead of digits. |
| Uniqueness | The extent to which data or entities are recorded only once, without unintended duplication. | The same customer appears twice in a database with two different customer IDs. |
| Integrity | Whether relationships between data elements remain valid and consistent across the dataset. | An order record references a customer ID that no longer exists in the customer table. |

## 3.3 Common Causes of Poor Data Quality

- Manual data entry errors made by employees or customers.
- Lack of standardized formats across different systems or departments.
- Poorly designed forms or database structures that allow invalid entries.
- System integration issues where data does not transfer correctly between platforms.
- Data decay, where accurate data becomes outdated over time (for example, a customer moves address).
- Duplicate records created when the same entity is entered into a system more than once.

## 3.4 The Business Impact of Poor Data Quality

Poor data quality is not merely a technical inconvenience it has direct business consequences. It leads to flawed analytics and misinformed decisions, wasted marketing spend on inaccurate customer lists, failed regulatory audits, damaged customer trust, and increased operational costs from having to rework or reconcile data after the fact.

## 3.5 Measuring Data Quality

Data quality is not just a qualitative judgment — it can and should be measured. A common approach is to express each dimension as a simple metric, often a percentage, so that quality can be tracked over time and compared against a target threshold.

### Completeness rate

- (number of populated required fields ÷ total required fields) × 100%

### Duplicate rate

- (number of duplicate records ÷ total records) × 100%

### Validity rate

- (number of records passing format/range rules ÷ total records) × 100%

### Timeliness

- the elapsed time between when an event occurred and when the corresponding data became available for use

Setting explicit thresholds (for example, "completeness must remain above 98 percent") turns data quality from a vague aspiration into something that can be monitored with dashboards and alerts, much like any other operational metric.

## 3.6 Root Causes: Why Data Quality Problems Recur

Fixing a data quality problem once is not the same as preventing it from happening again. Effective data quality management traces problems back to their root cause rather than only correcting the symptom. Common root causes include:

### Process gaps

- no standard procedure exists for entering or updating a particular type of data.

### System design flaws

- a database field allows free text where a controlled list of values would prevent inconsistency.

### Lack of ownership

- no one is clearly accountable for a dataset, so errors go unnoticed and unresolved.

### Organizational silos

- different departments maintain separate, uncoordinated versions of the same data.

### Insufficient training

- staff entering data are not aware of the standards or the downstream impact of errors.

## 3.7 The Cost of Poor Data Quality

A useful way to think about investment in data quality is the cost of quality framework, which groups costs into four categories. In general, prevention and appraisal costs are far smaller than the internal and external failure costs they help avoid.

| Cost Category | Description | Example |
| :--- | :--- | :--- |
| Prevention Costs | Money spent to stop data quality problems before they occur. | Building validation rules into a web form |
| Appraisal Costs | Money spent to inspect and measure existing data quality. | Running a quarterly data quality audit |
| Internal Failure Costs | Costs incurred when poor data is caught before it reaches external customers. | Reworking a report before it is published |
| External Failure Costs | Costs incurred when poor data reaches customers, partners, or regulators. | Fines for inaccurate regulatory filings; lost customer trust |

## 3.8 A Framework for Managing Data Quality: Total Data Quality Management (TDQM)

Total Data Quality Management is a widely referenced cycle for continuously improving data quality, modeled on the classic quality-management cycle used in manufacturing. It consists of four repeating phases:

### Define

- Identify the data quality dimensions that matter most for a specific business process and set target thresholds.

### Measure

- Assess the current state of the data against those dimensions using profiling and audits.

### Analyze

- Investigate the root causes of any gaps between the current state and the targets.

### Improve

- Implement corrective actions — which may include data cleaning, process redesign, or system changes — and then repeat the cycle.

Because data quality tends to degrade over time as new errors are introduced, TDQM is deliberately cyclical rather than a one-time project.

## 3.9 Extended Case Study: A Bank's Customer Address Problem

A bank notices that 12 percent of its mailed account statements are being returned as undeliverable. Applying the TDQM cycle: in the Define phase, the bank sets a target of less than 2 percent returned mail. In the Measure phase, a data profiling exercise finds that many address records are missing unit numbers and postal codes. In the Analyze phase, the bank discovers the root cause is a web form that does not require these fields. In the Improve phase, the bank both cleans the existing address records and redesigns the form to require complete addresses going forward — addressing the symptom and the root cause together.

## 3.10 Review Questions

- Define data quality and explain why "fitness for purpose" is central to that definition.
- List the seven data quality dimensions covered in this section and give an example of each being violated.
- What is the difference between an internal failure cost and an external failure cost? Give an example of each.
- Describe the four phases of the TDQM cycle in your own words.
- Why is it important to trace a data quality problem to its root cause rather than only correcting the specific bad records found?

> Discussion: Think of a time you encountered a data quality problem as a consumer (for example, a delivery sent to the wrong address, or a duplicate account). Which data quality dimension was violated?
