-- Count

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

Show the total number of admissions
*/

select
	count(*)
from 
	admissions;

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

Show unique first names from the patients table which only occurs once in the list.

For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list.
If only 1 person is named 'Leo' then include them in the output.
*/

select 
    first_name
from 
    patients
group by 
    first_name
having 
    count(*) = 1

/*
Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.
*/
SELECT 
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS total_male_patients,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS total_female_patients
FROM patients;


/*
Show patient_id, diagnosis from admissions.
 Find patients admitted multiple times for the same diagnosis.
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
Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.
*/

select 
	city,
    count(patient_id) As Total_number_of_patient
from patients
group by
	city
order by 
	count(patient_id) desc,
    city asc;

/*
Show all of the days of the month (1-31) and how many admission_dates occurred on that day.
 Sort by the day with most admissions to least admissions.
*/

select 
	day(admission_date),
    count(*)
from 
	admissions
group by
	day(admission_date)
order by	
	count(*) desc

/*
Show first_name, last_name, and the total number of admissions attended for each doctor.

Every admission has been attended by a doctor.

*/

select 
	d.first_name,
    d.last_name,
    count(a.attending_doctor_id)
from 
	doctors d 
left join
	admissions a on a.attending_doctor_id = d.doctor_id
group by
	d.doctor_id

/*
Display the total amount of patients for each province. Order by descending.
*/

select 
	pn.province_name,
    count(p.patient_id)
from 
	province_names pn
left join 
    patients p on p.province_id = pn.province_id
group by 
    pn.province_name
having 
    count(p.patient_id) > 0
order by 
    count(p.patient_id) desc

/*

display the number of duplicate patients based on their first_name and last_name.
*/

select
	first_name,
    last_name,
    count(*)
from patients
group by first_name, last_name
having count(*)>1