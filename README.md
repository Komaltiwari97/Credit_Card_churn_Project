# Credit Card Customer Churn Analysis

## Project Overview
This project focuses on analysing customer churn in the credit card industry. The main objective is to identify customer behaviours and factors associated with customer churn and generate useful business insights.

## Project Objectives
- Analyse customer churn patterns.
- Identify factors associated with customer churn.
- Study the impact of payment delays, customer engagement, and monthly spending.
- Create meaningful insights to help improve customer retention.
- Build an interactive dashboard using Power BI.

## Dataset Information
- Dataset: Credit Card Customer Churn Dataset
- Total Records: 100,000 customers
- Original Columns: 40
- Target Variable: `churned`
  - 0 = Customer did not churn
  - 1 = Customer churned

## Tools and Technologies
- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- MySQL Workbench
- Power BI (planned)

## Project Workflow

### 1. Data Collection
Downloaded the credit card customer dataset from Kaggle.

### 2. Data Cleaning (Python – Google Colab)
- Checked missing values.
- Handled missing values.
- Checked duplicate records.
- Performed outlier analysis.
- Explored numerical and categorical columns.
- Prepared the cleaned dataset for analysis.

### 3. Database Management (MySQL)
- Created the database `credit_card_churn`.
- Created the table `cleaned_customer_churn`.
- Imported the cleaned CSV file into MySQL.
- Verified that all 100,000 records were imported successfully.

### 4. Exploratory Data Analysis (SQL)

Performed SQL analysis to understand customer churn patterns.

Analyses completed:
- Overall customer churn rate.
- Gender-wise churn analysis.
- Payment delay analysis.
- Customer engagement analysis.
- Monthly spending analysis.

Additional analyses are in progress.

## Key Findings

1. **Overall Churn:** 19.46% of customers have churned.
2. **Gender Analysis:** Churn percentages are very similar across male, female, and other customers.
3. **Payment Delays:** Customers with more payment delays show a much higher churn rate.
4. **Customer Engagement:** Customers with lower engagement have higher churn rates.
5. **Monthly Spending:** Customers spending above 5K have a churn rate of 21.38%, compared with 17.23% for customers spending below 1K.

## Project Status

- [x] Dataset collection
- [x] Data cleaning using Python
- [x] Missing-value and duplicate checks
- [x] Outlier analysis
- [x] MySQL database creation
- [x] Cleaned dataset imported into MySQL
- [x] Initial SQL analysis
- [ ] Complete remaining SQL analysis
- [ ] Build Power BI dashboard
- [ ] Prepare final business insights
- [ ] Complete project documentation

## Conclusion
This project aims to understand the factors associated with credit card customer churn through data cleaning, SQL analysis, and data visualization. The findings will help identify customer groups that may need better engagement and retention strategies.

---

**Project Type:** Data Analytics  
**Status:** In Progress

