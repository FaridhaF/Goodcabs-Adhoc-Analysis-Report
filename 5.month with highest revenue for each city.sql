WITH aggregated_revenue AS
(SELECT city_name,
	   month_name,
       SUM(fare_amount) AS revenue
FROM dim_city c
JOIN fact_trips ft
ON c.city_id=ft.city_id
JOIN dim_date dt
ON ft.date=dt.date
GROUP BY city_name,month_name),

ranked_revenue AS
(SELECT *,
	    revenue*100/SUM(revenue) OVER(PARTITION BY city_name) AS percentage_contribution,
	   RANK() OVER(PARTITION BY city_name ORDER BY revenue DESC) AS rank_num
FROM aggregated_revenue)

SELECT city_name,
	   month_name AS highest_revenue_month,
       FORMAT(revenue,0) AS revenue,
       CONCAT(ROUND(percentage_contribution,1),"%") as percentage_contribution
FROM ranked_revenue 
WHERE rank_num=1

