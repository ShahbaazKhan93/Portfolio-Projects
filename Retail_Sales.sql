create database retail_sales;
use retail_sales;
select count(*) from entire_data;
drop table entire_data;

create table retail_sales (
transactions_id INT,
    sale_date DATE,
    sale_time VARCHAR(225),
    customer_id INT,
    gender VARCHAR(225),
    age INT,
    category VARCHAR(225),
    quantity INT,
    price_per_unit INT,
    cogs INT,
    total_sale INT,
    PRIMARY KEY (transactions_id)
);

select count(*) from retail_sales;
drop table retail_sales;
select count(*) from retail_sales;

#Q0) How many customers do we have?
select count(customer_id) as total_customers from retail_sales;

select distinct category from retail_sales;

**#Q1) retreive all columns for the sales made on '2022-11-01'**
select * from retail_sales where sale_date = '2022-11-01';

#Q2) retreive all the transactions where the category is clothing and the quantity sold is more than 10
#in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing' AND quantity >= 4 and sale_date between '2022-11-01' and '2022-11-30';

#Q3) Total sales for each category
select category, sum(total_sale) as net_sales, count(*) as total_orders
from retail_sales
group by category;

#Q4) Average age of customers who purchased from the 'Beauty' category
select category,round(avg(age),0) as Average_age
from retail_sales
where category = 'beauty'
group by category;

#Q5) Find all the transactions where the total_sale is greater than 1000
select * from retail_sales
where total_sale > '1000';

#Q6) Total number of transactions made by each gender in each category
select category,gender,count(transactions_id) as total_transactions
from retail_sales
group by category,gender
order by category,gender;

#Q7) calculate the average sale of each month, find out best selling month in each year
select * from(
select year(sale_date) as Year,month(sale_date) as Month,round(avg(total_sale),0) as average_sale,
rank() over(partition by year(sale_date) order by round(avg(total_sale),0) desc) as rank_order
from retail_sales
group by year(sale_date),month(sale_date)
) as subquery 
where rank_order = '1';

#Q8) Top 5 customers based on the highest total sales
select customer_id,sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;

#Q9) Find no. of unique customers who purchases items from each category
select category,count(distinct(customer_id)) as Count_unique_customer_id from retail_sales
group by category
order by Count_unique_customer_id;

#Q10) create each shift and number of orders(example morning <=12,afternoon 12-17,evening >17)
SELECT
    CASE
        WHEN HOUR(sale_time) <12 THEN 'Morning_Shift'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon_Shift'
        ELSE 'Evening_Shift'
    END AS shift_name,
    count(quantity) AS total_sales
FROM
    retail_sales
GROUP BY
    shift_name;
