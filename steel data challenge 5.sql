-- 1. How many pubs are located in each country??
SELECT country, count(*) as total_pubs
FROM pubs
group by country;

/*
| country        | total_pubs |
| -------------- | ---------- |
| United Kingdom | 1          |
| Ireland        | 1          |
| United States  | 1          |
| Spain          | 1          |
*/

-- 2. What is the total sales amount for each pub, including the beverage price and quantity sold?
WITH beverage_details AS ( --add beverage details to each sale
    SELECT s.*, b.price_per_unit, (b.price_per_unit * quantity) AS revenue
    FROM beverages b
    JOIN sales s
    ON b.beverage_id = s.beverage_id
    )
      
SELECT pub_name, sum(quantity) as total_units_sold, sum(revenue) as total_earned
FROM pubs p
JOIN beverage_details bd
ON p.pub_id = bd.pub_id
GROUP BY pub_name;

/*
| pub_name       | total_units_sold | total_earned |
| -------------- | ---------------- | ------------ |
| The Red Lion   | 34               | 532.66       |
| The Dubliner   | 38               | 308.62       |
| The Cheers Bar | 43               | 413.57       |
| La Cerveceria  | 28               | 337.72       |
*/

-- 3. Which pub has the highest average rating?
SELECT pub_name, round(avg(rating),2) as avg_rating
FROM pubs p
JOIN ratings r
ON p.pub_id = r.pub_id
GROUP BY pub_name
ORDER BY avg_rating DESC;
-- The Red Lion pub has the highest, with an average rating of: 4.67.

-- 4. What are the top 5 beverages by sales quantity across all pubs?
SELECT beverage_name, sum(quantity) as total_qty_sold
FROM beverages b
JOIN sales s
ON b.beverage_id = s.beverage_id
GROUP BY beverage_name
ORDER BY total_qty_sold DESC
LIMIT 5;

/*
| beverage_name | total_qty_sold |
| ------------- | -------------- |
| Guinness      | 55             |
| Mojito        | 30             |
| Chardonnay    | 18             |
| Tequila       | 18             |
| IPA           | 14             |
*/

-- 5. How many sales transactions occurred on each date?
SELECT transaction_date, count(*) as total_sales
FROM sales
GROUP BY transaction_date
ORDER BY transaction_date;
/*
| transaction_date | total_sales |
| ---------------- | ----------- |
| 2023-05-01       | 3           |
| 2023-05-02       | 2           |
| 2023-05-03       | 4           |
| 2023-05-04       | 1           |
| 2023-05-06       | 1           |
| 2023-05-09       | 5           |
| 2023-05-11       | 2           |
| 2023-05-12       | 1           |
| 2023-05-13       | 1           |
*/

-- 6. Find the name of someone that had cocktails and which pub they had it in.




-- 7. What is the average price per unit for each category of beverages, excluding the category 'Spirit'?
-- 8. Which pubs have a rating higher than the average rating of all pubs?
-- 9. What is the running total of sales amount for each pub, ordered by the transaction date?
-- 10. For each country, what is the average price per unit of beverages in each category, and what is the overall average price per unit of beverages across all categories?
-- 11. For each pub, what is the percentage contribution of each category of beverages to the total sales amount, and what is the pub's overall sales amount?
