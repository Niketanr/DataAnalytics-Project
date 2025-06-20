create database uber;
use uber;
create table uber_supply (
request_id int,
pickup_point varchar(20),
driver_id int,
status varchar(50),
request_date DATE,
request_time TIME,
drop_date DATE,
drop_time TIME,
time_of_day varchar(20)
);
select * from uber_request;
select Pickup_point,count(*) as total_requests from uber_request group by Pickup_point; #Total Requests per Pickup Point
select Pickup_point,count(*) as total_requests,
SUM(status='Trip Completed') as completed_trips,
ROUND(100*SUM(status='Trip Completed')/COUNT(*),2) as completion_rate
from uber_request group by Pickup_point; # Completion Rate per Pickup Point
select distinct Driver_id from uber_request where Pickup_point='Airport'; # Drivers Who Picked From Airport
select request_date,count(*) as Daily_requests from uber_Request group by Request_date order by Request_date; # Daily Requests
select Time_of_Day,count(*) as total_requests from uber_request group by Time_of_Day order by total_requests DESC; # Peak Hours by Time of Day
select Status,count(*) as total_requests from uber_request group by Status order by total_requests DESC; # Requests by Status 
select HOUR(Request_timestamp) as request_hour, count(*) as total_request from uber_request group by request_hour order by request_hour; # Hourly Demand Pattern
select Request_date,count(*) as total_requests from uber_request group by request_date order by total_requests DESC LIMIT 1; #  Date with Highest Demand
select Pickup_point,Status,count(*) as count from uber_request group by Pickup_point,Status order by Pickup_point,count DESC; #Pickup Point vs Status Matrix



