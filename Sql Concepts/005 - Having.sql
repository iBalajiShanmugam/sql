select 
	allergies,
    count(*) AS Totalcount
    
from patients
where allergies not NULL
group by allergies
having totalcount >10
order by Totalcount DESC

-- Show unique first names from the patients table which only occurs once in the list.

select first_name
from patients
group by first_name
having count(*) = 1

-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis
select 
	patient_id, 
    diagnosis
from 
	admissions
group by 
	patient_id, 
	diagnosis
having count(diagnosis)>1;