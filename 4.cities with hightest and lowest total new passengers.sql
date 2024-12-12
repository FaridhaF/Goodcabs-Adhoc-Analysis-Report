WITH cte1 AS
(SELECT city_name,
	   SUM(new_passengers) AS total_new_passengers
FROM dim_city c
JOIN fact_passenger_summary ps
ON c.city_id = ps.city_id
GROUP BY city_name),

cte2 AS
(SELECT city_name,
	   FORMAT(total_new_passengers,0) AS new_passengers,
       RANK() OVER(ORDER BY total_new_passengers DESC) AS rank_num
FROM cte1),

cte3 AS
(SELECT *,
	   CASE
       WHEN rank_num<4 THEN "Top 3"
       WHEN rank_num>7 THEN "Bottom 3"
       END AS "city_category"
FROM cte2)

SELECT city_name,new_passengers,city_category FROM cte3