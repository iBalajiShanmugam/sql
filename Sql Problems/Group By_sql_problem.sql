/*
Show unique first names from the patients table which only occurs once in the list.

For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
*/

select 
    first_name
from 
    patients
group by first_name
having count(*) = 1;

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
Show all allergies ordered by popularity. Remove NULL values from query.
*/

select 
	allergies,
    count(*) as popularity
from 
	patients
where 
	allergies is not NULL
group by
	allergies
order by
	popularity desc;

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
	sum(height)>=7000;

/*
Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
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
Show all columns for patient_id 542's most recent admission_date.
*/

select 
	*
from 
	admissions
where patient_id = 542
order by admission_date desc
limit 1;


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
For each doctor, display their id, full name, and the first and last admission date they attended.
*/

select 
	d.doctor_id,
    concat(d.first_name,' ', d.last_name) as full_name,
    min(a.admission_date) as first_admission_date,
    max(a.admission_date) as last_admission_date
from doctors d
left join admissions a on a.attending_doctor_id = d.doctor_id
group by doctor_id

/*
Display the total amount of patients for each province. Order by descending. filter only total amount greater than 0
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
    count(*) num_of_duplicates
from 
	patients
group by 
	first_name, 
    last_name
having 
	count(*) > 1;