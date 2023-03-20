/*
Show unique first names from the patients table which only occurs once in the list.

For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
*/

select 
    first_name
from 
    patients
group by 
    first_name
having 
    count(*) = 1;

/*

Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
*/

select 
	patient_id, 
    diagnosis
from 
	admissions
group by 
	patient_id, 
	diagnosis
having count(diagnosis)>1;

/*
Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
*/

select 
	province_id,
    sum(height)
from 
	patients
group by 
    province_id
having 
    sum(height)>=7000

/*
Show all columns for patient_id 542's most recent admission_date.
*/

select 
	*
from 
	admissions
where 
    patient_id = 542
order by 
    admission_date desc
limit 1;

/*
display the number of duplicate patients based on their first_name and last_name.
*/

select
	first_name,
    last_name,
    count(*)
from 
    patients
group by 
    first_name, 
    last_name
having 
    count(*)>1;

/*
Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
*/

