-- 9. Which channel contributed the most to gross sales in the fiscal year 2021
-- and what is its percentage of contribution? The final output contains these fields,
-- channel
-- gross_sales_mln
-- percentage

WITH SalesData AS
(
    SELECT
        C.channel AS channel_name,
        ROUND(SUM(G.gross_price * FS.sold_quantity / 1000000), 2) AS gross_sales_mln
    FROM fact_sales_monthly FS
    JOIN dim_customer C ON FS.customer_code = C.customer_code
    JOIN fact_gross_price G ON FS.product_code = G.product_code
    WHERE FS.fiscal_year = 2021
    GROUP BY C.channel
),
TotalSales AS
(
    SELECT SUM(gross_sales_mln) AS total_sales
    FROM SalesData
)

SELECT
    SD.channel_name AS channel,
    CONCAT(SD.gross_sales_mln, ' M') AS gross_sales_mln,
    CONCAT(ROUND(SD.gross_sales_mln * 100 / TS.total_sales, 2), ' %') AS percentage
FROM SalesData SD
JOIN TotalSales TS
ORDER BY SD.gross_sales_mln DESC;
