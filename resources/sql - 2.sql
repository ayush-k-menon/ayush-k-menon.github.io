




-- Data Quality Assessment

-- Checking Completeness

-- Customers
SELECT 
	COUNT(*) AS total_rows,

	COUNT(*) FILTER(
		WHERE customer_key IS NULL
	) AS missing_customer_key,
	
	COUNT(*) FILTER(
		WHERE gender IS NULL
		OR TRIM(gender) = ''
	) AS missing_gender,
	
	COUNT(*) FILTER(
		WHERE name IS NULL
		OR TRIM(name) = ''
	) AS missing_name,
	
	COUNT(*) FILTER(
		WHERE city IS NULL
		OR TRIM(city) = ''
	) AS missing_city,
	
	COUNT(*) FILTER(
		WHERE state_code IS NULL
		OR TRIM(state_code) = ''
	) AS missing_state_code,
	
	COUNT(*) FILTER(
		WHERE state IS NULL
		OR TRIM(state) = ''
	) AS missing_state,
	
	COUNT(*) FILTER(
		WHERE zip_code IS NULL
		OR TRIM(zip_code) = ''
	) AS missing_zip_code,
	
	COUNT(*) FILTER(
		WHERE country IS NULL
		OR TRIM(country) = ''
	) AS missing_country,
	
	COUNT(*) FILTER(
		WHERE continent IS NULL
		OR TRIM(continent) = ''
	) AS missing_continent,
	
	COUNT(*) FILTER(
		WHERE birthday IS NULL
		OR TRIM(birthday) = ''
	) AS missing_birthday

FROM customers;

-- Products
SELECT 
	COUNT(*) AS total_rows,

	COUNT(*) FILTER(
		WHERE product_key IS NULL
	) AS missing_product_key,
	
	COUNT(*) FILTER(
		WHERE product_name IS NULL
		OR TRIM(product_name) = ''
	) AS missing_product_name,
	
	COUNT(*) FILTER(
		WHERE brand IS NULL
		OR TRIM(brand) = ''
	) AS missing_brand,
	
	COUNT(*) FILTER(
		WHERE color IS NULL
		OR TRIM(color) = ''
	) AS missing_color,
	
	COUNT(*) FILTER(
		WHERE unit_cost_usd IS NULL
		OR TRIM(unit_cost_usd) = ''
	) AS missing_unit_cost_usd,
	
	COUNT(*) FILTER(
		WHERE unit_price_usd IS NULL
		OR TRIM(unit_price_usd) = ''
	) AS missing_unit_price_usd,
	
	COUNT(*) FILTER(
		WHERE sub_category_key IS NULL
	) AS missing_sub_category_key,
	
	COUNT(*) FILTER(
		WHERE sub_category IS NULL
		OR TRIM(sub_category) = ''
	) AS missing_sub_category,
	
	COUNT(*) FILTER(
		WHERE category_key IS NULL
	) AS missing_category_key,
	
	COUNT(*) FILTER(
		WHERE category IS NULL
		OR TRIM(category) = ''
	) AS missing_category

FROM products;


-- Sales
select
count(*) as total_rows,

count(*) filter(
	WHERE order_number IS null
) AS missing_order_number,

count (*) filter(
	where line_item is NULL
) as missing_line_item,

count (*) filter(
	where order_date is null 
	or trim(order_date) = ''
) as missing_order_date,

count(*) filter(
	WHERE delivery_date IS NULL
	OR trim(delivery_date) = ''
) AS missing_delivery_date,

count (*) filter(
	where customer_key is NULL
) as missing_customer_key,

count (*) filter(
	where store_key is NULL
) as missing_store_key,

count (*) filter(
	where product_key is NULL
) as missing_product_key,

count (*) filter(
	where quantity is NULL
) as missing_quantity,

count (*) filter(
	where currency_code is null 
	or trim(currency_code) = ''
) as missing_currency_code

from sales;

-- Stores
SELECT 
	COUNT(*) AS total_rows,

	COUNT(*) FILTER(
		WHERE store_key IS NULL
	) AS missing_store_key,
	
	COUNT(*) FILTER(
		WHERE country IS NULL
		OR TRIM(country) = ''
	) AS missing_country,
	
	COUNT(*) FILTER(
		WHERE state IS NULL
		OR TRIM(state) = ''
	) AS missing_state,
	
	COUNT(*) FILTER(
		WHERE square_meters IS NULL
	) AS missing_square_meters,
	
	COUNT(*) FILTER(
		WHERE open_date IS NULL
		OR TRIM(open_date) = ''
	) AS missing_open_date
	
FROM stores;





-- Checking Uniqueness

-- Customer Key
SELECT customer_key,
	   COUNT(*)
FROM customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Product Key
SELECT product_key,
	   COUNT(*)
FROM products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Store Key
SELECT store_key,
	   COUNT(*)
FROM stores
GROUP BY store_key
HAVING COUNT(*) > 1; 





-- Checking Accuracy

-- Quantity
SELECT *
FROM sales
WHERE quantity <= 0;

-- Square Meters
SELECT * 
FROM stores
WHERE square_meters < 1;





-- Checking Consistency

-- Customer Key
SELECT DISTINCT s.customer_key 
FROM sales s
LEFT JOIN customers c
ON c.customer_key = s.customer_key 
WHERE c.customer_key IS NULL;

-- Product Key
SELECT DISTINCT s.product_key
FROM sales s
LEFT JOIN products p
ON s.product_key = p.product_key 
WHERE p.product_key IS NULL;

-- Store Key
SELECT DISTINCT s.store_key 
FROM sales s
LEFT JOIN stores st
ON s.store_key = st.store_key 
WHERE st.store_key IS NULL;





	
	   
















