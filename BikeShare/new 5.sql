--What time of year is the cheapest time to go to San Francisco? What about the busiest?
SELECT
  AVG(to_number( price, regexp_replace( replace(price,',','G') , '[0-9]' ,'9','g') )) AS avg_price,
  CASE WHEN 
    EXTRACT(MONTH FROM cal.calender_date) IN (1,2,3) 
    THEN 'winter'
	WHEN EXTRACT(MONTH FROM cal.calender_date) IN (4,5,6)
	THEN 'spring'
	WHEN EXTRACT(MONTH FROM cal.calender_date) IN (7,8,9)
	THEN 'summer'
	ELSE 'fall'
	END
	AS season  
FROM
  sfo_calendar AS cal
GROUP BY 
  season
ORDER BY 
  avg_price DESC
;
--busiest time in SF?
--busiest time in SF?
-- Column: public.sfo_calendar.price
-- ALTER TABLE public.sfo_calendar DROP COLUMN price;
--SELECT round(CAST (substring(price, 2, 10 ) AS numeric), 4) 
SELECT
  (COUNT(cal.*) FILTER (WHERE available = 't'))::float/COUNT(cal.*)::float AS avail_factor,
    CASE WHEN 
    EXTRACT(MONTH FROM cal.calender_date) IN (1,2,3) 
    THEN 'winter'
	WHEN EXTRACT(MONTH FROM cal.calender_date) IN (4,5,6)
	THEN 'spring'
	WHEN EXTRACT(MONTH FROM cal.calender_date) IN (7,8,9)
	THEN 'summer'
	ELSE 'fall'
	END
	AS season  
FROM
  sfo_calendar AS cal
GROUP BY
  season
ORDER BY 
  avail_factor ASC
LIMIT 1  
;