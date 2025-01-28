select 
    p.Brand,
    round(sum(t.final_sale), 2) as Total_sales,
    round(sum(t.final_quantity), 0) as Total_Quantity
from products p
join transaction t on p.barcode = t.barcode
where p.category_2 = 'Dips & Salsa' and p.brand != ''
group by p.brand
order by total_sales desc
limit 10;

/* Which is the leading brand in the Dips & Salsa category?
Calculate the leading brands based on their total sales.

The leading brand between June 12th and September 8th is Tostitos.
The other 3 brands that also sold well are:
1. Fritos
2. Fresh Cravings
3. Old El Paso


Result of the Query:
Brand		  , Total_sales, Total_Quantity
TOSTITOS	  , 103354.84  , 23424
FRITOS  	  , 82566.81   , 18724
FRESH CRAVINGS, 82514.05   , 18701
OLD EL PASO   , 82475.08   , 18691
GOOD FOODS    , 61975.2    , 14034
HERDEZ		  , 61904.63   , 14030
LITEHOUSE	  , 61894.23   , 14024
WHOLLY		  , 61884.38   , 14022
BOAR'S HEAD   , 61875.27   , 14020
MISSION       , 61862.87   , 14019


*/