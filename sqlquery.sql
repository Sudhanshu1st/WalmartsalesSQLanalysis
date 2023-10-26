create database if not exists salesDataWalmart;

create table if not exists sales(
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

-- -------------------------------------------------------------------------------------------------
-- -------------------------------Feature Engineering-----------------------------------------------

-- time_of_day

SELECT 
     time,
     (case 
          WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

alter table sales add column time_of_day  varchar(20);


update sales
set time_of_day=(
     case
         WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END);

-- Add day_name column

select
      date,
	dayname(date) from sales;
alter table   sales add column day_name varchar(10);

update sales 
set day_name = dayname(date);

-- Add month column

select 
       date,
       monthname(date)
	from sales;
    
alter table sales add column month_name varchar(10);

update sales
set month_name = monthname(date);

-- ----------------------------------------------------------------------------
-- --------------------------GENERIC-------------------------------------------
-- How many unique cities does the data have?

select distinct city from sales;

-- In which city is each branch?

select distinct city, branch from sales;

-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?

SELECT DISTINCT product_line FROM sales;

-- What is the most selling product?

select sum(quantity)as qty, product_line 
from sales
group by product_line
order by qty desc;

--  What is the total revenue by month
select 
     month_name as month,
     sum(total) as total_revenue
 from sales
 group by month_name
 order by total_revenue;
 
 
-- What month has the largest COG?
select 
     month_name as month,
     sum(cogs) as cogs
 from sales
 group by month_name
 order by cogs;
 
 -- what product has the largest revenue?
 
 select 
        product_line,
        sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;


-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;


-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(tax) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;


-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

select 
   avg(quantity) as qty
from sales;


select product_line,
         case 
               when avg(quantity) > 6 then "Good"
			else "bad" 
	    end as remark 
from sales
group by product_line;

-- Which branch sold more products than average product sold?

SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);


-- What is the most common line by gender? 

select 
      gender,
      product_line,
      count(gender) as total_cnt
from sales
group by gender, product_line
order by total_cnt desc
      
      
- What is the average rating of each product line
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?

select distinct customer_type from sales;

-- How many unique payment methods does the data have?

SELECT DISTINCT payment_method FROM sales;

-- What is the most common customer type?

select 
      customer_type,
      count(*) as count
from sales
group by customer_type
order by count desc;

--  Which customer type buys the most?

select 
       customer_type,
       count(*)
from sales
group by customer_type;

-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Gender per branch is more or less the same hence, So
-- I don't think it has an effect of the sales per branch and other factors.

-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter


-- Which time of the day do customers give most ratings per branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.


-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the case, how many sales are made on these days?



-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;
-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 
select 
     time_of_day,
     count(*) as total_sales
from sales 
-- where day_name = 'Sunday'
group by time_of_day
order by total_sales desc;

-- Evenings experience most sales, the stores are 
-- filled during the evening hours

-- Which of the customer types brings the most revenue?

select 
    customer_type,
    sum(total) as total_rev
from sales
group by customer_type 
order by total_rev desc;



-- --------------------------------------------------------------------
-- --------------------------------------------------------------------



   
        

    
    
    

















