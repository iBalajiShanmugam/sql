-- Revising the Select Query I
/*
Query all columns for all American cities in the CITY table with populations larger than 100000.
The CountryCode for America is USA.
*/

select 
    * 
from 
    city
where 
    countrycode ='USA' and 
    population > 100000


-- Revising the Select Query II
/*
Query the NAME field for all American cities in the CITY table with populations larger than 120000.
 The CountryCode for America is USA.
*/

select 
    name 
from 
    city 
where 
    countrycode ='USA' and 
    population >120000


-- Select All
/*
Query all columns (attributes) for every row in the CITY table.
*/

select 
    * 
from 
    city 


-- Select By ID
/*
Query all columns for a city in CITY with the ID 1661.
*/

select 
    * 
from 
    city AS c 
where 
    c.id = 1661;

-- Japanese Cities' Attributes
/*
Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
*/
select 
    * 
from 
    city 
where 
    countrycode ='JPN';


--Japanese Cities' Names
/*
Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
*/
select 
    name 
from 
    city 
where 
    countrycode='JPN'


-- Weather Observation Station 1
/*
Query a list of CITY and STATE from the STATION table.
*/
select 
    city,
    state 
from 
    station 

-- Weather Observation Station 3
/*
Query a list of CITY names from STATION for cities that have an even ID number. 
Print the results in any order, but exclude duplicates from the answer.
*/

select 
    distinct 
        city 
from 
    station  
WHERE 
    (ID%2)=0

-- Weather Observation Station 4
/*
Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.*/

select 
    count(city) - count(distinct city) 
from 
    station