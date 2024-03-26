create database car_features;

use car_features;

select * from data;

-- *******************************************************************
-- Average of highway and city mileage according to company
select avg(highway_MPG)
from data;
select company, round(avg(highway_MPG), 2) as Average_Highway_Mileage
from data
group by company
order by Average_Highway_Mileage desc;
-- City
select avg(city_mpg)
from data;
select company, round(avg(city_mpg), 2) as Average_City_Mileage
from data
group by company
order by Average_City_Mileage desc;

-- Which model has best high mileage
select company as Brand, Model, highway_MPG as Mileage
from data
where highway_MPG in (select max(highway_MPG)
					  from data
					  where Engine_Fuel_Type  != "electric")
group by company, Model, Engine_Fuel_Type, highway_MPG;

-- Which model has best city mileage 
select company as Brand, Model, City_MPG as Mileage
from data
where City_MPG in (select max(City_MPG)
					  from data
					  where Engine_Fuel_Type  != "electric")
group by company, Model, Engine_Fuel_Type, City_MPG;

-- Which brand has maximun Body type?
SELECT company, MAX(cnt) as "Maximun Body Type"
FROM (
    SELECT company, COUNT(DISTINCT vehicle_style) AS cnt
    FROM data
    GROUP BY company
) AS subquery
GROUP BY company;
                        
-- What is the average highway MPG (miles per gallon) of every transmission type?
select * from data;
select Transmission_type, max(Highway_MPG) as "Highway MPG"
from (
select Transmission_type, avg(Highway_MPG) as Highway_MPG
from data
group by Transmission_Type) as subquery
group by Transmission_type;

-- Which company produces the most expensive vehicles on average?
select * from data;
with subq as
(select Company, avg(Price) as avg_price
				  from data
				  group by Company)
select * from subq
where avg_price = (select max(avg_price) from subq);

-- Which company produces the most cheapest vehicles on average?
select * from data;
with subq as
(select Company, avg(Price) as avg_price
				  from data
				  group by Company)
select * from subq
where avg_price = (select min(avg_price) from subq);

-- What is the average popularity of every company?
select * from data;
select company, round(avg(Popularity), 2) as Average_Popularity
from data
group by company
order by Average_Popularity desc;

-- How does the variation in horsepower, miles per gallon (MPG), and price differ across different car brands?
select * from data;
select Company, round(avg(highway_MPG), 2) as Average_Highway_Mileage, round(avg(city_mpg), 2) as Average_City_Mileage, round(avg(Engine_HP), 2) as Horsepower, round(avg(Price),2) as avg_price
from data
group by Company;