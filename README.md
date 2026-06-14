# 🌍 Strategic Market Expansion: Eniac’s Brazil Entry & Magist Partnership Evaluation
**Project Team:** The Missing Semicolons  

## 📊 Business Case Overview (Fall 2018)
It is the fall of 2018. **Eniac**, a premium Spanish online marketplace specializing in Apple hardware and luxury tech accessories, has recently gone public. Backed by intense investor pressure to aggressively scale globally, Eniac is evaluating a massive milestone: **entering the Brazilian e-commerce market**. 

Eniac’s core differentiator is a personalized, human-first tech support model driven by a high-touch customer culture. Expanding across South America while maintaining this premium brand identity is an immense operational challenge. To mitigate supply chain and logistics risks, this project uses SQL database mining to analyze a local Brazilian logistics provider, **Magist**, to deliver a data-driven partnership recommendation directly to the Eniac CEO and Board of Directors.

---

## 🎯 Strategic Alignment Analysis (The Core Dilemma)
This project maps out raw data against corporate strategy to evaluate whether a premium retailer like Eniac (€540.00 average product price) can find operational synergy within Magist’s broad-market fulfillment network.

### 🔑 Key Data Discoveries & Core Findings

#### 📦 1. Product Catalog Dilution & Portfolio Mismatch
* **Volume vs. Exclusivity:** Magist’s network processes a total of **32,951 products**. However, a staggering **88.03%** of those items belong to **Non-Tech** categories. Only **11.97%** are **Tech products**, indicating Magist acts primarily as a broad generalist marketplace rather than a specialized tech hub.
* **The Premium Pricing Chasm:** While Eniac’s premium, curated tech product inventory carries an average price tag of **€540.00**, Magist's entire tech category averages only **€110.14** (and their total catalog averages €120.65). This represents a steep mismatch in target consumer demographics.

#### 🚚 2. Operational Delivery Performance
* **The 12.5-Day Baseline:** SQL queries track a **12.5-day average nationwide delivery time** from order placement to client confirmation.
* **The Local Highlight Opportunity:** Despite the long nationwide average, qualitative customer reviews frequently highlight localized fast deliveries of **2–3 days** in key zones. Combined with low delay rates and high early success scores, Magist shows a **strong local logistics fulfillment opportunity** to get Eniac into the market fast.
* **Customer Care Quality:** Magist demonstrates stable, resilient customer satisfaction ratings (+19.8% stability), offering a cultural alignment with Eniac’s premium customer service focus.

#### 🗺️ 3. Targeted Geographic Hubs
* **Regional Powerhouses:** Aggregating sales metrics across regional infrastructure revealed that Magist's tech distribution and operational strengths are heavily localized within three core metropolitan hubs:
  1. **São Paulo**
  2. **Rio de Janeiro**
  3. **Belo Horizonte**
* **The Strategic Lever:** Any initial market deployment must leverage this localized operational know-how rather than rolling out blanket nationwide shipping.

---

## ⚠️ High-Level Strategic Risks Identified
Before signing a standard multi-year contract, the board must account for four major risk vectors revealed during our data deep dive:
1. **Limited Data Visibility:** Lack of long-term historic tracking data to securely justify a rigid 3-year contract commitment.
2. **Product Portfolio Mismatch:** Operational friction stemming from a high-volume generalist ecosystem handling delicate luxury Apple products.
3. **Data Quality & Reporting Inconsistencies:** Potential reporting gaps across non-standard vendor segments.
4. **Partner Dependency:** Putting Eniac's stellar global brand equity completely in the hands of a localized third-party supply chain.

---

## 🛠️ Technical Toolkit Demonstrated
* **Relational Database Mining (MySQL):** Wrote multi-table joins, text categorization mapping conditionals, and statistical aggregations to segment Tech vs. Non-Tech performance.
* **Data Presentation & Slide Design:** Converted technical SQL script outputs into clean, visual infographic-style executive data models for C-suite alignment.

---

## 📂 Repository Structure
* `magist data dump practice.sql`: Production-ready SQL script containing data extraction, schema joins, and category filter logic.
* `Eniac_Business_Analysis.pdf`: The finalized pitch deck presented by *The Missing Semicolons* detailing product mix donut charts, geographic hub heat maps, and the final corporate action plan.
