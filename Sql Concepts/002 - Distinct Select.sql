-- Select distinct allergices

select 
	distinct 
    	allergies
from 
	patients;
    

-- Select distinct allergices in the city

select 
	distinct 
    	allergies,
        city
from 
	patients;