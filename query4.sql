-- 4. Follow-up: Which segment had the most increase in unique products in
-- 2021 vs 2020? The final output contains these fields,
-- segment
-- product_count_2020
-- product_count_2021
-- difference

WITH Products_2020 AS 
    (SELECT P.segment AS segment, COUNT(DISTINCT FS.product_code) AS product_count_2020
    FROM dim_product P
    JOIN fact_sales_monthly FS ON P.product_code = FS.product_code
    WHERE FS.fiscal_year = 2020
    GROUP BY P.segment
    ),
Products_2021 AS
    (SELECT P.segment AS segment, COUNT(DISTINCT FS.product_code) AS product_count_2021
    FROM dim_product P
    JOIN fact_sales_monthly FS ON P.product_code = FS.product_code
    WHERE FS.fiscal_year = 2021
    GROUP BY P.segment
    )
    
SELECT 
    p2020.segment AS segment, 
    p2020.product_count_2020, 
    p2021.product_count_2021, 
    (p2021.product_count_2021 - p2020.product_count_2020) AS difference  
FROM Products_2020 p2020
JOIN Products_2021 p2021 ON p2020.segment = p2021.segment
ORDER BY difference DESC;
