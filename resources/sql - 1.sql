

CREATE DATABASE project_1;

-- Renaming table column names

-- Customers table
alter table customers
rename column "CustomerKey" to customer_key;

alter table customers
rename column "Gender" to gender;

alter table customers
rename column "Name" to name;

alter table customers
rename column "City" to city;

alter table customers
rename column "State Code" to state_code;

alter table customers
rename column "State" to state;

alter table customers
rename column "Zip Code" to zip_code;

alter table customers
rename column "Country" to country;

alter table customers
rename column "Continent" to continent;

alter table customers
rename column "Birthday" to birthday;

-- Products Table
alter table products
rename column "ProductKey" to product_key;

alter table products
rename column "Product Name" to product_name;

alter table products
rename column "Brand" to brand;

alter table products
rename column "Color" to color;

alter table products
rename column "Unit Cost USD" to unit_cost_usd;

alter table products
rename column "Unit Price USD" to unit_price_usd;

alter table products
rename column "SubcategoryKey" to sub_category_key;

alter table products
rename column "Subcategory" to sub_category;

alter table products
rename column "CategoryKey" to category_key;

alter table products
rename column "Category" to category;

-- Sales Table
ALTER TABLE sales 
RENAME COLUMN "Order Number" TO order_number;

alter table sales
rename column "Line Item" to line_item;

alter table sales
rename column "Order Date" to order_date;

alter table sales
rename column "Delivery Date" to delivery_date;

alter table sales
rename column "CustomerKey" to customer_key;

alter table sales
rename column "StoreKey" to store_key;

alter table sales
rename column "ProductKey" to product_key;

alter table sales
rename column "Quantity" to quantity;

alter table sales
rename column "Currency Code" to currency_code;

-- Stores Table
alter table stores
rename column "StoreKey" to store_key;

alter table stores
rename column "Country" to country;

alter table stores
rename column "State" to state;

alter table stores
rename column "Square Meters" to square_meters;

alter table stores
rename column "Open Date" to open_date;












