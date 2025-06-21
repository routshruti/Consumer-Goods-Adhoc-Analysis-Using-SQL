# SQL Portfolio Project: Consumer Goods Ad-hoc Analysis

## Introduction
Atliq, a prominent computer hardware manufacturer, wants to evaluate the overall performance of the year 2021 in comparison to the preceding year, 2020.

## Business Problem
Despite having a significant amount of data, they lack the necessary insights for quick decision-making. They want to understand any variations in sales figures, market segments, and customer behaviors between the two years.

## Goal
By leveraging historical sales data and customer insights, Atliq's executive management team aims to identify trends, patterns, and areas of opportunity. They seek to gain actionable insights to make better decisions and improve performance over the next year.

## Stakeholder(s)
- Data Analytics Director
- Management Team

## Data Source
The following csv files were imported into MySQL database.

𝗱𝗶𝗺_𝗰𝘂𝘀𝘁𝗼𝗺𝗲𝗿: Details about customers (e.g., name, region, platform).

𝗱𝗶𝗺_𝗽𝗿𝗼𝗱𝘂𝗰𝘁: Information on products (e.g., product code, category, division).

𝗳𝗮𝗰𝘁_𝘀𝗮𝗹𝗲𝘀_𝗺𝗼𝗻𝘁𝗵𝗹𝘆: Monthly sales data (e.g., quantity sold, fiscal year).

𝗳𝗮𝗰𝘁_𝗴𝗿𝗼𝘀𝘀_𝗽𝗿𝗶𝗰𝗲: Gross price data for products across fiscal years.

𝗳𝗮𝗰𝘁_𝗺𝗮𝗻𝘂𝗳𝗮𝗰𝘁𝘂𝗿𝗶𝗻𝗴_𝗰𝗼𝘀𝘁: Manufacturing costs for products in different years.

𝗳𝗮𝗰𝘁_𝗽𝗿𝗲_𝗶𝗻𝘃𝗼𝗶𝗰𝗲_𝗱𝗲𝗱𝘂𝗰𝘁𝗶𝗼𝗻𝘀: Discount percentage data for customers before invoicing

## Business Questions

1. **Market Insights:** Which markets does "Atliq Exclusive" operate in within the APAC region?
2. **Year-over-Year Product Growth:** What is the percentage of unique products increase from 2020 to 2021?
3. **Segment Product Count:** Which segments had the most unique products? Sort by product count.
4. **Segment Growth Comparison:** Which segment saw the biggest increase in unique products from 2020 to 2021?
5. **Cost Insights:** Which products have the highest and lowest manufacturing costs?
6. **Discount Insights:** Which top 5 customers in India got the highest pre-invoice discount in FY 2021?
7. **Gross Sales Analysis:** What were the gross sales for "Atliq Exclusive" each month?
8. **Quartely Sales Performance:** Which quarter of 2020 saw the highest total sold quantity?
9. **Channel Analysis:** Which channel contributed the most to gross sales in FY 2021?
10. **Top Products in Each Division:** What were the top 3 products with the highest sales in each division for FY 2021?

## Tools

- **MySQL**: Used for **data analysis**. SQL was employed to query and analyze the data, perform data transformations, and extract meaningful insights for the 10 business questions.

- **Power BI**: Utilized for **data visualization**. Power BI enabled the creation of an interactive dashboard to effectively visualize data trends and patterns, facilitating data-driven decision-making.

- **Canva**: Used for **presentation design**. Canva was leveraged to design visually appealing presentation slides to communicate project findings and insights in a clear and enagaging manner.
