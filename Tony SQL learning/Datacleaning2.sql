-- DATA CLEANING 
-- remove duplicates
-- standadize the data
-- null values or blank values
-- remove any columns



SELECT * 
FROM layoffs_staging2;

-- Step 1, Create a new table to work on duplicates 
CREATE TABLE layoffs_staging
LIKE layoffs; 

-- Step 2. Copy data from layoffs to layingoffs_staging
INSERT layoffs_staging
SELECT * 
FROM layoffs;

-- Step 3 CTE 
WITH duplicate_cte AS 
(
Select *, 
ROW_NUMBER() OVER(
PARTITION BY company,location, 
industry, total_laid_off, percentage_laid_off, `date`, stage,
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
Select * 
FROM duplicate_cte
WHERE row_num > 1;

-- Step 4 
Select * 
FROM layoffs_staging
WHERE company = 'Casper';

CREATE TABLE `layoffs_staging2` (
  `company` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` decimal(4,2) DEFAULT NULL,
  `date` text,
  `stage` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- step 5 

INSERT INTO layoffs_staging2
Select *, 
ROW_NUMBER() OVER(
PARTITION BY company,location, 
industry, total_laid_off, percentage_laid_off, `date`, stage,
country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Step 6 delete from the table , to remove duplicates

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- Step 7, Check again to see if deleted
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;


-- STANDARDIZING DATA 
-- FINDING ISSUE IN THE DATA AND FIXING IT 

-- Step 1, Select the company, then another table with trim company. 
Select company, Trim(company)
FRom  layoffs_staging2;

-- Step 2, update the company column 
update layoffs_staging2
set company = trim(company); -- SET [column] Updates the company column

-- Step 3, changing crypto word
Select *
FRom  layoffs_staging2
WHERE industry LIKE 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';


-- step 4, fixing full stop 
Select distinct country, TRIM(TRAILING '.' FROM  country)
FRom  layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- formatting date, text to date
SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

-- updated the date
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

-- Check 
SELECT `date`
FROM layoffs_staging2;


-- CHANGING COLUMN TYPE FROM TEXT TO DATE
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` date;


-- removing nulls, but first need to find the nulls. 
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off is NULL AND percentage_laid_off is NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';


-- populating data, that has already been populated 
SELECT * 
FROM layoffs_staging2
WHERE company = 'airbnb';


SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry is NOT NULL;

-- needs to update the blanks to null
UPDATE layoffs_staging2
SET industry = null 
WHERE industry = '';

-- then you can update null to the info 

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry is NOT NULL;


-- removing null 
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off is NULL AND percentage_laid_off is NULL;

-- DELTETE NULL
DELETE 
FROM layoffs_staging2
WHERE total_laid_off is NULL AND percentage_laid_off is NULL;

-- sense check everything at the end 
SELECT * 
FROM layoffs_staging2;

-- how to did a column in a table
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

