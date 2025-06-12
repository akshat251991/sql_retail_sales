CREATE DATABASE Sales;

--create a table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
			transactions_id INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(6),
			age INT,
			category VARCHAR(25),
			quantiy INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT
);

select * from retail_sales
limit 10

select count(*) from retail_sales


select * from retail_sales
where sale_date is null

select * from retail_sales
where sale_time is null


select * from retail_sales
where transactions_id is null

or sale_date is null

or sale_time is null

or customer_id is null

or gender is null

or age is null

or category is null

or quantiy is null

or price_per_unit is null

--delete null values

delete from retail_sales
where 

	transactions_id is null

or sale_date is null

or sale_time is null

or customer_id is null

or gender is null

or age is null

or category is null

or quantiy is null

or price_per_unit is null


or cogs is null

or total_sale is null

--EDA

--How many sales we have

select count(*) as total_sales from retail_sales

--How many customers we have?

select count(distinct customer_id) as total_customers from retail_sales

--How many categories we have?

select count(distinct category) as total_category from retail_sales

--Data Analysis and Business Key Problems and annswers

--Q1. Write a query to retrieve all columns for sales made on 2022-11-05?
select * from retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is
--'Clothing'and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
where category='Clothing'
and to_char(sale_date,'yyyy-mm')='2022-11'
and quantiy>=4
--and sale_date >= '2022-11-01'
--and sale_date <= '2022-11-30'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as Total_Net_sales from retail_sales
group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category,round(avg(age),2) as Average_age_customers
from retail_sales
where category='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,count(*) as total_txns
from retail_sales
group by 1,2
order by category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from
(
select extract(year from sale_date) as Years,
		extract(month from sale_date) as Months,
		avg(total_sale) as Average_Total_Sales,
		rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as ranking
		from retail_sales
		group by 1,2
		--order by 1,3 desc
) as t1
where ranking=1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,sum(total_sale) as Total_Sales
from retail_sales
group by customer_id
order by sum(total_sale) desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id) as unique_customers
from retail_sales
group by 1

-- Q.10 Write a SQL query to create each shift and number of orders
--(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

select * from retail_sales

with hourly_sales as
(
select *, case
			when extract(hour from sale_time)<=12 then 'Morning shift'
			when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
			else 'Evening'
		end as Shift
		from retail_sales

)

select Shift,count(*) as total_orders from hourly_sales
group by Shift










