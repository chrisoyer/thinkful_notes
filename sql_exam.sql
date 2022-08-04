-- 1
--Write a query that allows you to inspect the schema of the naep table.
SELECT 
  *
FROM 
  information_schema.columns
WHERE 
  TABLE_NAME='naep'
;....

-- 2
--Write a query that returns the first 50 records of the naep table.
SELECT 
  *
FROM 
  naep
LIMIT 
  50
;

-- 3
--Write a query that returns summary statistics for avg_math_4_score by state. Make sure to sort the results alphabetically by state name.
SELECT 
  state,
  count(avg_math_4_score) count_of_scores,
  avg(avg_math_4_score) mean_score,
  min(avg_math_4_score) minimum_score,
  max(avg_math_4_score) max_score,
  stddev(avg_math_4_score) st_deviation_of_states_scores
FROM 
  naep
GROUP BY 
  state
ORDER BY 
  state
;

-- 4
--Write a query that alters the previous query so that it returns only the summary statistics for avg_math_4_score by state with differences in max and min values that are greater than 30.
SELECT 
  state,
  count(avg_math_4_score) count_of_scores,
  avg(avg_math_4_score) mean_score,
  min(avg_math_4_score) minimum_score,
  max(avg_math_4_score) max_score,
  stddev(avg_math_4_score) st_deviation_of_score
FROM 
  naep
GROUP BY 
  state
HAVING 
  (max(avg_math_4_score) - min(avg_math_4_score)) > 30
ORDER BY 
  state
;

-- 5
--Write a query that returns a field called bottom_10_states that lists the states in the bottom 10 for avg_math_4_score in the year 2000.
-- I wasn't sure if instructions wanted the score as a field in the results, but it could be removed from the select statement without affecting results
SELECT 
  state as bottom_10_states,
  avg_math_4_score as avg_math4_score_in_2000
FROM 
  naep
WHERE
  year = 2000
ORDER BY avg_math_4_score asc
LIMIT 10
;

-- 6
SELECT 
  avg(avg_math_4_score)::decimal(18,2) national_avg_math4
FROM 
  naep
WHERE
  year = 2000
;

-- 7
WITH 
  nat_av
AS (
    SELECT
      AVG(avg_math_4_score) 
    AS 
      score
    FROM 
      naep
    WHERE 
      year = 2000
    )
SELECT
  state
FROM naep,
     nat_av
WHERE 
  naep.year = 2000 AND
  naep.avg_math_4_score < nat_av.score
;

-- 8
--Write a query that returns a field called scores_missing_y2000 that lists any states with missing values in the avg_math_4_score column of the naep data table for the year 2000.
SELECT 
  state as scores_missing_y2000
FROM 
  naep
WHERE
  year = 2000 AND
  avg_math_4_score is Null
;

--9
--NOTE: I divided the expenditure per student based on the description reasoning
--even though this wasn't mentioned directly
SELECT
  naep.state,
  naep.avg_math_4_score::decimal(18,2),
  (fin.total_expenditure::float/fin.enroll::float)::decimal(18,2) spend_per_student
FROM 
  naep
LEFT OUTER JOIN
  finance as fin
ON naep.id = fin.id
WHERE 
  naep.year = 2000 AND
  naep.avg_math_4_score is not Null
ORDER BY 
  naep.avg_math_4_score asc
;



