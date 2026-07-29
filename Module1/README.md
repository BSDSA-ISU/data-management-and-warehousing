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