## 📊 US Candy Distribution Analysis (2021–2024)
This project explores sales data from a US-based candy distributor across four years (2021 to 2024). Using SQL and Tableau, I examined business performance across products, divisions, states, and factories to deliver meaningful insights to stakeholders.

# 🔍 Objectives
The main goal was to answer key business questions, including:

- How have total year-to-date sales changed from 2021 to 2024?

- Which US states generated the most profit from non-chocolate sales?

- Did each product division meet its 2024 sales target?

- What were the best and worst-performing chocolate products in 2024?

- Which factory and state combinations led in gross profit or underperformed?

# 🧮 Tools Used
SQL (MySQL): To clean, query, and analyse the dataset

Tableau: For data visualisation and stakeholder reporting

Excel: For light data inspection and data dictionary reference

# 📁 Datasets Used
The project joins together the following CSVs:

- Candy_Sales.csv – transaction-level sales data

- Candy_Products.csv – product metadata

- Candy_Targets.csv – 2024 sales targets by division

- Candy_Factories.csv – factory location and mapping

- uszips.csv – US ZIP code to state/region mapping

# 🧠 Key Business Questions Answered
1. Year-to-date sales trend from 2021 to 2024

2. Top-performing US states for non-chocolate sales and margins

3. Five states with the highest non-chocolate gross profit in 2024

4. Division-level performance against 2024 sales targets

5. Top three chocolate products by gross profit in 2024

6. Underperforming chocolate products vs division average

7. Total 2024 sales by product

8. Factory-state combinations with the highest gross profit (Chocolate)

9. Factory-state combinations with the lowest gross profit (all divisions)

# 💡 Key Insights for Stakeholders
- 📈 Sales & Growth
  YTD sales grew consistently from ~$28k in 2021 to ~$46k in 2024.

Indicates growing demand and strong sales momentum.

- 🌎 State & Regional Performance
  The Pacific region led the US in both profit and sales in 2024.

  New York, California, and Illinois topped non-chocolate profit, while Ohio and Georgia had the highest margins (~50%).

- 🎯 Division Performance
  Chocolate smashed its 2024 target by 57%.

  The other division exceeded the target by 11%.

  Sugar division missed badly, hitting under 1% of its £15k goal.

- 🍫 Product Breakdown
  Top Performers: Scrumdiddlyumptious, Triple Dazzle Caramel, Milk Chocolate.

  Underperformers: Nutty Crunch Surprise and Fudge Mallows underachieved compared to the average.

- 🏭 Factory-Level Results
  Best: Lot’s O’ Nuts in California generated over £3.6k in profit.

  Worst: The Other Factory (Delaware, Alabama) and Sugar Shack (Pennsylvania) produced under £2.

- 🧁 Product Breadth
  Chocolate dominates both in profit and unit sales.

  ‘Sugar’ and ‘Other’ divisions brought minimal revenue and require further evaluation.

# 📊 Tableau Visualisations
- Sales by Factory & Division (bar)

- Sales vs Target by Division (bar + line)

- Monthly Sales Trend by Division (line)

- Sales by US State (map)

- KPI cards

- Final Interactive Dashboard
