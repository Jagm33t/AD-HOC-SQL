-- 8. In which quarter of 2020, got the maximum total_sold_quantity? The final
-- output contains these fields sorted by the total_sold_quantity,
-- Quarter
-- total_sold_quantity

SELECT 
    CASE
        WHEN MONTH(date) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(date) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(date) BETWEEN 7 AND 9 THEN 'Q3'
        WHEN MONTH(date) BETWEEN 10 AND 12 THEN 'Q4'
    END AS Quarter,
    SUM(sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year = 2020
GROUP BY Quarter
ORDER BY total_sold_quantity DESC;

SELECT 
CASE
    WHEN date BETWEEN '2019-09-01' AND '2019-11-01' then CONCAT('[',1,'] ',MONTHNAME(date))  
    WHEN date BETWEEN '2019-12-01' AND '2020-02-01' then CONCAT('[',2,'] ',MONTHNAME(date))
    WHEN date BETWEEN '2020-03-01' AND '2020-05-01' then CONCAT('[',3,'] ',MONTHNAME(date))
    WHEN date BETWEEN '2020-06-01' AND '2020-08-01' then CONCAT('[',4,'] ',MONTHNAME(date))
    END AS Quarters,
    SUM(sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year = 2020
GROUP BY Quarters
