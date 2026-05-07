/*
===============================================================================
Load netflix_titles (Source -> netflix_titles)
===============================================================================
Script Purpose:
    This script loads data into the 'netflix_titles' table from external CSV file.
    It performs the following actions:
    - Truncates the netflix_titles table before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to netflix_titles table.

Parameters:
    None.
    This script does not accept any parameters or return any values.
===============================================================================
*/


-- Loading of netflix_titles data
TRUNCATE TABLE netflix_titles;
BULK INSERT netflix_titles
FROM 'D:\Data Analysis\netflix_titles project\netflix_titles.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Check that table is inserted successfully 
SELECT 
	* 
FROM netflix_titles;

SELECT
	COUNT(*) total_rows
FROM netflix_titles;
