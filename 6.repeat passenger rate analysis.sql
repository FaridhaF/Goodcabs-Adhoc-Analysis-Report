WITH repeat_passengers AS
(SELECT city_name,
	   MONTHNAME(month) AS month,
	   SUM(total_passengers) AS total_passengers,
       SUM(repeat_passengers) AS repeat_passengers
FROM dim_city c
JOIN fact_passenger_summary ps
ON c.city_id = ps.city_id
GROUP BY city_name,month),

monthly_repeat_passengers AS
(SELECT *,
	   CONCAT(ROUND((repeat_passengers*100/total_passengers),1),"%") AS monthly_repeat_passenger_rate
FROM repeat_passengers)

SELECT *,
	   CONCAT(ROUND(repeat_passengers*100/SUM(total_passengers) OVER (PARTITION BY city_name),1),"%") AS city_repeat_passenger_rate 
FROM monthly_repeat_passengers

