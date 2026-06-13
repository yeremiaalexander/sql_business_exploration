# Magist E-Commerce Data Analytics Portfolio

## Project Overview
This repository contains a comprehensive SQL analytics project focusing on **Magist**, a rapidly growing e-commerce platform. Using a relational database snapshot, this project explores core business operations across four key pillars: **business expansion, product portfolio alignment, seller performance, and supply chain logistics**. 

The goal of this analysis is to extract data-driven insights that help stakeholders understand Magist's market share in the high-value "Tech" sector, evaluate delivery fulfillment efficiency, and optimize seller operations.

---

## Technical Skills Demonstrated
* **Advanced Aggregations:** Multi-stage calculations using `COUNT(DISTINCT)`, `SUM`, and `AVG` to evaluate macro company trends.
* **Conditional Aggregation:** Utilizing `CASE WHEN` statements natively inside aggregate functions to compute complex metrics (e.g., Tech vs. Non-Tech distributions) without relying on heavy subqueries.
* **Multi-Table Joins:** Constructing clean relational bridges across up to five tables (`orders`, `order_items`, `products`, `sellers`, `product_category_name_translation`, `geo`) using explicit alias mapping.
* **Window Functions:** Deploying `SUM() OVER()` to calculate categorical percentages relative to the company-wide total.
* **Data Cleansing & Filtering:** Handling string matching, standardizing localized product category translations, and filtering null data blocks.
* **Date-Time Analytics:** Working with `TIMESTAMPDIFF`, `DATE_FORMAT`, and `DATEDIFF` to track calendar timelines and measure delivery speeds.

---

## Core Business Questions Answered

### 📦 1. Product Portfolio & Market Penetration
* Identified the specific categories representing "Tech" products within the marketplace.
* Calculated the precise volume and percentage that tech products represent relative to total catalog sales.
* Analyzed customer review patterns to determine if premium, higher-priced tech items maintain high popularity and customer satisfaction.

### 👥 2. Seller Dynamics & Revenue Generation
* Evaluated the total active timeline of data recorded in the platform using month-based differentials.
* Determined the exact proportion of marketplace sellers specializing in Tech items versus standard consumer products.
* Developed analytical models to capture total revenue generated and isolated the overall average monthly income generated per seller.

### 🚚 3. Supply Chain & Logistics Performance
* Computed the exact average time delta between a customer placing an order and physical delivery confirmation.
* Built a tracking model classifying orders as "on-time" vs. "delayed" relative to customer estimates.
* Evaluated potential correlations between product characteristics (specifically item weight thresholds) and logistics bottlenecks.

### 🗺️ 4. Geographic & Financial Explorations
* Aggregated gross revenue generation down to specific seller geographic zip codes to find regional performance hubs.
* Mapped customer satisfaction and review score averages to geographic clusters.
* Analyzed the distribution and percentage share of customer payment methods (credit cards, vouchers, etc.) preferred across the platform.

---

## Repository Structure
* `magist data dump practice.sql`: The primary production script containing the raw SQL queries, schema calls, and optimization structures used during the analysis.

---

## Database Schema & Structure Insights
This analysis relies heavily on connecting fragmented relational tables. Key structural implementations include:
* Using `order_items` as a central intersection bridge to link product dimensions to seller files.
* Leveraging the English translation reference dictionary to standardize local language category titles.
* Accounting for operational realities (e.g., filtering out unconfirmed/canceled deliveries to isolate successful transactions).

---

### How to Use This Project
1. Ensure a MySQL-compatible database instance is running with the `magist` database schema installed.
2. Open the `.sql` script in your preferred database GUI (e.g., MySQL Workbench, DBeaver).
3. Execute individual query blocks sequentially to populate the corresponding analytical results.
