with cte1 AS
(SELECT c.city_id,
	    city_name,
	    start_of_month AS month,
	    COUNT(trip_id) AS actual_trips
FROM dim_city c
JOIN fact_trips ft
ON c.city_id = ft.city_id
JOIN dim_date dt 
ON ft.date= dt.start_of_month
GROUP BY c.city_id,city_name,start_of_month)

SELECT city_name,
	   MONTHNAME(ct.month) AS month_name,
       actual_trips,
       mt.total_target_trips AS target_trips,
       CASE
       WHEN actual_trips>mt.total_target_trips THEN "Above Target"
       WHEN actual_trips<=mt.total_target_trips THEN "Below Target"
       END AS performance_status,
       CONCAT(ROUND((actual_trips-mt.total_target_trips)*100/mt.total_target_trips,1),"%") AS percent_difference
FROM cte1 ct
JOIN targets_db.monthly_target_trips mt 
ON ct.city_id = mt.city_id
AND ct.month = mt.month

