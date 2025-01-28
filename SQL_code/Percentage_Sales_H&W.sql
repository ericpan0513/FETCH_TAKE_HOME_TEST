-- Caculate generations first
with gen_calculation as (
    select u.id,
        case
            when year(birth_date) between 2013 and 2025 then 'Gen Alpha'
            when year(birth_date) between 1995 and 2012 then 'Gen Z'
            when year(birth_date) between 1980 and 1994 then 'Millennials'
            when year(birth_date) between 1965 and 1979 then 'Gen X'
            when year(birth_date) between 1946 and 1964 then 'Baby Boomers'
            else 'other'
        end as Generation,
        t.final_sale,
        p.category_1
    from users u join transaction t on u.id = t.user_id
		join products p on t.barcode = p.barcode
	where p.category_1 = 'Health & Wellness'
),
hw_sales as (
    select generation, sum(final_sale) as total_sales_by_generation
    from gen_calculation
    group by generation
),
total_hw_sales as (
    select sum(final_sale) as total_sales
    from gen_calculation
)
select 
    hws.Generation,
    round((hws.total_sales_by_generation * 100.0 / thws.total_sales), 2) as Percentage_of_Sales
from hw_sales hws join total_hw_sales thws
order by percentage_of_sales desc;


/*What is the percentage of sales in the Health & Wellness category by generation?

Result of the Query:

Generation  , Percentage_of_Sales
Millennials , 49.53
Baby Boomers, 29.87
Gen X	    , 20.6

*/