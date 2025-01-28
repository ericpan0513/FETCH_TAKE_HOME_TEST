with user_spending as (
    select u.id, sum(t.final_sale) as Total_Spent
    from  users u left join transaction t on u.id = t.user_id
    group by u.id
),
-- find average customer spending
average_spending as (
    select avg(total_spent) as avg_spending
    from user_spending
),
-- get the number of total users that have transactions
total_users as (
	select count(distinct u.id) as total_active_users
    from users u join transaction t on u.id = t.user_id
),
-- rank the users based on total spendings
ranked_users as (
	select us.id, us.total_spent, rank() over (order by total_spent desc) as rk
	from user_spending us 
)
-- find the power users who are on top 5% based on spending and also spent more than average
select ru.id, round(ru.total_spent, 2) as Total_Spent, ru.rk as active_rank
from ranked_users ru join average_spending avg_sp
	join total_users tu
where ru.rk  <= 0.05 * tu.total_active_users and ru.total_spent > avg_sp.avg_spending



/*Who are Fetch’s power users?
"Power Users" Definition:
who are on top 5% based on spending and also spent more than average

Result of the Query:
id, 						Total_Spent, active_rank
643059f0838dd2651fb27f50,   75.99, 		 1
62ffec490d9dbaff18c0a999,   52.28, 		 2
5f4c9055e81e6f162e3f6fa8,   37.96, 		 3
5d191765c8b1ba28e74e8463,   34.96, 		 4

*/