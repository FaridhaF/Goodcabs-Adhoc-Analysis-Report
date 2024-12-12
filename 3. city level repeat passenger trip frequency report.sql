SELECT city_name,
	   CONCAT(ROUND(SUM(CASE WHEN trip_count= "2-Trips" THEN repeat_passenger_count ELSE 0 END)*100/SUM(repeat_passenger_count),1),"%") AS "2-trips",
       CONCAT(ROUND(SUM(CASE WHEN trip_count= "3-Trips" THEN repeat_passenger_count ELSE 0 END)*100/SUM(repeat_passenger_count),1),"%") AS "3-trips",
       CONCAT(ROUND(SUM(CASE WHEN trip_count= "4-Trips" THEN repeat_passenger_count ELSE 0 END)*100/SUM(repeat_passenger_count),1),"%") AS "4-trips",
       CONCAT(ROUND(SUM(CASE WHEN trip_count= "5-Trips" THEN repeat_passenger_count ELSE 0 END)*100/SUM(repeat_passenger_count),1),"%") AS "5-trips",
       CONCAT(ROUND(SUM(CASE WHEN trip_count= "6-Trips" THEN repeat_passenger_count ELSE 0 END)*100/SUM(repeat_passenger_count),1),"%") AS "6-trips",
       CONCAT(ROUND(SUM(CASE WHEN trip_count= "7-Trips" THEN repeat_passenger_count ELSE 0 END)*100/SUM(repeat_passenger_count),1),"%") AS "7-trips",
       CONCAT(ROUND(SUM(CASE WHEN trip_count= "8-Trips" THEN repeat_passenger_count ELSE 0 END)*100/SUM(repeat_passenger_count),1),"%") AS "8-trips",
       CONCAT(ROUND(SUM(CASE WHEN trip_count= "9-Trips" THEN repeat_passenger_count ELSE 0 END)*100/SUM(repeat_passenger_count),1),"%") AS "9-trips",
       CONCAT(ROUND(SUM(CASE WHEN trip_count= "10-Trips" THEN repeat_passenger_count ELSE 0 END)*100/SUM(repeat_passenger_count),1),"%") AS "10-trips"
FROM dim_city c
JOIN dim_repeat_trip_distribution rtd 
ON c.city_id = rtd.city_id
GROUP BY city_name