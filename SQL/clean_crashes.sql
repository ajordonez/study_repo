  SELECT *
  FROM `ferrous-thought-409502.insurance.crashes`
  WHERE
    `CRASH DATE` BETWEEN '2020-01-01' AND '2024-12-01'
    AND BOROUGH IS NOT NULL
    AND `ZIP CODE` IS NOT NULL
    AND `ZIP CODE` > 10000
    AND COLLISION_ID IS NOT NULL
    AND `NUMBER OF PERSONS KILLED` IS NOT NULL
    AND `NUMBER OF PERSONS INJURED` IS NOT NULL

