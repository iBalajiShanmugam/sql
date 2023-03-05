-- selecting all column

SELECT * FROM patients;

-- selecting multiple column

select 
	first_name,
    last_name,
    gender 
from 
	patients;


-- selecting column with custom names(alias)

select 
	first_name AS FirstName,
    last_name AS LastName,
    gender As Gender
from 
	patients;


-- selecting custom value for all rows

select 
	first_name AS FirstName,
    last_name AS LastName,
    gender As Gender,
    'India' AS Country
from 
	patients;

-- selecting custom value 

select 'India' AS Country


