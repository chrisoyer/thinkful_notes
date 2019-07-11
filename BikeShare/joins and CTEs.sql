--What are the three longest trips on rainy days? 
SELECT
  tr.duration,
  tr.trip_id
FROM 
  trips AS tr
JOIN 
  weather AS w
ON 
  DATE(tr.start_date) = DATE(w.date) 
WHERE
  w.precipitationin > 0
ORDER BY
  tr.duration DESC
LIMIT 3  
;


--Which station is full most often?
SELECT
  s.station_id,
  count(s.*) AS times_full
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
  count(tr.*) AS number_of_trips
FROM
  stations AS s
JOIN 
  trips AS tr
ON
  tr.start_terminal = s.station_id
GROUP BY 
  s.station_id,
  s.dockcount
ORDER BY 
  s.dockcount
;  


;--(Challenge) What's the length of the longest trip for each day it rains anywhere?
WITH date_max
AS
(
SELECT
  MAX(t.duration) AS longest_trip_length,
  DATE(t.start_date) AS date
FROM
  trips as t
GROUP BY
  date
)
SELECT
  date(w.date) AS w_date,
  date_max.longest_trip_length
FROM
  date_max
JOIN
  weather as w
ON
  date_max.date = date(w.date)
WHERE
  w.precipitationin > 0
ORDER BY 
  date_max.longest_trip_length DESC
LIMIT 1
;