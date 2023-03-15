/*

Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
*/

select 
	distinct city
from patients
where 
	province_id ='NS';

/*
Show unique birth years from patients and order them by ascending.
*/

-- year() is one of function 
select 
	distinct year(birth_date) 
from patients
order by year(birth_date);


/*
All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date

*/

-- len() is the function to get the enth of strings
-- cancat() is the function to concat the multiple strings
-- year() is the function to get the year from date
select 
	distinct
	a.patient_id,
    concat(p.patient_id, len(p.last_name), year(p.birth_date)) as temp_password
from admissions a
inner join patients p on p.patient_id = a.patient_id;