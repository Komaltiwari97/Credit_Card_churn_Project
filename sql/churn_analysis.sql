-- =========================================
-- PROJECT: Credit Card Customer Churn Analysis
-- TOOL: MySQL Workbench
-- PURPOSE: Analyse customer churn patterns
-- =========================================

CREATE DATABASE Credit_card_churn;
-- 1.select the dataset for use
USE Credit_card_churn;

-- 2.chect total number of customer
select count(*) 
from cleaned_customer_churn;


SHOW TABLES;

DESCRIBE cleaned_customer_churn;

-- Here i want to see first 10 rows
SELECT * FROM cleaned_customer_churn LIMIT 10;
SHOW CREATE TABLE cleaned_customer_churn;
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'credit_card_churn'
AND TABLE_NAME = 'cleaned_customer_churn';
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'credit_card_churn'
AND TABLE_NAME = 'cleaned_customer_churn'
AND DATA_TYPE = 'geometry';

USE credit_card_churn;



ALTER TABLE cleaned_customer_churn
MODIFY annual_fee DOUBLE,
MODIFY cash_withdrawals DOUBLE,
MODIFY customer_value_score DOUBLE,
MODIFY has_loan TINYINT,
MODIFY num_products INT,
MODIFY online_transactions INT;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'credit_card_churn'
AND TABLE_NAME = 'cleaned_customer_churn';

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
USE credit_card_churn;

SHOW COLUMNS FROM cleaned_customer_churn;

TRUNCATE TABLE cleaned_customer_churn;

# here i upload my file
LOAD DATA LOCAL INFILE 'file path'
INTO TABLE cleaned_customer_churn
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
customer_id,
age,
gender,
marital_status,
education_level,
employment_status,
income,
city,
credit_score,
account_age_months,
card_type,
credit_limit,
annual_fee,
interest_rate,
num_products,
has_loan,
has_savings_account,
monthly_spending,
avg_transaction_amount,
monthly_transactions,
online_transactions,
international_transactions,
cash_withdrawals,
utilization_ratio,
payment_delay_count,
late_payment_amount,
app_logins_monthly,
website_visits_monthly,
customer_service_calls,
complaints_count,
support_satisfaction,
reward_points,
offers_received,
offers_redeemed,
financial_stress_score,
engagement_score,
customer_value_score,
churn_risk_score,
churn_probability,
churned,
age_group,
income_group,
engagement_group
);

-- 3.Overall customer churn analysis
SELECT
    churned,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cleaned_customer_churn), 2) AS percentage
FROM cleaned_customer_churn
GROUP BY churned;

-- 4. Gender wise churn analysis
select
    gender,
    count(*) as total_customers,
    sum(churned) as churned_customers,
    round(avg(churned)*100,2) as churned_percentage
from cleaned_customer_churn
group by gender
order by churned_percentage DESC;


-- 5. Age group by churn analysis
SELECT
    CASE
        WHEN age < 25 THEN 'Below 25'
        WHEN age BETWEEN 25 AND 35 THEN '25-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        WHEN age BETWEEN 56 AND 65 THEN '56-65'
        ELSE 'Above 65'
    END AS age_group,

    COUNT(*) AS total_customers,

    SUM(churned) AS churned_customers,

    ROUND(AVG(churned) * 100, 2) AS churn_percentage

FROM cleaned_customer_churn

GROUP BY
    CASE
        WHEN age < 25 THEN 'Below 25'
        WHEN age BETWEEN 25 AND 35 THEN '25-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        WHEN age BETWEEN 56 AND 65 THEN '56-65'
        ELSE 'Above 65'
    END

ORDER BY MIN(age);


-- 6. Card type wise churn analysis
select
   card_type,
   count(*) as total_customers,
   sum(churned) as churned_customers,
   round(avg(churned)*100,2) as churn_percentage
from cleaned_customer_churn
group by card_type
order by churn_percentage desc;


-- 7. Income group by churn analysis
SELECT
    income_group,
    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers,
    ROUND(AVG(churned) * 100, 2) AS churn_percentage

FROM (
    SELECT
        income,
        churned,
        CASE
            WHEN income < 30000 THEN 'Below 30K'
            WHEN income < 50000 THEN '30K-50K'
            WHEN income < 75000 THEN '50K-75K'
            WHEN income < 100000 THEN '75K-100K'
            WHEN income < 150000 THEN '100K-150K'
            ELSE 'Above 150K'
        END AS income_group
    FROM cleaned_customer_churn
) AS customer_income

GROUP BY income_group
ORDER BY MIN(income);


-- 8. payment delay count
select 
  case
      when payment_delay_count = 0 then 'No delay'
      when payment_delay_count between 1 and 2 then '1-2 delay'
      when payment_delay_count between 3 and 5 then '3-5 delay'
      else 'Above 5 delay'
	end as payment_delay_group,
    count(*) as total_customers,
    sum(churned) as churned_customers,
    round(avg(churned)*100,2) as churn_percentage
from cleaned_customer_churn
group by
   case
      when payment_delay_count = 0 then 'No delay'
      when payment_delay_count between 1 and 2 then '1-2 delay'
      when payment_delay_count between 3 and 5 then '3-5 delay'
      else 'Above 5 delay'
	end
order by MIN(payment_delay_count);


-- 9.customer engagement churn analysis
SELECT
    engagement_group,
    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers,
    ROUND(AVG(churned) * 100, 2) AS churn_percentage
FROM cleaned_customer_churn
GROUP BY engagement_group
ORDER BY churn_percentage DESC;

-- 10. Monthly churn analysis
SELECT
    CASE
        WHEN monthly_spending < 1000 THEN 'Below 1K'
        WHEN monthly_spending < 3000 THEN '1K-3K'
        WHEN monthly_spending < 5000 THEN '3K-5K'
        ELSE 'Above 5K'
    END AS spending_group,
    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers,
    ROUND(AVG(churned) * 100, 2) AS churn_percentage
FROM cleaned_customer_churn
GROUP BY spending_group
ORDER BY MIN(monthly_spending);


-- 11.Customer service call analysis
SELECT
    CASE
        WHEN customer_service_calls = 0 THEN 'No Calls'
        WHEN customer_service_calls BETWEEN 1 AND 2 THEN '1-2 Calls'
        WHEN customer_service_calls BETWEEN 3 AND 5 THEN '3-5 Calls'
        ELSE 'Above 5 Calls'
    END AS service_call_group,
    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers,
    ROUND(AVG(churned) * 100, 2) AS churn_percentage
FROM cleaned_customer_churn
GROUP BY service_call_group
ORDER BY MIN(customer_service_calls);
