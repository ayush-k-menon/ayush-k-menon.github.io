



-- Data preparation

-- Cleaning Products table
CREATE VIEW products_clean AS 
SELECT 
	product_key,
	product_name,
	brand,
	color,
	
	CAST(
		TRIM(
			REPLACE(
				REPLACE(unit_cost_usd,'$',''),
				',',''
			)
		)
		AS NUMERIC(10,2))
		AS unit_cost_usd,
		
	CAST(
		TRIM(
			REPLACE(
				REPLACE(unit_price_usd,'$',''),
				',',''
			)
		)
		AS NUMERIC(10,2))
		AS unit_price_usd,
		
	sub_category_key,
	sub_category,
	category_key,
	category
FROM products;


SELECT *
FROM products_clean;


SELECT 
	column_name,
	data_type
FROM information_schema.COLUMNS
WHERE table_name = 'products_clean';





-- Cleaning Customers table
CREATE VIEW customers_clean AS 

SELECT
	customer_key,
	gender,
	name,
	INITCAP(city) AS city,
	state_code,
	state,
	zip_code,
	country,
	continent,
	
	CASE
		WHEN birthday LIKE '%-%'
			THEN TO_DATE(birthday,'MM-DD-YYYY')
			
		WHEN birthday LIKE '%/%'
			THEN TO_DATE(birthday,'MM/DD/YYYY')
	END AS birthday
	
FROM customers;


SELECT * FROM customers_clean;


SELECT 
	column_name,
	data_type
FROM information_schema.COLUMNS
WHERE table_name = 'customers_clean';





-- Cleaning Stores table
CREATE VIEW stores_clean AS

SELECT 
	store_key,
	country,
	state,
	square_meters,
	
	CASE
		WHEN open_date LIKE '%-%'
			THEN TO_DATE(open_date,'MM-DD-YYYY')
		
		WHEN open_date LIKE '%/%'
			THEN to_date(open_date,'MM/DD/YYYY')
	END AS open_date

FROM stores;


SELECT * FROM stores_clean;


SELECT 
	column_name,
	data_type
FROM information_schema.COLUMNS
WHERE table_name = 'stores_clean';





-- Cleaning Sales table
CREATE VIEW sales_clean AS

SELECT
	order_number,
	line_item,
	
	CASE
		WHEN order_date LIKE '%-%'
			THEN TO_DATE(order_date,'MM-DD-YYYY')
		
		WHEN order_date LIKE '%/%'
			THEN TO_DATE(Order_date,'MM/DD/YYYY')
	END AS order_date,
	
	CASE
		WHEN delivery_date LIKE '%-%'
			THEN to_date(delivery_date,'MM-DD-YYYY')
			
		WHEN delivery_date LIKE '%/%'
			THEN to_date(delivery_date,'MM/DD/YYYY')
	END AS delivery_date,
	
	customer_key,
	store_key,
	product_key,
	quantity,
	currency_code

FROM sales;
	

SELECT * FROM sales_clean;


SELECT
	column_name,
	data_type
FROM information_schema.COLUMNS
WHERE table_name = 'sales_clean';




















