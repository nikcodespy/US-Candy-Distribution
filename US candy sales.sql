-- "Which U.S. regions generated the highest gross profit in 2024, and how do they compare in terms of sales volume, profit margin, and total orders?"

SELECT Region, ROUND(SUM(Sales),2) AS total_sales, ROUND(SUM(`Gross Profit`),2) AS total_gross,
	ROUND(SUM(`Gross Profit`)/SUM(Sales)*100,2) AS profit_margin_pct, COUNT(*) AS total_orders
FROM candy_sales
WHERE YEAR(`Order Date`) = '2024'
GROUP BY Region
ORDER BY total_gross DESC;

-- "How have total year-to-date sales changed annually from 2021 to 2024, and are we seeing consistent growth?"

WITH roll AS (SELECT MONTH(`Order Date`) AS mnth_num,
					monthname(`Order Date`) AS mnth,
					YEAR(`Order Date`) AS yr,
					ROUND(SUM(Sales),2) AS total_sales,
					ROUND(SUM(`Gross Profit`),2) AS total_gross
				FROM candy_sales
				GROUP BY yr, mnth, mnth_num
				ORDER BY yr, mnth_num),

ytd AS (SELECT *,
			ROUND(SUM(total_sales) OVER(PARTITION BY yr ORDER BY mnth_num),2) AS ytd_sales
		FROM roll)
        
SELECT yr, ytd_sales
FROM ytd
WHERE mnth_num = 12;

-- "Which US states are generating the most gross profit from non-chocolate candy divisions in 2024, and how do their profit margins compare?"

SELECT `State/Province`, Division, ROUND(SUM(Sales),2) AS total_sales, ROUND(SUM(`Gross Profit`),2) AS total_gross_profit,
		ROUND(SUM(`Gross Profit`)/SUM(Sales)*100,2) AS profit_margin_pct
FROM candy_sales
WHERE Division != 'Chocolate'
AND YEAR(`Order Date`) = '2024'
GROUP BY `State/Province`, Division
ORDER BY total_gross_profit DESC
LIMIT 8;

-- "Which five US states brought in the highest gross profit from non-chocolate candy sales in 2024, and what were their profit margins?"

SELECT `State/Province`, Division, ROUND(SUM(Sales),2) AS total_sales, ROUND(SUM(`Gross Profit`),2) AS total_gross_profit,
		ROUND(SUM(`Gross Profit`)/SUM(Sales)*100,2) AS profit_margin_pct
FROM candy_sales
WHERE Division != 'Chocolate'
AND YEAR(`Order Date`) = '2024'
GROUP BY `State/Province`, Division
ORDER BY total_gross_profit DESC
LIMIT 5;

-- "Did each product division meet its 2024 sales target, and by how much did they over- or underperform?"

WITH target AS (SELECT cs.Division, cs.Sales, cs.`Order Date`,
				ct.Target
				FROM candy_sales cs LEFT JOIN candy_targets ct
					ON cs.Division = ct.Division
				WHERE YEAR(`Order Date`) = 2024)
                
SELECT Division, ROUND(SUM(Sales),2) AS total_sales, Target,
	ROUND(SUM(sales)/target * 100, 2) AS target_met_pct
FROM target
GROUP BY Division, Target;

-- "What are the top three chocolate products in 2024 based on gross profit?

WITH choc AS (SELECT `Product Name`, ROUND(SUM(Sales),2) AS total_sales, ROUND(SUM(`Gross Profit`),2) AS total_gross
				FROM candy_sales
				WHERE Division = 'Chocolate' AND YEAR(`Order Date`) = 2024
				GROUP BY `Product Name`),
                
	rnk AS (SELECT `Product Name`, total_sales, total_gross,
				   RANK() OVER (ORDER BY total_gross DESC) AS rnk
			FROM choc)
            
SELECT `Product Name`, total_gross
FROM rnk
WHERE rnk IN (1,2,3);

-- "Which chocolate products underperformed compared to the division's average gross profit in 2024?"

WITH choc AS (SELECT `Product Name`, ROUND(SUM(`Gross Profit`),2) AS total_gross
				FROM candy_sales
				WHERE Division = 'Chocolate' AND YEAR(`Order Date`) = 2024
				GROUP BY `Product Name`),
                
	avg_choc AS (SELECT ROUND(AVG(total_gross),2) AS avg_gross_profit
			FROM choc)

SELECT c.`Product Name`, c.total_gross,
	ac.avg_gross_profit
FROM choc c CROSS JOIN avg_choc ac
WHERE c.total_gross < ac.avg_gross_profit
ORDER BY c.total_gross DESC;

-- "What were the total sales for each product in 2024?"

SELECT 
    `Product Name`,
    YEAR(`Order Date`) AS yr,
    ROUND(SUM(Sales), 2) AS total_sales
FROM candy_sales
WHERE YEAR(`Order Date`) = 2024
GROUP BY `Product Name`, yr
ORDER BY `Product Name`, yr;

-- "Which factory and state combinations generated the highest gross profit in the chocolate division during 2024?"

SELECT  cs.`State/Province`, cs.Division, cp.Factory,
	ROUND(SUM(cs.Sales), 2) AS total_sales, 
    ROUND(SUM(cs.`Gross Profit`), 2) AS total_gross_profit, 
    ROUND(SUM(cs.Units), 2) AS total_units, 
    ROUND(SUM(cs.Cost), 2) AS total_cost
FROM candy_sales cs LEFT JOIN candy_products cp
	ON cs.`Product ID` = cp.`Product ID`
WHERE YEAR(`Order Date`) = 2024
GROUP BY cs.`State/Province`, cs.Division, cp.Factory
ORDER BY total_gross_profit DESC
LIMIT 10;

-- "Which factory and state combinations generated the lowest gross profit in 2024, and what divisions are they from?"

SELECT  cs.`State/Province`, cs.Division, cp.Factory,
	ROUND(SUM(cs.Sales), 2) AS total_sales, 
    ROUND(SUM(cs.`Gross Profit`), 2) AS total_gross_profit, 
    ROUND(SUM(cs.Units), 2) AS total_units, 
    ROUND(SUM(cs.Cost), 2) AS total_cost
FROM candy_sales cs LEFT JOIN candy_products cp
	ON cs.`Product ID` = cp.`Product ID`
WHERE YEAR(`Order Date`) = 2024
GROUP BY cs.`State/Province`, cs.Division, cp.Factory
ORDER BY total_gross_profit ASC
LIMIT 10;