/*
MIN()
MAX()
COUNT()
AVG()
SUM()
*/


-- get the total count for earch allergies

select 
	allergies,
    count(*) AS Totalcount
    
from patients
where allergies not NULL
group by allergies
order by Totalcount DESC

-- get the total count for earch allergies in Toronto

select allergies, count(*)
from patients
where city ='Toronto'
group by allergies;

-- get the total number of patients gender vice

select gender, count(*)
from patients
group by gender;

-- get the no of docter in each specialty

select 
	specialty,
    count(*)
from doctors
group by specialty;
