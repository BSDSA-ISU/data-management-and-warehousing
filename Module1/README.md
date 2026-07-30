# Foundations of Data Management

- [Foundations of Data Management](#foundations-of-data-management)
  - [Module Overview](#module-overview)
  - [Learning Objectives](#learning-objectives)
  - [1.1 What Is the Data Journey?](#11-what-is-the-data-journey)
  - [1.2 Typical Stages of the Data Journey](#12-typical-stages-of-the-data-journey)
    - [Creation / Capture](#creation--capture)
    - [Ingestion](#ingestion)
    - [Storage](#storage)
    - [Processing / Transformation](#processing--transformation)
    - [Movement / Integration](#movement--integration)
    - [Consumption / Use](#consumption--use)
    - [Archival or Disposal](#archival-or-disposal)
  - [1.3 Data Provenance and Data Lineage](#13-data-provenance-and-data-lineage)
    - [Two concepts are essential to understanding a data journey](#two-concepts-are-essential-to-understanding-a-data-journey)
  - [1.4 Why the Data Journey Matters](#14-why-the-data-journey-matters)
  - [1.5 Types and Sources of Data Entering the Journey](#15-types-and-sources-of-data-entering-the-journey)
  - [1.6 Stakeholders Along the Data Journey](#16-stakeholders-along-the-data-journey)
  - [1.7 The Data Journey Versus the Data Value Chain](#17-the-data-journey-versus-the-data-value-chain)
  - [1.8 Common Challenges Along the Data Journey](#18-common-challenges-along-the-data-journey)
    - [Data silos](#data-silos)
    - [Loss of context](#loss-of-context)
    - [Format incompatibility](#format-incompatibility)
    - [Latency](#latency)
    - [Security exposure](#security-exposure)
    - [1.9 Illustrative Example](#19-illustrative-example)
  - [1.10 Extended Case Study: A Student Enrollment Journey](#110-extended-case-study-a-student-enrollment-journey)
  - [1.11 Review Questions](#111-review-questions)
  - [GO to topic 2](#go-to-topic-2)

![Alice](https://media.tenor.com/q_2ybfXh_j8AAAAi/alice-margatroid.gif)

![Alice](https://media.tenor.com/q_2ybfXh_j8AAAAi/alice-margatroid.gif)

> Aice My alice      --H3xag0n555

**Topics covered in this module:**

1. The Data Journey
2. The Data Lifecycle
3. Data Quality Concepts
4. Data Cleaning Concepts
5. Data Integration Techniques

## Module Overview

Every organization runs on data, but data by itself has no value. Value is created only when data is properly managed: captured accurately, moved reliably, kept trustworthy, and made available to the people and systems that need it. This module introduces the foundational concepts of data management that underpin every later topic in this course, from analytics to governance to systems design.

The five Topics in this module build on one another. The Data Journey and Data Lifecycle give you the "big picture" of how data moves and is governed over time. Data Quality and Data Cleaning address what happens when data is imperfect — which, in practice, it almost always is. Data Integration Techniques then shows how data from many imperfect, scattered sources is brought together into something an organization can actually use.

## Learning Objectives

By the end of this module, students should be able to:

1. Trace the path data takes from creation to disposal and describe each stage of that journey.
2. Differentiate between the concepts of data journey and data lifecycle, and explain the purpose of lifecycle management.
3. Define data quality and evaluate data against the core dimensions of data quality.
4. Explain the purpose, techniques, and challenges of data cleaning.
5. Compare common data integration techniques and identify which is appropriate for a given business scenario.

## 1.1 What Is the Data Journey?

The data journey refers to the complete path that a piece of data travels — from the moment it is created or captured, through every system, process, and person that touches it, to the point where it is finally used, shared, archived, or deleted. It is best understood as a story: data is "born" somewhere, it travels through an organization's systems, it is transformed along the way, and it eventually reaches an end point where it delivers value (or is retired).

Unlike a simple flowchart of a single system, the data journey often crosses many boundaries: between departments, between on-premises systems and cloud platforms, between an organization and its partners, and between structured and unstructured formats.

## 1.2 Typical Stages of the Data Journey

### Creation / Capture

- Data originates from a transaction, a sensor reading, a form submission, a social media post, or any other real-world event.

### Ingestion

- The captured data is brought into an organization's systems, often through APIs, file transfers, or direct database entry.

### Storage

- Data is placed into a database, data warehouse, data lake, or file system where it can persist and be retrieved later.

### Processing / Transformation

- Raw data is cleaned, restructured, enriched, or aggregated so that it is usable for a specific purpose.

### Movement / Integration

- Data is moved or combined with other data sets so that it can be shared across systems or departments.

### Consumption / Use

- Data is finally used to support a decision, a report, a machine learning model, or an operational process.

### Archival or Disposal

- Once data is no longer actively needed, it is either archived for long-term retention or securely destroyed.

## 1.3 Data Provenance and Data Lineage

### Two concepts are essential to understanding a data journey

- Data Provenance describes the origin of a piece of data — where it came from and who or what created it.

- Data Lineage describes the complete history of a piece of data as it moves and is transformed across systems, answering the question, "How did this number end up looking the way it does?"

Being able to trace lineage is critical for trust, auditing, regulatory compliance, and troubleshooting. If a report shows an incorrect figure, lineage lets an analyst trace the number backward through every transformation to find where the error was introduced.

## 1.4 Why the Data Journey Matters

- It reveals where data quality problems are likely to be introduced (for example, at manual entry points).
- It supports accountability — every stage of the journey should have an identifiable owner or steward.
- It is the basis for data governance policies, since rules can be attached to specific stages of the journey.
- It helps organizations comply with privacy regulations that require knowing where personal data travels.

## 1.5 Types and Sources of Data Entering the Journey

Data enters an organization's journey from many different kinds of sources, and the type of data strongly influences how it must be handled at every later stage. The table below summarizes the most common classifications used in data management.

| Source Type | Description | Examples |
| --- | --- | --- |
| **Structured Data** | Data organized into a strict, predefined schema of rows and columns, easily searchable by conventional query languages. | Relational database tables, spreadsheets, transaction logs |
| **Unstructured Data** | Data with no predefined format or organization, requiring specialized methods for interpretation. | Emails, videos, images, social media posts, PDFs |
| **Semi-Structured Data** | Data that does not sit in a relational structure but contains tags or markers that separate elements. | JSON files, XML documents, sensor log files |
| Internal Data | Data generated by an organization's own operations, systems, and employees. | Sales records, HR systems, internal surveys |
| External Data | Data acquired from outside the organization, often through partnerships, purchases, or public sources. | Market research reports, government open data, purchased mailing lists |
| Machine-Generated Data | Data automatically produced by devices, applications, or systems without direct human entry. | IoT sensor readings, server logs, GPS data |

Recognizing these categories early matters because structured data can usually move directly into databases, while unstructured and semi-structured data typically require extra processing — such as parsing, tagging, or the use of specialized storage like a data lake — before they can be meaningfully integrated with the rest of an organization's data.

## 1.6 Stakeholders Along the Data Journey

A data journey is never purely technical; it is also organizational. Different people are responsible for data at different points, and confusion about who owns a stage is one of the most common causes of data problems. The table below outlines typical roles.

| Role | Responsibility Along the Data Journey |
| :--- | :--- |
| Data Producer / Source Owner | Generates or captures the original data and is responsible for its initial accuracy. |
| Data Steward | Oversees the quality, definition, and proper use of data within a specific domain, acting as the accountable custodian. |
| Data Engineer | Builds and maintains the technical pipelines that move, transform, and store data. |
| Data Analyst / Scientist | Consumes data to generate insight, reports, or predictive models. |
| Data Governance Officer | Defines the policies, standards, and compliance requirements that apply across the entire journey. |
| End User / Decision-Maker | Relies on the final, processed data to make operational or strategic decisions. |

## 1.7 The Data Journey Versus the Data Value Chain

The data journey is closely related to, but distinct from, the idea of a data value chain. A data value chain focuses specifically on how value is added to data at each stage — for example, raw sensor readings have little value on their own, but once aggregated, analyzed, and visualized in a dashboard, they can directly inform a business decision. The data journey is the broader map of movement and transformation; the value chain is the lens that asks, "What value did this stage add?" Thinking in terms of value helps organizations decide which stages of the journey are worth investing in and which may be unnecessary overhead.

## 1.8 Common Challenges Along the Data Journey

### Data silos

data trapped in one department's systems, inaccessible to the rest of the organization, breaking the journey before it can reach other users.

### Loss of context

as data moves between systems, the meaning of a field can get lost if it is not well documented (for example, does "amount" mean before or after tax?).

### Format incompatibility

different systems may  use incompatible file formats, encodings, or field structures, requiring conversion at each handoff.

### Latency

delays introduced at any stage of the journey can make data stale by the time it reaches its final consumer.

### Security exposure

every additional stop along the journey is a potential point of unauthorized access if not properly secured.

### 1.9 Illustrative Example

Consider a single retail transaction. A customer purchase is captured at a point-of-sale terminal (creation). That record is transmitted to a central transaction database (ingestion and storage). Overnight, a batch job aggregates the day's transactions and loads them into a data warehouse (processing and integration).

The following morning, a sales dashboard queries the warehouse so the store manager can review yesterday's performance (consumption).

After seven years, in line with the company's retention policy, the detailed transaction record is moved to cold storage and eventually deleted (archival and disposal).

## 1.10 Extended Case Study: A Student Enrollment Journey

To see how many stakeholders and stages a single journey can involve, consider how one piece of data — a student's enrollment status — travels through a university.

1. A prospective student submits an online application (creation, by the data producer).
2. The admissions system ingests the application and stores it in the admissions database (ingestion and storage).
3. An admissions officer reviews and updates the application status (processing, by a data steward).
4. Once accepted, the student's record is transferred into the official student information system (movement and integration, by data engineers).
5. The registrar's office, finance office, and academic departments all query this record for their own purposes (consumption, by multiple end users).
6. Years after graduation, the enrollment record is archived according to the university's retention schedule (archival, governed by policy).

This example shows that even a single, seemingly simple data point passes through many hands, systems, and transformations — which is exactly why understanding the data journey is foundational to responsible data management.

## 1.11 Review Questions

1. In your own words, define the data journey and explain how it differs from a simple technical data flow diagram.
2. What is the difference between data provenance and data lineage?
3. Name three stakeholders involved in a typical data journey and describe their responsibilities.
4. Why does unstructured data often require more processing than structured data before it can be integrated?
5. Describe one risk that can occur at each of three different stages of the data journey.

> Discussion: Choose an everyday digital action (e.g., posting on social media, using a ride-hailing app). Trace its data journey through as many stages as you can identify, and name at least two stakeholders involved.

## GO to topic 2

[Topic 2](../topic2/)
