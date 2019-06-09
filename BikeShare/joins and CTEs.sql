--What are the three longest trips on rainy days?
SELECT
  t.duration,
  t.trip_id
FROM 
  trips AS t
JOIN 
  weather AS w
ON 
  t.zip_code = w.zip --AND   --no results when including join on zip
  --t.end_date = w.date
WHERE
  w.precipitationin > 0
ORDER BY
  t.duration DESC
LIMIT 3  
;

--Which station is full most often?
SELECT
  s.station_id,
  count(s.*)
FROM
  status as s
WHERE 
  s.docks_available = 0
GROUP BY 
  s.station_id
LIMIT 1
;

--Return a list of stations with a count of number of trips starting at that station but ordered by dock count.
SELECT
  s.station_id,
  count(t.*) AS number_of_trips
FROM
  stations AS s
GROUP BY 
  s.station_id
JOIN 
  trips AS t
ON
  t.start_terminal = s.station_id
ORDER BY 
  s.dockcount
;  

--(Challenge) What's the length of the longest trip for each day it rains anywhere?
WITH date_max
AS
(
SELECT
  MAX(t.duration) AS longest_trip_length,
  t.start_date
FROM
  trips as t
GROUP BY
  t.start_date
)
SELECT
  w.date,
  date_max.longest_trip_length
FROM
  date_max
JOIN
  weather as w
ON
  date_max.start_date = w.date