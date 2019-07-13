--What's the most expensive listing? What else can you tell me about the listing?
SELECT
  MAX(lst.price) AS max_of_price,
  lst.name,
  lst.id,
  lst.neighbourhood,
  lst.room_type,
  COUNT(rev.*) AS number_of_reviews
FROM
  sfo_listings AS lst
LEFT JOIN
  sfo_reviews AS rev
ON
  rev.listing_id = lst.id
GROUP BY
  lst.name,
  lst.id,
  lst.neighbourhood,
  lst.room_type
ORDER BY
  max_of_price DESC
LIMIT 1

--What neighborhoods seem to be the most popular?
SELECT
  neighbourhood,
  COUNT(lst.*) AS no_of_listings
FROM
  sfo_listings AS lst
GROUP BY 
  neighbourhood
ORDER BY 
  no_of_listings DESC  
LIMIT 5
;

--What time of year is the cheapest time to go to San Francisco? What about the busiest?
SELECT
  AVG(cal.price::numeric),
  CASE WHEN 
    EXTRACT(MONTH FROM cal.calender_date) IN (1,2,3)
    THEN 'Winter'
	WHEN EXTRACT(MONTH FROM cal.calender_date) IN (4,5,6)
	THEN 'SPRING'
	WHEN EXTRACT(MONTH FROM cal.calender_date) IN (7,8,9)
	THEN 'Summer'
	ELSE 'FALL'
	END
	AS season  
FROM
  sfo_calendar AS cal
GROUP BY 
  season

;