/*
Find out the average spending stats within each generation
*/

with stats as (
select 
    u.id as user_id,
    case
		when year(birth_date) between 2013 and 2025 then 'Gen Alpha'
		when year(birth_date) between 1995 and 2012 then 'Gen Z'
		when year(birth_date) between 1980 and 1994 then 'Millennials'
		when year(birth_date) between 1965 and 1979 then 'Gen X'
		when year(birth_date) between 1946 and 1964 then 'Baby Boomers'
        else 'other'
    end as generation,
    count(t.receipt_id) as total_receipts,
    sum(t.final_sale) as total_spent,
    max(t.scan_date) as last_scan_date
	from users u 
	left join transaction t 
	on u.id = t.user_id
	group by u.id, generation
	having count(t.receipt_id) > 0 or sum(t.final_sale) > 30
	order by total_spent desc, total_receipts desc
)
select generation, round(avg(total_spent), 2) as avg_spent, 
	round(avg(total_receipts), 2) as avg_receipts,
    round(sum(total_spent) / sum(total_receipts), 2) as spent_per_receipts
from stats
group by generation

