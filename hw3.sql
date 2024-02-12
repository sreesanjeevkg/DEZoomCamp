CREATE OR REPLACE EXTERNAL TABLE `dezoomcamp-412116.ny_taxi_data.external_green_tripdata_2022`
OPTIONS (
  format = 'parquet',
  uris = ['gs://bucket-for-de-zoomcamp/yellow/2022/*.parquet']
);

select count(*) from `ny_taxi_data.external_green_tripdata_2022`;

create or replace table dezoomcamp-412116.ny_taxi_data.materialized_green_tripdata_2022
as select * from `ny_taxi_data.external_green_tripdata_2022`;

select count(distinct PULocationID) from `ny_taxi_data.external_green_tripdata_2022`;

select count(distinct PULocationID) from `ny_taxi_data.materialized_green_tripdata_2022`;

select count(1) from `ny_taxi_data.materialized_green_tripdata_2022` where fare_amount = 0;

create or replace table dezoomcamp-412116.ny_taxi_data.partitioned_clustered_green_tripdata_2022
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID
as
select * from `ny_taxi_data.external_green_tripdata_2022`;

select count (distinct PULocationID) from `ny_taxi_data.materialized_green_tripdata_2022`
WHERE lpep_pickup_datetime BETWEEN '2022-06-01' AND '2022-06-30';
