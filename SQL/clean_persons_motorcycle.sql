SELECT *
FROM `ferrous-thought-409502.insurance.persons`
WHERE
  `CRASH_DATE` BETWEEN '2020-01-01' AND '2024-12-01'
  AND PERSON_TYPE IS NOT NULL
  AND PERSON_AGE IS NOT NULL 
  AND PERSON_AGE >0 
  AND PERSON_AGE <150
  AND PERSON_SEX IS NOT NULL
  AND COLLISION_ID IS NOT NULL
  AND PERSON_TYPE = "Occupant"
  AND EMOTIONAL_STATUS IS NOT NULL
  AND POSITION_IN_VEHICLE LIKE "%Driver%"
  AND PERSON_INJURY IS NOT NULL