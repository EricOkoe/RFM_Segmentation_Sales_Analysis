-- Inspecting the data
SELECT * 
FROM [dbo].[sales_data]

-- CHecking unique values
SELECT DISTINCT STATUS FROM [dbo].[sales_data] 
SELECT DISTINCT YEAR_ID FROM [dbo].[sales_data]
SELECT DISTINCT PRODUCTLINE FROM [dbo].[sales_data] 
SELECT DISTINCT COUNTRY FROM [dbo].[sales_data] 
SELECT DISTINCT DEALSIZE FROM [dbo].[sales_data] 
SELECT DISTINCT TERRITORY FROM [dbo].[sales_data] 

-- Checking for missing values
SELECT *
FROM [dbo].[sales_data]
WHERE TERRITORY IS NULL

-- Checking for duplicates
SELECT COUNT(ORDERNUMBER), COUNT(DISTINCT ORDERNUMBER)
FROM [dbo].[sales_data]
-- We found duplicates in the ORDERNUMBER

-- Investigating the duplicates
SELECT * 
FROM [dbo].[sales_data]
WHERE ORDERNUMBER = 10100
-- Each duplicates had unique ORDERLINENUMBER hence we will not drop the duplicated ORDERNUMBERS
----------------------------------------------------------------------------------------------------------------------------------------------------------

-- What was the revenue generated by Productline?
SELECT PRODUCTLINE, ROUND(SUM(SALES), 2) AS Revenue
FROM [dbo].[sales_data]
GROUP BY PRODUCTLINE
ORDER BY 2 DESC

-- What was the revenue generated over the Years?
SELECT YEAR_ID, ROUND(SUM(SALES), 2) AS Revenue
FROM [dbo].[sales_data]
GROUP BY YEAR_ID
ORDER BY 2 DESC

-- What was the revenue generated by the Dealsizes?
SELECT DEALSIZE, ROUND(SUM(SALES), 2) AS Revenue
FROM [dbo].[sales_data]
GROUP BY DEALSIZE
ORDER BY 2 DESC

----What was the best month for sales in a specific year? How much was earned that month? 
--  Year 2003
SELECT  MONTH_ID, ROUND(SUM(SALES), 2) AS Revenue, COUNT(ORDERNUMBER)  AS "Total Orders"
FROM [dbo].[sales_data]
WHERE YEAR_ID = 2003 --change year to see the rest
GROUP BY  MONTH_ID
ORDER BY 2 DESC
-- November had the highest sales in 2003 with USD 1,029,837.66 in revenue

--  Year 2004
SELECT  MONTH_ID, ROUND(SUM(SALES), 2) AS Revenue, COUNT(ORDERNUMBER)  AS "Total Orders"
FROM [dbo].[sales_data]
WHERE YEAR_ID = 2004 --change year to see the rest
GROUP BY  MONTH_ID
ORDER BY 2 DESC
-- November recorded the most sales in 2004 with USD 1,089,048.01 in revenue

--What city has the highest number of sales in a specific country
SELECT CITY,  SUM(SALES) AS Revenue
FROM [dbo].[sales_data]
WHERE COUNTRY = 'UK'
GROUP BY CITY
ORDER BY 2 DESC

---What is the best product in United States?
SELECT Country, Year_ID, ProductLine, SUM(SALES) AS Revenue
FROM [dbo].[sales_data]
WHERE COUNTRY = 'USA'
GROUP BY  COUNTRY, YEAR_ID, PRODUCTLINE
ORDER BY 4 DESC
----------------------------------------------------------------------------------------------------------------------------------------------------------

----Who is our best customer (this could be best answered with RFM)
DROP TABLE IF EXISTS #rfm;
WITH rfm AS (
		SELECT
			CUSTOMERNAME, 
			SUM(SALES) AS MonetaryValue,
			AVG(SALES) AS AvgMonetaryValue,
			COUNT(ORDERNUMBER) AS Frequency,
			MAX(ORDERDATE) AS LastOrdeDate,
			(SELECT MAX(ORDERDATE) FROM [dbo].[sales_data]) AS MaxOrderDate,
			DATEDIFF(DD, max(ORDERDATE), (select max(ORDERDATE) from [dbo].[sales_data])) Recency
		FROM [dbo].[sales_data]
		GROUP BY CUSTOMERNAME
		),
rfm_calc AS (
		SELECT r.*,
				NTILE(4) OVER (ORDER BY Recency DESC) AS rfm_recency,
				NTILE(4) OVER (ORDER BY Frequency) AS rfm_frequency,
				NTILE(4) OVER (ORDER BY MonetaryValue) AS rfm_monetary
		FROM rfm AS r
		)	
SELECT	c.*, 
		rfm_recency+rfm_monetary+rfm_frequency AS rfm_total,
		CAST(rfm_recency AS varchar)+CAST(rfm_frequency AS varchar)+CAST(rfm_monetary AS varchar) AS rfm_string
INTO #rfm
FROM rfm_calc AS c


SELECT CUSTOMERNAME , rfm_recency, rfm_frequency, rfm_monetary,
		CASE 
			WHEN rfm_string in (111, 112, 113, 114, 121, 122, 123, 132, 211, 212, 141) then 'lost_customers'  -- lost customers
			WHEN rfm_string in (133, 134, 143, 244, 334, 343, 344, 144) then 'slipping away, cannot lose' -- (Big spenders who haven�t purchased lately) slipping away
			WHEN rfm_string in (311, 411, 331, 412) then 'new customers'
			WHEN rfm_string in (222, 223, 233, 322, 221, 232, 234) then 'potential churners'
			WHEN rfm_string in (321, 422, 332, 432, 421) then 'active_low_spenders' --(Customers who buy often & recently, but at low price points)
			WHEN rfm_string in (323, 333, 423) then 'active_high_spenders' --(Customers who buy often & recently, but at high price points)
			WHEN rfm_string in (433, 434, 443, 444) then 'loyal'
			END AS rfm_segment
INTO #rfm_segmentation
FROM #rfm


-- Analysis of the RFM segmentations
SELECT rfm_segment, COUNT(*) AS [No. of Customers]
FROM #rfm_segmentation
GROUP BY rfm_segment
ORDER BY [No. of Customers] DESC
-- Lost customers segement was the majority
----------------------------------------------------------------------------------------------------------------------------------------------------------

--What products are most often sold together? 
SELECT ORDERNUMBER, 
		STUFF(
				(
					SELECT ',' + PRODUCTCODE
					FROM [dbo].[sales_data] AS t2
					WHERE ORDERNUMBER IN 
							   (SELECT ORDERNUMBER
								FROM
									(
									SELECT ORDERNUMBER, COUNT(*) rn
									FROM [dbo].[sales_data]
									WHERE STATUS = 'Shipped'
									GROUP BY ORDERNUMBER
									) AS t1
								WHERE rn > 1
								)
						AND t2.ORDERNUMBER = t3.ORDERNUMBER
						FOR xml path ('')
				), 1, 1, ''
			 )
FROM [dbo].[sales_data] t3
ORDER BY 2 desc