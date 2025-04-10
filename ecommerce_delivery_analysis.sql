CREATE TABLE delivery_data (
    item_identifier TEXT,
    item_fat_content TEXT,
    item_type TEXT,
    outlet_establishment_year INTEGER,
    outlet_identifier TEXT,
    outlet_location_type TEXT,
    outlet_size TEXT,
    outlet_type TEXT,
    item_visibility NUMERIC(6,4),
    item_weight NUMERIC(5,2),
    sales NUMERIC(10,4),
    rating NUMERIC(3,1)
);


select * from delivery_data

--1. What are the top 5 selling items by total sales?
SELECT item_identifier, SUM(sales) AS total_sales
FROM delivery_data
GROUP BY item_identifier
ORDER BY total_sales DESC
LIMIT 5;


--2. What is the average sales per item type?
SELECT item_type, AVG(sales) AS avg_sales
FROM delivery_data
GROUP BY item_type
ORDER BY avg_sales DESC;


--3. Which outlet has the highest total sales?
SELECT outlet_identifier, SUM(sales) AS total_sales
FROM delivery_data
GROUP BY outlet_identifier
ORDER BY total_sales DESC
LIMIT 1;


--4. How do outlet sizes compare in terms of average rating?
SELECT outlet_size, ROUND(AVG(rating), 2) AS avg_rating
FROM delivery_data
GROUP BY outlet_size
ORDER BY avg_rating DESC;


--5. List all item types with total sales above 1 million
SELECT item_type, SUM(sales) AS total_sales
FROM delivery_data
GROUP BY item_type
HAVING SUM(sales) > 1000000
ORDER BY total_sales DESC;


--6. Find the year in which the oldest outlet was established
SELECT MIN(outlet_establishment_year) AS oldest_year
FROM delivery_data;


--7. Which outlet type has the highest number of items sold (count)?
SELECT outlet_type, COUNT(*) AS total_items_sold
FROM delivery_data
GROUP BY outlet_type
ORDER BY total_items_sold DESC;


--8. What is the average item weight and visibility per item fat content?
SELECT item_fat_content,
       ROUND(AVG(item_weight), 2) AS avg_weight,
       ROUND(AVG(item_visibility), 4) AS avg_visibility
FROM delivery_data
GROUP BY item_fat_content;


--9. Get the top 3 outlets with the highest average sales per item (subquery use)
SELECT outlet_identifier, ROUND(AVG(sales), 2) AS avg_sales
FROM delivery_data
GROUP BY outlet_identifier
ORDER BY avg_sales DESC
LIMIT 3;


--10. Create a view to monitor performance of outlets (view usage)
CREATE VIEW outlet_performance AS
SELECT outlet_identifier,
       outlet_type,
       outlet_size,
       SUM(sales) AS total_sales,
       AVG(rating) AS avg_rating
FROM delivery_data
GROUP BY outlet_identifier, outlet_type, outlet_size;

SELECT * FROM outlet_performance ORDER BY total_sales DESC;

