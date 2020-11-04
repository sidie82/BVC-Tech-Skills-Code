--Select, select distinct, and alter commands--	

SELECT * from car_make_model

SELECT DISTINCT Make
	FROM car_make_model;

ALTER TABLE car_make_model
	ADD Year_Bought int;

ALTER TABLE car_make_model
	ADD Year_Sold int;

SELECT Engine_cc, CarYear, Make, Model, cylinders
	FROM car_make_model
	ORDER BY Make,CarYear;


SELECT Engine_cc, CarYear, Make, Model, cylinders
	FROM car_make_model
	WHERE Make='Ford' AND Model='Explorer';


SELECT Engine_cc, CarYear, Make, Model, cylinders
	FROM car_make_model
	WHERE Make='Ford' OR Model='Explorer';


SELECT Engine_cc, CarYear, Make, Model, cylinders
	FROM car_make_model
	WHERE CarYear BETWEEN 2004 AND 2011;

SELECT Engine_cc, CarYear, Make, Model, cylinders
	FROM car_make_model
	WHERE NOT model='Explorer';


SELECT Engine_cc, CarYear, Make, Model, cylinders
	FROM car_make_model
	WHERE NOT model='Explorer' AND Engine_cc >= '2000';


--Update commands--

SELECT * from car_make_model

UPDATE car_make_model
SET Year_Bought='2012'
WHERE Model='306';





SELECT * FROM au_flights_201912;


--Test code--
Select *
FROM au_flights_201912
WHERE City1='Perth';

------Class Exercise------


USE au_flights_201912


ALTER TABLE au_flights_201912
add ID int identity (1,1);

ALTER TABLE au_flights_202009
add ID int identity (1,1);

--Joins--

SELECT City1, City2, Passemger_Trips, Passenger_Load_Factor
from au_flights_201912
INNER JOIN


SELECT * FROM au_flights_201912

WHERE Aircraft_Trips between 50 and 100
INTERSECT
SELECT * FROM au_flights_201912
WHERE Distance_GC_km between 1000 and 2000;



--Class Project--


SELECT * FROM CO2_Emissions_Canada;
ALTER TABLE CO2_Emissions_Canada
add ID int identity (1,1);


