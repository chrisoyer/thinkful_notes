--What was the hottest day in our data set? Where was that?
SELECT 
  date,
  MAX(maxtemperaturef) AS temp_f,
  zip
FROM 
  weather
GROUP BY
  date,
  zip
ORDER BY 
  MAX(maxtemperaturef)
LIMIT 1  
;

--How many trips started at each station?
SELECT
  COUNT(*) AS number_of_trips,
  start_station
FROM
  trips
GROUP BY 
  start_station
;
--What's the shortest trip that happened?
SELECT
  MIN(duration) AS min_duration
FROM
  trips
;

--What is the average trip duration, by end station?
SELECT
  AVG(duration),
  end_station
FROM
  trips
GROUP BY
  end_station
;
  