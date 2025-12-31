---View the two tables, number of column in each table and the varibles
SELECT * FROM table1;
SELECT * FROM table2;


---identity the Primary Key using the entity relationship diagram
SELECT patient_id 
FROM table1;
SELECT patient_id 
FROM table2;


--Both tables have thesame number of 1088 rows, patient_id,  is the primary Key. 
---Full Join with pateint_id as primary key

SELECT * FROM table1 T1
FULL JOIN table2 T2
ON T1.patient_id = T2.patient_id;


---Number of Patients with Confirmed or Unconfirmed biopsed 
SELECT
	COUNT (*) AS "Total_Biopsed",
	SUM(CASE WHEN biopsed = true THEN 1 ELSE 0 END) AS "Confirmed_Biopsed",
	SUM(CASE WHEN biopsed = False THEN 1 ELSE 0 END) AS "Unconfirmed_Biopsed"
FROM
	table2 T2;
	
---Number of Patients with Confirmed Biopsed by diagnostic types
SELECT
  T2.diagnostic,
  COUNT(*) AS "Confirmed_Biopsed"
FROM
  table2 T2
WHERE
  T2.biopsed = true
GROUP BY
  T2.diagnostic
ORDER BY
  "Confirmed_Biopsed" DESC;
  
--Number of confirmed biopsed cases by gender
SELECT
	T2.diagnostic,
	T1.gender, 
	COUNT (*)AS "Confirmed_Biopsied"
	FROM table1 T1
	JOIN table2 T2 ON T2.patient_id=T1.patient_id
	WHERE
	T2.biopsed = 'true'
	GROUP BY T2.diagnostic,T1.gender
	Order by "Confirmed_Biopsied" DESC;
	
---Number of confirm skin cancer cases by smoking 
SELECT
	T2.diagnostic,
	T1.smoke, 
	COUNT (*)AS "Patient_Count"
	FROM table1 T1
	JOIN table2 T2 ON T2.patient_id=T1.patient_id
	WHERE
	T2.biopsed = 'true'
	GROUP BY 
	T2.diagnostic,
	T1.smoke
	ORDER BY 
  	"Patient_Count" DESC;
	
---Number of confirm skin cancer types and  drinking 
SELECT
  T2.diagnostic,
  T1.drink, 
  COUNT(*) AS "Patient_Count"
FROM 
  table1 T1
JOIN 
  table2 T2 ON T2.patient_id = T1.patient_id
WHERE
  T2.biopsed = true
GROUP BY 
  T2.diagnostic,
  T1.drink
ORDER BY 
  T2.diagnostic ASC;
  

---Confirmed skin cancer cases and cancer history
SELECT
	T2.diagnostic,
	T1.cancer_history, 
  	COUNT(*) AS "Confirmed_Biopsied"
FROM 
  table1 T1
JOIN 
  table2 T2 ON T2.patient_id = T1.patient_id
WHERE
  T2.biopsed = true
GROUP BY 
  T2.diagnostic,
  T1.cancer_history
ORDER BY
  "Confirmed_Biopsied" DESC;
	
  -----Number of confirm skin cancer cases and skin cancer history
 SELECT 
  T2.diagnostic,
  T1.skin_cancer_history,
  COUNT(*) AS patient_count
FROM 
  table1 T1
JOIN 
  table2 T2 ON T1.patient_id = T2.patient_id
WHERE 
  T2.biopsed = true
GROUP BY 
  T2.diagnostic,
  T1.skin_cancer_history
ORDER BY 
  patient_count DESC;
		
---Confirmed skin cancer types by background_father and background_mother
SELECT
	T2.diagnostic,
	T1.background_father, 
	T1.background_mother,
	COUNT(*) AS "Confirmed_Biopsied"
	FROM table1 T1
	JOIN table2 T2 ON T2.patient_id=T1.patient_id
	WHERE
	T2.biopsed = 'true'
	GROUP BY 
	T2.diagnostic,
	T1.background_father,
	T1.background_mother
	ORDER BY "Confirmed_Biopsied" DESC;	
	
---Maximun and Minimum age 	
SELECT MAX(age) 
FROM table1;
SELECT MIN(age) 
FROM table1;	
	
----Number of Confirmed cancer types by age Range
	SELECT
	T2.diagnostic,
  	CASE
    WHEN T1.age BETWEEN 1 AND  11 THEN '1–11'
    WHEN T1.age BETWEEN 12 AND 22 THEN '12–22'
    WHEN T1.age BETWEEN 23 AND 33 THEN '23–33'
	WHEN T1.age BETWEEN 34 AND 44 THEN '34–44'
	WHEN T1.age BETWEEN 45 AND 55 THEN '45–55'
	WHEN T1.age BETWEEN 56 AND 66 THEN '56–66'
	WHEN T1.age BETWEEN 67 AND 77 THEN '67–77'
	WHEN T1.age BETWEEN 78 AND 88 THEN '78–88'
	WHEN T1.age BETWEEN 89 AND 99 THEN '89–99'
    ELSE 'Unknown'
  END AS age_range,
  COUNT(*) AS "Patient_count"
FROM
  table1 T1
JOIN
  table2 T2 ON T2.patient_id = T1.patient_id
WHERE
  T2.biopsed = 'true'
GROUP BY
  T2.diagnostic,
  age_range
Order by
  T2.diagnostic;
	
---Fitzpatrick skin type of confirmed cancerous lesions
SELECT 
	T2.diagnostic,
    Fitspatrick,
    COUNT(*) AS "Confirmed_Biopsied"
FROM 
    table2 T2
WHERE 
    biopsed = 'true'
GROUP BY 
	T2.diagnostic,
    Fitspatrick
ORDER BY 
    "Confirmed_Biopsied" DESC;
	
----Patient background and confirm cancer cases
SELECT
  T2.diagnostic,
  T1.background_mother,
  T1.background_father,
  COUNT(*) AS "Patient_count"
FROM
  table1 T1
JOIN
  table2 T2 ON T2.patient_id = T1.patient_id
WHERE
  T2.biopsed = 'true'
GROUP BY
  T2.diagnostic,
  T1.background_mother,
  T1.background_father
ORDER BY 
  "Patient_count" DESC;
	
--Number of biopsy types and exposure to pesticides 
SELECT
	T2.diagnostic,
	T1.pesticide, 
	COUNT (*)AS "Patient_count"
	FROM table1 T1
	JOIN table2 T2 ON T2.patient_id=T1.patient_id
	WHERE
	T2.biopsed = 'true'
	GROUP BY 
		T2.diagnostic,
		T1.pesticide
	ORDER BY 
		"Patient_count" DESC;
		
--Number of Confirmed Biopsed types and presence of pipe water
SELECT
	T2.diagnostic,
	T1.has_piped_water, 
	COUNT (*)AS "Confirmed Biosied"
	FROM table1 T1
	JOIN table2 T2 ON T2.patient_id=T1.patient_id
	WHERE
	T2.biopsed = 'true'
	GROUP BY T2.diagnostic, T1.has_piped_water 
	ORDER BY "Confirmed Biosied" DESC;
	
---Number of UNCONFIRM cancer types and having pipe water
SELECT
	T2.diagnostic,
	T1.has_piped_water, 
	COUNT (*)AS "Patient_count"
	FROM table1 T1
	JOIN table2 T2 ON T2.patient_id=T1.patient_id
	WHERE
	T2.biopsed = 'false'
	GROUP BY T2.diagnostic, T1.has_piped_water
	ORDER BY "Patient_count" DESC;

--Number of Confirmed skin cancer types and having sewage
SELECT
	T2.diagnostic,
	T1.has_sewage_system, 
	COUNT (*)AS "Patient_count"
	FROM table1 T1
	JOIN table2 T2 ON T2.patient_id=T1.patient_id
	WHERE
	T2.biopsed = 'true'
	GROUP BY T2.diagnostic, T1.has_sewage_system
	ORDER BY "Patient_count" DESC;
	
---Lision characteristics and subtypes of confirmed Biopsed 
SELECT
    T2.diagnostic,
    T2.region,
    T2.itch,
    T2.grew,
    T2.hurt,
    T2.changed,
    T2.bleed,
    T2.elevation,
    COUNT(*) AS "Confrimed_Biopsied"
FROM table2 T2
JOIN table1 T1 ON T1.patient_id = T2.patient_id
WHERE T2.biopsed = 'true'
GROUP BY 
    T2.diagnostic, 
    T2.region,
    T2.itch,
    T2.grew,
    T2.hurt,
    T2.changed,
    T2.bleed,
    T2.elevation
ORDER BY "Confrimed_Biopsied" DESC;

---Region and subtypes of confirmed Biopsed 
SELECT
    T2.diagnostic,
    T2.region,
    COUNT(*) AS Patient_Count
FROM table2 T2
JOIN table1 T1 ON T1.patient_id = T2.patient_id
WHERE T2.biopsed = 'true'
GROUP BY 
    T2.diagnostic, 
    T2.region
ORDER BY 
    Patient_Count DESC;
  
---itch and subtypes of confirmed Biopsed 
SELECT
    T2.diagnostic,
    T2.itch,
    COUNT(*) AS Patient_Count
FROM table2 T2
JOIN table1 T1 ON T1.patient_id = T2.patient_id
WHERE T2.biopsed = 'true'
GROUP BY 
    T2.diagnostic, 
    T2.itch
ORDER BY 
    Patient_Count DESC;
  ---bleed and subtypes of confirmed Biopsed 
SELECT
    T2.diagnostic,
    T2.bleed,
    COUNT(*) AS Patient_Count
FROM table2 T2
JOIN table1 T1 ON T1.patient_id = T2.patient_id
WHERE T2.biopsed = 'true'
GROUP BY 
    T2.diagnostic, 
    T2.bleed
ORDER BY 
    Patient_Count DESC;
 ---hurt and subtypes of confirmed Biopsed 
SELECT
    T2.diagnostic,
    T2.hurt,
    COUNT(*) AS Patient_Count
FROM table2 T2
JOIN table1 T1 ON T1.patient_id = T2.patient_id
WHERE T2.biopsed = 'true'
GROUP BY 
    T2.diagnostic, 
    T2.hurt
ORDER BY 
    Patient_Count DESC;	
	
SELECT 
  T1.gender,
  COUNT(*) AS Number_of_Patients
FROM 
  table1 T1
GROUP BY 
  T1.gender;
----No. of people with pipe water
 SELECT 
  T1.has_piped_water,
  COUNT(*) AS Number_of_Patients
FROM 
  table1 T1
GROUP BY 
  T1.has_piped_water;
