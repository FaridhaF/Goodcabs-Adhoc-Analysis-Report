# Goodcabs-Adhoc-Analysis-Report

**Goodcabs: A Cab Service Company, has gained a strong foothold in the Indian market by focusing on Tier 2 cities. Unlike other cab service providers, Goodcabs is committed to:**

-Supporting local drivers, helping them make a sustainable living in their hometowns.

-Ensuring excellent service to passengers.

**With operations in ten Tier 2 cities across India, Goodcabs has set ambitious performance targets for 2024 to drive growth and improve passenger satisfaction.**

**Key Metrics to Assess Performance**

The Goodcabs management team aims to assess the company's performance across the following key metrics:

* Trip Volume

* Passenger Satisfaction

* Repeat Passenger Rate

* Trip Distribution

* Targeting New Passengers

# Business Request-1: City-Level Fare and Trip Summary Report

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
**Report**
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
**Sample Report**
| City Name      | Month Name | Actual Trips | Target Trips | Performance Status | Percent Difference |
|----------------|------------|--------------|--------------|--------------------|---------------------|
| Visakhapatnam  | January    | 3,100        | 4,500        | Below Target       | -31.1%              |
| Chandigarh     | January    | 4,991        | 7,000        | Below Target       | -28.7%              |
| Surat          | January    | 7,006        | 9,000        | Below Target       | -22.2%              |
| Vadodara       | January    | 4,061        | 6,000        | Below Target       | -32.3%              |
| Mysore         | January    | 992          | 2,000        | Below Target       | -50.4%              |
| Kochi          | January    | 4,154        | 7,500        | Below Target       | -44.6%              |
| Indore         | January    | 4,898        | 7,000        | Below Target       | -30.0%              |
| Jaipur         | January    | 8,897        | 13,000       | Below Target       | -31.6%              |

**Report Link** https://github.com/FaridhaF/Goodcabs-Adhoc-Analysis-Report/blob/main/2.%20monthly%20city%20level%20trips%20target%20performance%20report.csv

# Business Request-3: City-Level Repeat Passenger Trip Frequency Report
**Query**
<pre>
'''SELECT city_name,
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
GROUP BY city_name'''
</pre>

**Report**
| City Name      | 2-Trips | 3-Trips | 4-Trips | 5-Trips | 6-Trips | 7-Trips | 8-Trips | 9-Trips | 10-Trips |
|----------------|---------|---------|---------|---------|---------|---------|---------|---------|----------|
| Visakhapatnam  | 51.3%   | 25.0%   | 10.0%   | 5.4%    | 3.2%    | 2.0%    | 1.4%    | 0.9%    | 0.9%     |
| Chandigarh     | 32.3%   | 19.3%   | 15.7%   | 12.2%   | 7.4%    | 5.5%    | 3.5%    | 2.3%    | 1.8%     |
| Surat          | 9.8%    | 14.3%   | 16.6%   | 19.7%   | 18.5%   | 11.9%   | 6.2%    | 1.7%    | 1.4%     |
| Vadodara       | 9.9%    | 14.2%   | 16.5%   | 18.1%   | 19.1%   | 12.9%   | 5.8%    | 2.0%    | 1.6%     |
| Mysore         | 48.7%   | 24.4%   | 12.7%   | 5.8%    | 4.1%    | 1.8%    | 1.4%    | 0.5%    | 0.5%     |
| Kochi          | 47.7%   | 24.4%   | 11.8%   | 6.5%    | 3.9%    | 2.1%    | 1.7%    | 1.2%    | 0.8%     |
| Indore         | 34.3%   | 22.7%   | 13.4%   | 10.3%   | 6.8%    | 5.2%    | 3.3%    | 2.4%    | 1.5%     |
| Jaipur         | 50.1%   | 20.7%   | 12.1%   | 6.3%    | 4.1%    | 2.5%    | 1.9%    | 1.2%    | 1.0%     |
| Coimbatore     | 11.2%   | 14.8%   | 15.6%   | 20.6%   | 17.6%   | 10.5%   | 6.2%    | 2.3%    | 1.2%     |
| Lucknow        | 9.7%    | 14.8%   | 16.2%   | 18.4%   | 20.2%   | 11.3%   | 6.4%    | 1.9%    | 1.1%     |

# Business Request-4: Identify City with Highest and Lowest Total New Passengers
**Query**
<pre>
'''WITH cte1 AS
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

SELECT city_name,new_passengers,city_category FROM cte3'''
</pre>
**Report**
| City Name      | New Passengers | City Category |
|----------------|----------------|---------------|
| Jaipur         | 45,856         | Top 3         |
| Kochi          | 26,416         | Top 3         |
| Chandigarh     | 18,908         | Top 3         |
| Lucknow        | 16,260         | NULL          |
| Indore         | 14,863         | NULL          |
| Visakhapatnam  | 12,747         | NULL          |
| Mysore         | 11,681         | NULL          |
| Surat          | 11,626         | Bottom 3      |
| Vadodara       | 10,127         | Bottom 3      |
| Coimbatore     | 8,514          | Bottom 3      |

# Business Request-5: Identify Month with Highest Revenue for each City
**Query**
<pre>
'''WITH aggregated_revenue AS
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
WHERE rank_num=1'''
</pre>
**Report**
| City Name      | Highest Revenue Month | Revenue    | Percentage Contribution |
|----------------|-----------------------|------------|-------------------------|
| Chandigarh     | February              | 2,108,290  | 19.1%                   |
| Coimbatore     | April                 | 612,431    | 17.4%                   |
| Indore         | May                   | 1,380,996  | 18.1%                   |
| Jaipur         | February              | 7,747,202  | 20.8%                   |
| Kochi          | May                   | 3,333,746  | 19.6%                   |
| Lucknow        | February              | 1,777,269  | 18.8%                   |
| Mysore         | May                   | 745,170    | 18.4%                   |
| Surat          | April                 | 1,154,909  | 18.0%                   |
| Vadodara       | April                 | 706,250    | 18.6%                   |
| Visakhapatnam  | April                 | 1,390,682  | 17.3%                   |

# Business Request-6: Repeat Passenger Rate Analysis
**Query**
<pre>
'''WITH repeat_passengers AS
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
FROM monthly_repeat_passengers'''	
</pre>
**Sample Report**
| City Name      | Month     | Total Passengers | Repeat Passengers | Monthly Repeat Passenger Rate | City Repeat Passenger Rate |
|----------------|-----------|------------------|-------------------|-------------------------------|----------------------------|
| Chandigarh     | February  | 4,957            | 853               | 17.2%                         | 3.6%                       |
| Chandigarh     | January   | 4,640            | 720               | 15.5%                         | 3.0%                       |
| Chandigarh     | March     | 4,100            | 872               | 21.3%                         | 3.6%                       |
| Chandigarh     | April     | 3,285            | 789               | 24.0%                         | 3.3%                       |
| Chandigarh     | May       | 3,699            | 969               | 26.2%                         | 4.0%                       |
| Chandigarh     | June      | 3,297            | 867               | 26.3%                         | 3.6%                       |
| Coimbatore     | June      | 1,628            | 402               | 24.7%                         | 3.6%                       |
| Coimbatore     | April     | 1,722            | 480               | 27.9%                         | 4.3%                       |
| Coimbatore     | March     | 1,965            | 427               | 21.7%                         | 3.9%                       |

**Report Link** 
https://github.com/FaridhaF/Goodcabs-Adhoc-Analysis-Report/blob/main/6.repeat%20passenger%20rate%20analysis.csv
