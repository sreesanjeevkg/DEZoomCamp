Repo for learning and projects for the Data Engineering Zoomcamp 2024.

HW1 
1. docker run --help
2. docker run -it python:3.9 bash, pip list | grep wheel
3. select count(*) from "greenTaxiData" where DATE(lpep_pickup_datetime) = '2019-09-18' and DATE(lpep_dropoff_datetime) = '2019-09-18';
4. select DATE(lpep_pickup_datetime) from "greenTaxiData" where trip_distance = ( Select MAX(trip_distance) from "greenTaxiData");
5. with cte as ( select * from "greenTaxiData" inner join "taxiZones" on "greenTaxiData"."PULocationID" = "taxiZones"."LocationID") select "Borough", SUM(total_amount) from cte where DATE(lpep_pickup_datetime)='2019-09-18'
  group by "Borough" having SUM(total_amount) > 50000;
6.select "DOLocationID" from "greenTaxiData" where "PULocationID" = 7 and tip_amount = (select MAX(tip_amount) from "greenTaxiData" where "PULocationID" = 7) -- output = 132  ---------  select * from "taxiZones" where "LocationID" = 132;
7. terraform apply -auto--approve
