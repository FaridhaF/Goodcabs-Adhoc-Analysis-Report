# Goodcabs-Adhoc-Analysis-Report

**Goodcabs: A Cab Service Company, has gained a strong foothold in the Indian market by focusing on Tier 2 cities. Unlike other cab service providers, Goodcabs is committed to:**

Supporting local drivers, helping them make a sustainable living in their hometowns.

Ensuring excellent service to passengers.

**With operations in ten Tier 2 cities across India, Goodcabs has set ambitious performance targets for 2024 to drive growth and improve passenger satisfaction.**

**Key Metrics to Assess Performance**

The Goodcabs management team aims to assess the company's performance across the following key metrics:

* Trip Volume

* Passenger Satisfaction

* Repeat Passenger Rate

* Trip Distribution

* Targeting New Passengers

# Business Request-1: City-Level Farev and Trip Summary Report

**Query**
<pre>
'''WITH cte1 AS
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
FROM cte1'''
</pre>
| City Name      | Total Trips | Avg Fare per Km | Avg Fare per Trip | Percent Contribution to Total Trips |
|----------------|-------------|-----------------|-------------------|-------------------------------------|
| Visakhapatnam  | 28,366      | 12.53           | 282.67            | 6.7%                                |
| Chandigarh     | 38,981      | 12.06           | 283.69            | 9.2%                                |
| Surat          | 54,843      | 10.66           | 117.27            | 12.9%                               |
| Vadodara       | 32,026      | 10.29           | 118.57            | 7.5%                                |
| Mysore         | 16,238      | 15.14           | 249.71            | 3.8%                                |
| Kochi          | 50,702      | 13.93           | 335.25            | 11.9%                               |
| Indore         | 42,456      | 10.90           | 179.84            | 10.0%                               |
| Jaipur         | 76,888      | 16.12           | 483.92            | 18.1%                               |
| Coimbatore     | 21,104      | 11.15           | 166.98            | 5.0%                                |
| Lucknow        | 64,299      | 11.76           | 147.18            | 15.1%                               |



# Business Request-2: Monthly City Level Target Performance Report

**Query
<pre>
'''with cte1 AS
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
AND ct.month = mt.month'''
</pre>
