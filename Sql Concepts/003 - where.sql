-- operators

/*

# operators
< 
> 
>=
<=
/
%
=
<>
IN
AND
OR
BETWEEN

*/


-- get the first_name and last_name for the Male patients
 select 
 	first_name,
    last_name,
    gender
 from patients
 where
 	gender = 'M';

-- get the the patient from the torronto city

select 
	* 
from 
	patients 
where 
	city ='Toronto';

-- get the list of patient having height upto 140

select 
	* 
from 
	patients 
where 
	height <= 140;

-- get the list of patients who having height 140,150
select 
	* 
from 
	patients 
where 
	height = 140 or height =150;

-- get the patients from Miton and Toronto

select 
	* 
from 
	patients 
where 
	city in('Milton', 'Toronto');

--get the patients from Miton and Toronto who having Penicillin

select 
	* 
from 
	patients 
where 
	city in('Milton', 'Toronto') and allergies ='Penicillin';