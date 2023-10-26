# Walmart Sales Data Analysis

## Overview
This readme file provides an overview of the data analysis conducted on Walmart sales data using MySQL and MySQL Workbench. The analysis involves creating a database, performing various SQL queries, and conducting feature engineering to gain insights into the sales data.

## Table of Contents
- [Database Creation](#database-creation)
- [Feature Engineering](#feature-engineering)
- [Generic Analysis](#generic-analysis)
- [Product Analysis](#product-analysis)
- [Customers Analysis](#customers-analysis)
- [Sales Analysis](#sales-analysis)

## Database Creation <a name="database-creation"></a>
```sql
create database if not exists salesDataWalmart;

create table if not exists sales (
     invoice_id varchar(30) not null primary key,
     branch varchar (5) not null,
     city varchar(30) not null,
     customer_type varchar(30) not null, 
     gender varchar(30) not null,
     product_line varchar(100) not null,
     unit_price decimal(10,2) not null,
     quantity int not null,
     VAT float(6,4) not null,
     total decimal(12,4) not null,
     date datetime not null,
     time TIME not null,
     payment_method varchar(15) not null,
     cogs decimal(10,2) not null,
     gross_margin_pct float(11,9),
     gross_income decimal(12,4),
     rating float(2,1)
);
```

## Feature Engineering <a name="feature-engineering"></a>
- **Time of Day**: Created a new column "time_of_day" based on the time of the transaction.
```sql
-- Time of Day
-- ...

-- Add day_name column
-- ...

-- Add month column
-- ...
```

## Generic Analysis <a name="generic-analysis"></a>
- How many unique cities does the data have?
- In which city is each branch located?

## Product Analysis <a name="product-analysis"></a>
- How many unique product lines does the data have?
- What is the most selling product?
- What is the total revenue by month?
- What month has the largest COG?
- What product has the largest revenue?
- What is the city with the largest revenue?
- What product line had the largest VAT?
- Which product lines are considered "Good" or "Bad" based on average sales?
- Which branch sold more products than the average product sold?
- What is the most common product line by gender?
- What is the average rating of each product line?

## Customers Analysis <a name="customers-analysis"></a>
- How many unique customer types does the data have?
- How many unique payment methods does the data have?
- What is the most common customer type?
- Which customer type buys the most?
- What is the gender of most of the customers?
- Which time of the day do customers give the most ratings?
- Which time of the day do customers give the most ratings per branch?
- Which day of the week has the best average ratings?
- Which day of the week has the best average ratings per branch?

## Sales Analysis <a name="sales-analysis"></a>
- Number of sales made in each time of the day per weekday.
- Which customer type brings the most revenue?

## Conclusion
This readme provides an overview of the data analysis conducted on Walmart sales data using MySQL. The analysis includes database creation, feature engineering, and various SQL queries to extract valuable insights from the data. The findings in each section provide insights into different aspects of Walmart's sales data, including products, customers, and sales trends. These insights can be used to make informed business decisions and improve performance.
