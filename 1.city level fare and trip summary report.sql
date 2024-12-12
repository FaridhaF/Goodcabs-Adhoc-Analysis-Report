**SQL Query Block**
"""WITH cte1 AS
(SELECT city_name,
	   COUNT(trip_id) AS total_trips,
       SUM(distance_travelled_km) AS total_distance,
       SUM(fare_amount) AS total_fare
FROM dim_city c
JOIN fact_trips ft
ON c.city_id=ft.city_id
GROUP BY city_name)

SELECT city_name,
	   total_trips,
       ROUND((total_fare/total_distance),2) AS avg_fare_per_km,
       ROUND((total_fare/total_trips),2) AS avg_fare_per_trip,
       CONCAT(ROUND(total_trips*100/SUM(total_trips) OVER(),1),"%") AS percent_contribution_to_totaltrips
FROM cte1"""

**Attach CSV File**:
   - The `[Link](./query_result.csv)`
