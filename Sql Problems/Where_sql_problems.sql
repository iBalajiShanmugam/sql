/*
Show first name, last name, and gender of patients who's gender is 'M'
*/

select 
	first_name, 
    last_name, 
    gender  
from 
	patients
where 
	gender = 'M';

/*
Show first name and last name of patients who does not have allergies. (null)
*/

select 
	first_name, 
    last_name 
from 
	patients
where 
	allergies is null;

/*
Show first name of patients that start with the letter 'C'
*/

select 
	first_name
from 
	patients
where first_name like 'C%';

/*
Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
*/

select 
	first_name,
    last_name
from 
	patients
where weight between 100 and 120;

/*
Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
*/

update 
	patients
set
	allergies = 'NKA'
where 
	allergies is null;

/*
Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000
*/

SELECT 
	*
from 
	patients
where
	patient_id in (1,45,534,879,1000);

/*

Show how many patients have a birth_date with 2010 as the birth year.
*/

select
	count(*)
from 
	patients
where
	year(birth_date) = 2010;

/*
Show all the columns from admissions where the patient was admitted and discharged on the same day.
*/

select
	*
from
	admissions
where
	admission_date = discharge_date;

/*

Show the patient id and the total number of admissions for patient_id 579.
*/

select
	patient_id,
    count(*)
from
	admissions
where
	patient_id = 579;

/*
Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
*/

select 
	distinct city
from patients
where 
	province_id ='NS';

/*
Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
*/

select 
	first_name,
    last_name,
    birth_date
from
	patients
where
	height > 160 and
    weight > 70;

/*
Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null
*/

select 
	first_name,
    last_name,
    allergies
from
	patients
where
	city = 'Hamilton' and
    allergies is not null;

/*
Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). Show the result order in ascending by city.
*/

select 
	distinct 
    	city
from 
	patients
where
	left(city,1) in ('a', 'e', 'i', 'o', 'u')
order by
	city asc;

/*
Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
*/


select 
	patient_id,
    first_name
from 
	patients
where 
	first_name like 's%s' and
    length(first_name)>=6;

/*
Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

Primary diagnosis is stored in the admissions table.
*/

select 
	p.patient_id,
    p.first_name,
    p.last_name
from 
	admissions a
inner join
	patients p on p.patient_id = a.patient_id
where
	a.diagnosis = 'Dementia';

/*
Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.
*/

SELECT 
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS total_male_patients,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS total_female_patients
FROM patients;

/*
Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
Show results ordered ascending by allergies then by first_name then by last_name.
*/

select 
	first_name,
    last_name,
    allergies
from 
	patients
where 
	allergies = 'Penicillin' or allergies = 'Morphine'
order by
	allergies asc,
    first_name asc,
    last_name asc;

/*
Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade.
Sort the list starting from the earliest birth_date.
*/

select 
	first_name,
    last_name,
    birth_date
from
	patients
where
	birth_date BETWEEN '1970-01-01' AND '1979-12-31'
order by
	birth_date asc;

/*
Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
*/

select 
	max(weight) - min(weight)
from
	patients
where 
	last_name = 'Maroni';

/*
Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
*/

SELECT 
	patient_id, 
    attending_doctor_id, 
    diagnosis
FROM 
	admissions
WHERE 
    (patient_id % 2 = 1 AND attending_doctor_id IN (1, 5, 19))
    OR (attending_doctor_id LIKE '%2%' AND LENGTH(patient_id) = 3);

/*
Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'

Check patients, admissions, and doctors tables for required information.
*/


SELECT 
	p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
from 
	admissions a 
inner join
	patients p on p.patient_id = a.patient_id
inner join 
	doctors d on d.doctor_id = a.attending_doctor_id
where 
	a.diagnosis = 'Epilepsy' and
    d.first_name = 'Lisa'

/*
We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'
*/


SELECT 
	*
from
	patients
where
	first_name like '__r%' and
    gender ='F' and
    month(birth_date) in (2,5,12) and
    weight between 60 and 80 and
    patient_id % 2 = 1 and
    city = 'Kingston';

/*
Show the percent of patients that have 'M' as their gender
Round the answer to the nearest hundreth number and in percent form.
*/
