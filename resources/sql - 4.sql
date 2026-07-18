




-- Business Analysis
CREATE VIEW sales_analytics AS

SELECT 
	-- Sales
	s.order_number,
	s.order_date,
	s.quantity,
	
	s.quantity * p.unit_price_usd 
		AS revenue,
		
	s.quantity * p.unit_cost_usd 
		AS cost,
		
	s.quantity * 
		(p.unit_price_usd - p.unit_cost_usd) 
		AS profit,

	-- Products
	p.product_name,
	p.brand,
	p.color,
	p.unit_cost_usd,
	p.unit_price_usd,
	p.sub_category,
	p.category,

	-- Customers
	c.customer_key,
	c.gender,
	c.birthday,

	-- Stores
	st.country,
	st.state,
	st.square_meters
	
FROM sales_clean s

JOIN products_clean p
	ON s.product_key = p.product_key

JOIN customers_clean c
	ON s.customer_key = c.customer_key
	
JOIN stores_clean st
	ON s.store_key = st.store_key;


SELECT * FROM sales_analytics;





-- KPI
SELECT
	sum(revenue) AS total_revenue,
	sum(cost) AS total_cost,
	sum(profit) AS total_profit,
	
	round(sum(profit) * 100.0
		/sum(revenue),2)
		AS profit_margin,
	
	count(DISTINCT order_number) 
		AS total_orders,
		
	sum(quantity) AS total_quantities_sold,
		
	count(DISTINCT customer_key)
		AS unique_customers,
	
	round(sum(revenue)
		/count(DISTINCT order_number),2)
		AS average_order_value

FROM sales_analytics;





-- Business Questions

-- What is the yearly revenue and profit trend?
SELECT
	extract(YEAR FROM order_date)
		AS year,
		
	sum(revenue) AS revenue,
	sum(profit) AS profit,
	
	round(sum(profit) * 100.0
		/sum(revenue),2)
		AS profit_margin

FROM sales_analytics
GROUP BY YEAR
Order BY YEAR;

-- Which brands generate the highest revenue and profit?
SELECT
	brand,
	sum(revenue) AS revenue,
	sum(profit) AS profit,
	
	round(sum(profit) * 100.0
		/sum(revenue),2)
		AS profit_margin
		
FROM sales_analytics
GROUP BY brand
ORDER BY revenue DESC;

-- Which product categories generate the highest revenue and profit?
SELECT
	category,
	sum(revenue) AS revenue,
	sum(profit) AS profit,
	
	round(sum(profit) * 100.0
		/sum(revenue),2)
		AS profit_margin

FROM sales_analytics
GROUP BY category
ORDER BY revenue DESC;

-- Which product sub categories generate the highest revenue and profit?
SELECT
	sub_category,
	sum(revenue) AS revenue,
	sum(profit) AS profit,
	
	round(sum(profit) * 100.0
		/sum(revenue),2)
		AS profit_margin

FROM sales_analytics
GROUP BY sub_category
ORDER BY revenue DESC
LIMIT 15;

-- Which individual products generate the highest revenue and profit?
SELECT
	product_name,
	sum(revenue) AS revenue,
	sum(profit) AS profit,
	
	round(sum(profit) * 100.0
		/sum(revenue),2)
		AS profit_margin

FROM sales_analytics
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 15;

-- Which product has the highest revenue within each subcategory?
WITH ranked AS
(
	SELECT
		sub_category,
		product_name,
		sum(revenue) AS revenue,
		
		dense_rank() OVER
			(PARTITION BY sub_category
			ORDER BY sum(revenue) DESC)
			AS product_rank
	
	FROM sales_analytics
	GROUP BY sub_category, product_name
)
SELECT *
FROM ranked
WHERE product_rank = 1
ORDER BY revenue desc;

-- Which countries generate the highest revenue and profit?
SELECT
	country,
	sum(revenue) AS revenue,
	sum(profit) AS profit,
	
	round(sum(profit) * 100.0
		/sum(revenue),2)
		AS profit_margin

FROM sales_analytics
GROUP BY country
ORDER BY revenue DESC;

-- Which states generate the highest revenue and profit?
SELECT
	state,
	sum(revenue) AS total_revenue,
	sum(profit) AS total_profit,
	
	round(sum(profit) * 100.0
		/sum(revenue),2)
		AS profit_margin

FROM sales_analytics
GROUP BY state
LIMIT 15;

-- Which customer age groups contribute the most revenue and profit?
WITH customer_ages as
(
	SELECT 
		EXTRACT(YEAR FROM AGE(order_date, birthday))
			AS age,
		revenue,
		profit
	FROM sales_analytics
)
SELECT

	CASE
		WHEN age < 13
			THEN 'Below 13'
			
		WHEN age BETWEEN 13 AND 19
			THEN '13 - 19'
			
		WHEN age BETWEEN 20 AND 35
			THEN '20 - 35'
			
		WHEN age BETWEEN 36 AND 55
			THEN '36 - 55'
			
		ELSE 'Above 56'
	END AS age_group,
	
	sum(revenue) AS revenue,
	sum(profit) AS profit

FROM customer_ages
GROUP BY age_group
ORDER BY revenue desc;

-- How do physical and online stores compare in revenue and profit?
SELECT
	
	CASE
		WHEN country = 'Online'
			THEN 'Online Store'
			
		WHEN country <> 'Online'
			THEN 'Physical Store'
	END AS store_type,
	
	sum(revenue) AS revenue,
	sum(profit) AS profit

FROM sales_analytics
GROUP BY store_type;
















