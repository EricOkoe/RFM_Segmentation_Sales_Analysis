# RFM_Segmentation_Sales_Analysis

## Intoduction
This analysis presents a comprehensive overview of sales performance and customer insights for the years 2003 to 2005. The dashboard serves as a powerful tool for visualizing key metrics and trends, enabling data-driven decision-making for the Turbo Charge Auto PLC. Through this analysis, we delve into various aspects of sales data, including product line performance, deal size distribution, geographical sales distribution, and customer churn segments. Additionally, we identify major sales drivers across different territories, cities, and product lines.

By examining these critical components, the analysis aims to uncover actionable insights that can guide strategic initiatives to enhance sales performance, optimize marketing efforts, and improve customer retention. This report highlights the most significant findings and provides recommendations to leverage strengths and address areas of concern within the sales and customer relationship landscape.

## Methodology for the Analysis
For this project, we will be using 
  - SQL for cleaning, transformation and exploratory data analysis
  - Power BI for data modelling and visualization.

**Data Cleaning**
Clean the dataset by filling in missing values, correcting wrongly spelt values, and removing duplicates.

**Data Transformation**
Create new columns based on the recency of the customer's purchase, the total monetary value spent by each customer; and the frequency (number of purchases) for each customer.

**Create RFM Score**
We analyze customers based on how recently (R), how often (F), and how much (M) they purchase. Each customer is ranked for each of these factors, and these ranks are combined into an RFM score. This score helps us group customers into segments.

**Exploratory Data Analysis**
   - Revenue by Year, Product Line, Deal Size, and City: Calculate the total revenue for each combination of these dimensions.
   - Identify the year, product line, deal size, and city with the highest revenue.
   - Sales Trend: Track how revenue and quantity ordered have changed over time.
   - Products Sold Together (Product Affinity): Analyze which products are frequently purchased together in the same transactions.

### Visualization
![Screenshot 2024-05-29 221514](https://github.com/EricOkoe/World_Layoffs_Analysis_MYSQL/assets/80605648/da6f9560-19fe-4cc3-b1de-2b44d1d3196b)

## Insights

### Sales Performance Insights

**Overall Sales Trend:**
   - There was a significant increase in sales and quantity ordered in the year 2003, especially towards the end of the year. This indicates a period of high demand or successful sales strategies during this time.

**Product Line Performance:**
   - **Classic Cars** and **Vintage Cars** are the dominant product lines, contributing the most to the sales revenue.
   - **Motorcycles**, **Trucks and Buses**, **Planes**, and **Ships** also contribute to the sales but to a lesser extent compared to Classic and Vintage Cars.

**Deal Size Distribution:**
   - The majority of sales come from medium-sized deals (2.18M), followed by small deals (0.91M) and large deals (0.43M). This suggests that the company is more successful with medium-sized transactions.

**Sales Distribution:**
   - The histogram indicates that most sales transactions are concentrated below 0.1M. This could imply a high volume of smaller transactions rather than fewer large ones.

### Geographic Insights

**Sales by Country**
   - Sales are highly concentrated in the EMEA (Europe, Middle East, and Africa) region, with significant contributions from North America (NA) and APAC (Asia-Pacific).
   - Key cities with high sales include **Madrid** (EMEA), **San Rafael** (NA), and **NYC** (NA).

### Customer Insights

**Churn Analysis**
   - The **lost customers** segment is the largest, indicating a high churn rate that needs to be addressed.
   - **Potential churn** and **slipping away** segments also need attention to prevent further losses.
   - **Loyal customers** and **active high spenders** are smaller segments, suggesting that efforts to increase customer loyalty and high-value customers could be beneficial.

### Sales Drivers Insights

**Territory and City Contributions**
   - The EMEA region is the highest contributor to sales, followed by North America and APAC.
   - Madrid is a major sales hub within the EMEA region.

**Product Line Contributions**
   - Within the top-performing product lines, **Classic Cars** and **Vintage Cars** stand out in specific cities and territories, indicating their strong market presence.

### Recommendations

**Customer Retention Strategies**
   - Focus on reducing churn by targeting the **lost customers**, **potential churn**, and **slipping away** segments with retention campaigns and personalized offers.

**Market Expansion**
   - Consider expanding successful strategies from high-performing regions like EMEA to other regions.
   - Investigate opportunities to grow sales in North America and APAC further.

**Sales Strategy Optimization**
   - Analyze the reasons behind the spike in sales in late 2003 and replicate successful strategies during that period.
   - Continue to focus on medium-sized deals while exploring ways to increase the number of large deals.

**Product Line Focus**
   - Invest in and promote high-performing product lines like Classic Cars and Vintage Cars.
   - Explore ways to boost sales for other product lines such as Motorcycles and Trucks and Buses.
