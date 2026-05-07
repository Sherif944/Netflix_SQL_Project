
-- 1. Count the number of Movies vs TV Shows
SELECT
	type,
	COUNT(*) total_number
FROM netflix_titles
GROUP BY type

--OR

SELECT
	COUNT(*) total_movies,
	type
FROM netflix_titles
WHERE type = 'movie'
GROUP BY type;
SELECT
	COUNT(*) total_tvshows,
	type
FROM netflix_titles
WHERE type = 'TV Show'
GROUP BY type;


-- 2. Find the most common rating for movies and TV shows
SELECT
	rating,
	type,
	total_number
FROM(
	SELECT
		rating,
		type,
		COUNT(*) total_number,
		RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC ) Rank_of_rating
	FROM netflix_titles
	GROUP BY
		rating,
		type)t
WHERE Rank_of_rating = 1

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT
	*
FROM netflix_titles
WHERE release_year = 2020
And type = 'Movie'

-- 4. Find the top 5 countries with the most content on Netflix
WITH netflix_country AS(
	SELECT
		COUNT(*) total_number,
		TRIM(value) AS new_country,
		RANK() OVER(ORDER BY COUNT(*) DESC) ranking_countries
	FROM netflix_titles
	CROSS APPLY STRING_SPLIT(country, ',')
	GROUP BY TRIM(value)
)
SELECT
	total_number,
	new_country
FROM netflix_country
WHERE ranking_countries <= 5

-- 5. Identify the longest movie or TV show duration
SELECT
	type,
	duration
FROM
(
SELECT 
	type,
	CAST(TRIM(REPLACE(duration, 'min', ' ')) AS INT) duration,
	RANK() OVER(ORDER BY CAST(TRIM(REPLACE(duration, 'min', ' ')) AS INT) DESC) ranking_long
FROM netflix_titles
WHERE TYPE = 'movie'
)t
WHERE ranking_long <= 1


SELECT
	type,
	duration
FROM
(
SELECT 
	type,
	CAST(REPLACE(REPLACE(duration, 'SEASON', ' ') , 'S', ' ') AS INT) duration,
	RANK() OVER(ORDER BY CAST(REPLACE(REPLACE(duration, 'SEASON', ' ') , 'S', ' ') AS INT) DESC) ranking_duration
FROM netflix_titles
WHERE TYPE = 'TV Show'
)t
WHERE ranking_duration = 1


-- 6. Find content added in the last 5 years
SELECT
	type,
	date_added
FROM
	(
	SELECT
		type,
		date_added,
		DATEDIFF(YEAR, date_added, GETDATE()) last_years
	FROM netflix_titles
) t
WHERE last_years <= 5


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT
	*
FROM netflix_titles
WHERE director like '%Rajiv Chilaka%'

-- 8. List all TV shows with more than 5 seasons
SELECT
	type,
	CAST(LEFT(duration, 1) AS INT) Nr_seasons
FROM netflix_titles
WHERE CAST(LEFT(duration, 1) AS INT) > 5




-- 9. Count the number of content items in each genre
SELECt
	TRIM(value) new_listed_in,
	COUNT(*) total_number
FROM netflix_titles
CROSS APPLY STRING_SPLIT(listed_in, ',')
GROUP BY
	type,
	TRIM(value)
ORDER BY total_number DESC
	

-- 10. Find each year and the average number of content release in indeia on netflix and return
-- top 5 year with highest percentage of content release
-- N.B: number of release is 1046 movies

SELECT TOP 5
	release_year,
	COUNT(*) total_number,
	ROUND(
	CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM netflix_titles WHERE country LIKE '%India%') *100, 2) Percentage_per_year
FROM netflix_titles
WHERE COUNTRY LIKE '%India%'
GROUP BY release_year
ORDER BY total_number DESC

-- 11. List all movies that are documentaries
SELECt
	type,
	TRIM(value) new_listed_in,
	director,
	cast,
	country,date_added,
	release_year,
	rating,
	duration,
	description
FROM netflix_titles
CROSS APPLY STRING_SPLIT(listed_in, ',')
WHERE type = 'movie' AND TRIM(value) = 'Documentaries'


	

-- 12. Find all content without a director
SELECT
	*
FROM netflix_titles
WHERE director IS NULL

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT
	*,
	YEAR(GETDATE()) - release_year AS difference_years
FROM netflix_titles
WHERE YEAR(GETDATE()) - release_year <= 10 AND cast LIKE '%Salman Khan%'
	


-- 14. Find the top 10 actors who have appeared the most in the movies produced in India.

SELECT TOP 10
	new_cast,
	COUNT(*) total_number
FROM(
	SELECT
		type,
		TRIM(value) AS new_cast
	FROM netflix_titles
	CROSS APPLY STRING_SPLIT(cast, ',')
	WHERE country LIKE '%India%')t
GROUP BY new_cast
ORDER BY total_number DESC

-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description
-- label content containing these keywords as 'bad' and all other content as 'Good'
-- count how many items fall into each category
SELECT
	movie_segmentation,
	COUNT(*) total_number
FROM(
	SELECT
		*,
		CASE
			WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
			ELSE 'Good'
		END movie_segmentation
	FROM netflix_titles)t
GROUP BY movie_segmentation
