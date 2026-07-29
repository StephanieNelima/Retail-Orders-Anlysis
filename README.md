# Retail Orders — Documentation 

**Overview**

I built this notebook as an ETL pipeline rather than an analytical one. I loaded a raw orders CSV of 9,994 records, cleaned and reshaped it, derived a few pricing fields, and loaded the result into a MySQL table. I did not include any exploratory analysis, visualization, or summary statistics, so there are no analytical findings to report beyond what the transformation itself reveals.

**Data loading**

I read orders.csv with pandas, treating the strings "Not Available" and "unknown" as missing values on load. The source table covers order-level retail transactions with fields for order date, ship mode, customer segment, geography (country, city, state, postal code, region), product category and sub-category, product ID, cost price, list price, quantity, and discount percent.

**Column cleanup**

I lowercased the column headers and replaced spaces with underscores, giving a consistent snake_case schema (order_id, order_date, ship_mode, segment, country, city, state, postal_code, region, category, sub_category, product_id, cost_price, list_price, quantity, discount_percent).

**Derived fields**

I calculated three new columns: discount (list_price times discount_percent, scaled by 0.01), sale_price (list_price minus discount), and profit (sale_price minus cost_price). I then dropped cost_price, list_price, and discount_percent, leaving discount, sale_price, and profit as the retained pricing fields.

**Loading to MySQL**

I wrote the cleaned dataframe to a local MySQL database (retaildata) as table df_orders via SQLAlchemy with pymysql, replacing any existing table of that name. My connection block hardcodes a username, password, host, and port in plain text.

