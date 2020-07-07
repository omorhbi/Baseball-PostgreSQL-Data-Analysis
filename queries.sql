-- write your queries underneath each number:
 
-- 1. the total number of rows in the database
SELECT COUNT(*) as rows FROM baseball_data;

-- 2. show the first 15 rows, but only display 3 columns (your choice)
SELECT year, batting_avg, runs_batted_in
	FROM baseball_data
	ORDER BY year DESC
	LIMIT 15;

-- 3. do the same as above, but chose a column to sort on, and sort in descending order
SELECT year, batting_avg, runs_batted_in
	FROM baseball_data
	ORDER BY runs_batted_in DESC
	LIMIT 15;
	
-- 4. add a new column without a default value
ALTER TABLE baseball_data
	DROP COLUMN IF EXISTS slug_minus_bat_avg;
ALTER TABLE baseball_data
	ADD COLUMN slug_minus_bat_avg NUMERIC (4, 3);

SELECT year, slug_minus_bat_avg
	FROM baseball_data
	ORDER BY year DESC
	LIMIT 15;

-- 5. set the value of that new column
UPDATE baseball_data 
	SET slug_minus_bat_avg = slugging - batting_avg;

SELECT year, slug_minus_bat_avg
	FROM baseball_data
	ORDER BY year DESC
	LIMIT 15;

-- 6. show only the unique (non duplicates) of a column of your choice
SELECT DISTINCT teams
	FROM baseball_data
	ORDER BY teams DESC;

-- 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group
SELECT DISTINCT teams, COUNT(*) as seasons, round(AVG(hits_per_game), 2) as avg_hits
	FROM baseball_data
	GROUP BY teams
	ORDER BY teams DESC;

-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups
SELECT DISTINCT teams, COUNT(*) as seasons, round(AVG(hits_per_game), 2) as avg_hits
	FROM baseball_data
	GROUP BY teams
	HAVING COUNT(teams) > 1
	ORDER BY teams DESC; 

-- 9. find the average number of batters per team each year had in the last 30 years
SELECT year, (batters / teams ) as avg_batters_per_team
	FROM baseball_data
	ORDER BY year DESC
	LIMIT 30;

-- 10. see if age affects batting average and runs batted in
SELECT avg_batter_age, round(AVG(batting_avg), 3) as batting_avg, round(AVG(runs_batted_in), 2) as runs_batted_in
	FROM baseball_data
	GROUP BY avg_batter_age
	ORDER BY batting_avg DESC;

-- 11. Show the strikeout rate and batting avg in the most recent year for baseball and for the 1st year of baseball
SELECT year, strikeouts_per_game, batting_avg
	FROM baseball_data
	ORDER BY year DESC
	LIMIT 1;

	/*SELECT year, strikeouts_per_game, batting_avg
		FROM baseball_data
		ORDER BY year
		LIMIT 1;*/

-- 12. Show rows where the stolen base rate was > 0.25 and the caught stealing rate was < 0.25
-- while excluding years where caught stealing stats weren't kept
SELECT year, stolen_bases_avg, caught_stealing_avg
	FROM baseball_data
	WHERE stolen_bases_avg > 0.25 AND caught_stealing_avg < 0.25 AND caught_stealing_avg != 0
	ORDER BY year DESC;
