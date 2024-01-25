--
-- @StudentID: ******
--
-- Designed for PostgreSQL with PostGIS


CREATE EXTENSION Postgis;


-- ----------------------------------------------------------------------------------------

DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS coffee_shop;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS manager;
DROP TABLE IF EXISTS customer;



-----------------------------------------------------------------------------------------
-- Define tables
-----------------------------------------------------------------------------------------

CREATE TABLE city (
    city_id		integer		PRIMARY KEY,
    city_name		text		NOT NULL,
    city_population	integer		NOT NULL	
);


CREATE TABLE coffee_shop (
    coffee_shop_id		integer		PRIMARY KEY,
    coffee_shop_name		text		NOT NULL,
    coffee_shop_opening_times	text		NOT NULL,
    coffee_shop_address		text		NOT NULL,
    coffee_shop_city		integer		NOT NULL	REFERENCES city(city_id), 
    coffe_shop_location		geography(point, 4326)	NOT NULL,
    coffe_shop_daily_visitors	integer		NOT NULL -- number of visitors daily
);


CREATE TABLE owners (
    owner_id		integer		PRIMARY KEY,
    owner_name		text		NOT NULL,
    owns_coffe_shop	integer		NOT NULL	REFERENCES coffee_shop(coffee_shop_id) -- owns a coffee shop
);


CREATE TABLE manager (
    manager_id		integer		PRIMARY KEY,
    manager_name		text		NOT NULL,
    manager_coffe_shop	integer		NOT NULL	REFERENCES coffee_shop(coffee_shop_id) -- manages a coffee shop
);


CREATE TABLE customer (
    customer_id		integer		PRIMARY KEY,
    customer_name		text		NOT NULL,
    customer_address_home text		NOT NULL,
    customer_location_home		geography(point, 4326)	NOT NULL, -- geolocation of home address
    customer_city		integer		NOT NULL	REFERENCES city(city_id),
    visited_coffee_shop		integer		NOT NULL	REFERENCES coffee_shop(coffee_shop_id), -- which coffee shop visits
    visited_coffee_shop_day	text		NOT NULL	-- which day of the week visits, one entry per visit per customer
);



-- ---------------------------------------------------------------------------------------
-- Populate tables
-- ---------------------------------------------------------------------------------------

INSERT INTO city (city_id, city_name, city_population) VALUES
(01, 'London', 7556900),
(02, 'Birmingham', 984333), 
(03, 'Liverpool', 864122), 
(04, 'Nottingham', 729977), 
(05, 'Sheffield', 685368),
(06, 'Bristol', 617280), 
(07, 'Glasgow', 591620),
(08, 'Leicester', 508916), 
(09, 'Edinburgh', 464990), 
(010, 'Leeds', 455123), 
(011, 'Cardiff', 447287), 
(012, 'Manchester', 395515) 
 
);

INSERT INTO coffee_shop (coffee_shop_id, coffee_shop_name, coffee_shop_opening_times, coffee_shop_address, coffee_shop_city, coffe_shop_location, coffe_shop_daily_visitors) VALUES
(111, 'Coffee corner', '8-16','68 Church Lane EDINBURGH EH44 4VL', 09, 'SRID=4326;POINT(-3.20778 55.92806)', 300),
(222, 'Jacks','9-16', '441 Broadway CARDIFF CF76 6SU', 011, 'SRID=4326;POINT(-3.15072 51.49088)', 250 ), 
(333, 'Happy days','10-20', '79 Alexander Road NORTH WEST LONDON NW13 7LG', 01, 'SRID=4326;POINT(-0.11327 51.43531)', 600  ),  
(444, 'Delicous', '8-21', '1 St. John’s Road LEICESTER LE94 9XJ', 08, 'SRID=4326;POINT(-1.10906 52.61943)', 200  ), 
(555, 'Double shot', '8-19', '88 Stanley Road SOUTH EAST LONDON SE57 3YC', 01, 'SRID=4326;POINT(-0.18229 51.53249)', 700  ),
(666, 'Wake up', '7-22', '37 Chester Road SHEFFIELD S9 0JC', 05, 'SRID=4326;POINT(-1.47539 53.35852)', 250  ), 
(777, 'Chez nous', '11-23', '94 Queen Street WEST LONDON W34 5EY', 01, 'SRID=4326;POINT(-0.21393 51.52797)', 480 ),
(888, 'Vicky', '12-6','8 Chester Road LIVERPOOL L13 8DH', 03, 'SRID=4326;POINT(-2.93736 53.42544)', 190 ), 
(999, 'Black n white', '8-16', '82 Springfield Road BRISTOL BS45 6FC', 06, 'SRID=4326;POINT(-2.57400 51.46099)', 560 ), 
(000, 'Coffee and cakes', '9-20', '9 Grange Road NOTTINGHAM NG24 5KJ', 04, 'SRID=4326;POINT(-1.25806 52.89912)', 100 ) 
 
);

INSERT INTO owners (owner_id, owner_name, owns_coffe_shop) VALUES
(1, 'Nikolay Yeremenko', 111),
(2, 'Jack Delany', 222),
(3, 'Martin Days', 333),
(4, 'Deborah Knightley', 444),
(5, 'Kim Double', 555),
(6, 'Lisa Wallace', 666),
(7, 'Pierre Lauraine', 777),
(8, 'Victoria Pauls', 888),
(9, 'Abraham White', 999),
(10, 'Sigismund Brun', 000)

);

INSERT INTO manager (manager_id, manager_name, manager_coffe_shop) VALUES
(1, 'Vasily Gnedoi', 111),
(2, 'Martin Delany', 222),
(3, 'Albert Gausk', 333),
(4, 'Klaudia Power', 444),
(5, 'Ewa Kozlowska', 555),
(6, 'Karen Morley', 666),
(7, 'Yin Teng', 777),
(8, 'Luca Casarosa', 888),
(9, 'Enrico Fermi', 999),
(10, 'Augustas Zukauskas', 000)

);

INSERT INTO customer (customer_id, customer_name, customer_address_home, customer_location_home, customer_city, visited_coffee_shop, visited_coffee_shop_day) VALUES
(1, 'L.S', 'Hidden', 'SRID=4326;POINT(-0.07242062896586543 51.468763152878196)', 01, 333, 'Monday'),
(2, 'K.M.', 'Hidden', 'SRID=4326;POINT(-3.173256920964213 51.47977424645843 )', 01, 222, 'Tuesday'),
(3, 'L.D.', 'Hidden', 'SRID=4326;POINT(-0.32785274438676715 51.519208528340386 )', 01, 777, 'Wednesday'),
(4, 'V.S.', 'Hidden', 'SRID=4326;POINT(-3.0256603444370174 53.39635130650231)', 03, 888, 'Monday'),
(5, 'B.K.', 'Hidden', 'SRID=4326;POINT(-1.1482688037396902 52.64084834012152 )', 08, 444, 'Tuesday'),
(6, 'P.S.', 'Hidden', 'SRID=4326;POINT(-1.4692531943495906 53.4075067092971 )', 05, 666, 'Wednesday'),
(7, 'S.R.', 'Hidden', 'SRID=4326;POINT(-2.589461745805987 51.4538181106407)', 06, 999, 'Monday'),
(8, 'M.S.', 'Hidden', 'SRID=4326;POINT(-2.5900982869569917 51.45240145449293)', 04, 000, 'Saturday'),
(9, 'S.S.', 'Hidden', 'SRID=4326;POINT(-3.19004207264893 55.94751192568251)', 09, 111, 'Monday'),
(10, 'O.N.', 'Hidden', 'SRID=4326;POINT(-3.1870444433537997 55.957766010721976)', 09, 111, 'Monday'),
(11, 'K.K.','Hidden', 'SRID=4326;POINT(-3.1731763441904453 55.95123713348797 )', 09, 111, 'Tuesday'),
(12, 'N.N.', 'Hidden', 'SRID=4326;POINT(-0.0628075923640037 51.538004381256805 )', 01, 555, 'Monday'),
(13, 'S.V.','Hidden', 'SRID=4326;POINT(-0.18915035913133124 51.51579026682862 )', 01, 555, 'Tuesday'),
(14, 'P.L.', 'Hidden', 'SRID=4326;POINT(-1.0974570346455794 52.64876421852638)', 08, 333, 'Friday'),
(15, 'S.Z.', 'Hidden', 'SRID=4326;POINT(-3.0256603444370174 53.39635130650231)',  03, 888, 'Saturday'),
(16, 'K.H.', 'Hidden','SRID=4326;POINT(-1.4638753331999916 53.39074031025384 )', 05, 666, 'Friday'),
(17, 'L.Z.', 'Hidden', 'SRID=4326;POINT(-0.12872555763391377 51.49613028437099)', 01, 777, 'Friday'),
(18, 'I.C.', 'Hidden', 'SRID=4326;POINT(-2.5933719271621616 51.45166477592246)', 06, 999, 'Friday'),
(19, 'A.G.', 'Hidden', 'SRID=4326;POINT( -2.596281829566756 51.46124067015425)', 06, 999, 'Thursday'),
(20, 'J.S.', 'Hidden', 'SRID=4326;POINT(-2.576185316085024 51.46203384939932)', 06, 999, 'Monday')

);

-----------------------------------------------------------------------------------------
-- End of DB -- queries next 
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- count records
-----------------------------------------------------------------------------------------

select count(city_id) as cities from city;
select count(coffee_shop_id) as coffee_shops from coffee_shop;
select count(owner_id) as owners from owners;
select count(manager_id) as managers from manager;
select count(customer_id) as customers from customer;

-----------------------------------------------------------------------------------------
-- Coffee shops main info
-----------------------------------------------------------------------------------------

select c.coffee_shop_name as coffee_shop, c.coffee_shop_opening_times as times_open,
c.coffee_shop_address as address, c.coffe_shop_location, o.owner_name, 
m.manager_name
from coffee_shop as c
join owners as o
on o.owns_coffe_shop = c.coffee_shop_id
join manager as m
on m.manager_coffe_shop = c.coffee_shop_id
;

-----------------------------------------------------------------------------------------
-- All coffee shops by location
-----------------------------------------------------------------------------------------

SELECT coffee_shop_name, city_name
FROM coffee_shop
inner join city on coffee_shop_city = city_id
group by coffee_shop_name, city_name
ORDER BY city_name ASC; 

-----------------------------------------------------------------------------------------
-- All coffee shops by popularity (customer visits per day)
-----------------------------------------------------------------------------------------

SELECT coffee_shop_name, coffe_shop_daily_visitors
FROM coffee_shop
ORDER BY coffe_shop_daily_visitors DESC; 

-----------------------------------------------------------------------------------------
-- Coffee shops with daily customers more than 200
-----------------------------------------------------------------------------------------

SELECT coffee_shop_name, coffe_shop_daily_visitors
FROM coffee_shop
WHERE coffe_shop_daily_visitors > 200
ORDER BY coffe_shop_daily_visitors DESC; 

-----------------------------------------------------------------------------------------
-- Customers that visited specific coffee shop
-----------------------------------------------------------------------------------------

SELECT customer_name, customer_city, visited_coffee_shop
FROM customer
ORDER BY visited_coffee_shop DESC;

-----------------------------------------------------------------------------------------
-- Days of the week mostly visited specific coffee shop
-----------------------------------------------------------------------------------------

SELECT visited_coffee_shop, visited_coffee_shop_day as day_of_the_week
FROM customer
ORDER BY visited_coffee_shop DESC;

-----------------------------------------------------------------------------------------
-- Show the SRID of spatial data in tables
-----------------------------------------------------------------------------------------

SELECT ST_SRID(coffe_shop_location) from coffee_shop; -- for each geometry
SELECT DISTINCT ST_SRID(coffe_shop_location) from coffee_shop where coffee_shop_id = 666;

-----------------------------------------------------------------------------------------
-- Show all coffee-shops & locations
-----------------------------------------------------------------------------------------

select coffee_shop_name, ST_Astext(coffe_shop_location) from coffee_shop
group by coffee_shop_name, coffe_shop_location;

-----------------------------------------------------------------------------------------
-- Locations of coffee shops and customers who visited them 
-----------------------------------------------------------------------------------------

SELECT  coffee_shop_id, coffe_shop_location, customer_id, customer_location_home, visited_coffee_shop
FROM coffee_shop
inner join customer on coffee_shop_id = visited_coffee_shop;

-----------------------------------------------------------------------------------------
-- Distances between a single customer and shop
-----------------------------------------------------------------------------------------

SELECT ST_DISTANCE(
          ST_GeographyFromText('POINT(0.11327 51.43531)'),
          ST_GeographyFromText('POINT(0.0724206289658654 51.468763152878196)')
       ) as distances_between_customer_and_shop;

-----------------------------------------------------------------------------------------
-- Distances between customers and shops in same city
-----------------------------------------------------------------------------------------
     
select b.customer_name, a.coffee_shop_name,
ST_Distance(a.coffe_shop_location::geography, b.customer_location_home::geography) / 10000 as distances_between_customer_and_shop
FROM coffee_shop as a
join customer as b
on a.coffee_shop_city = b.customer_city
order by ST_Distance(a.coffe_shop_location::geography, b.customer_location_home::geography), b.customer_name DESC;

-----------------------------------------------------------------------------------------
-- Customers and coffee shops within a specific distance
 -----------------------------------------------------------------------------------------

select c.customer_id, c.customer_city, c.customer_location_home,  
       cs.coffee_shop_id, cs.coffe_shop_location 
       from coffee_shop as cs, customer as c
       where ST_DWithin(c.customer_location_home, cs.coffe_shop_location, 10000)
       group by cs.coffee_shop_id, cs.coffe_shop_location, c.customer_id, c.customer_city,  c.customer_location_home
      order by cs.coffee_shop_id, c.customer_location_home, cs.coffe_shop_location DESC;
          
       
               
 -- End of File --
