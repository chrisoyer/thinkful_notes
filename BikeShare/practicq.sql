SELECT 
	trip_ID AS tID,
	duration
FROM
trips
WHERE
duration > 500
ORDER BY duration
;
