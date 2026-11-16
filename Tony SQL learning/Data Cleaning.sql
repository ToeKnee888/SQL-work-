-- Data Cleaning 


SELECT * 
FROM layoffs;

 -- 1. Remove Duplicates
 -- 2. Standarize the Data
 -- 3. Null Value or Blank Values
 -- 4. Remove any Columns
 

 CREATE TABLE Layoffs_staging -- creates a table like layoffs with the headers, but no information inside
 LIKE layoffs;
 
 
 SELECT * 
 FROM layoffs_staging;
 
 INSERT layoffs_staging -- Brings all the data over
 SELECT * 
 FROM layoffs;
 
 
 -- This SQL uses a Window Function called ROW_NUMBER() to assign a unique number to each row based on certain matching values.
 -- ROW_NUMBER = Assigns a sequential number to each row.
 -- OVER() - Tells SQL how to calculate the window function.
 -- PARTITION BY - - It groups rows with matching values together before assigning row numbers.
 SELECT *,
 ROW_NUMBER() OVER (
 PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
 FROM layoffs_staging;
 
 WITH duplicate_cte AS
 (
 SELECT *,
 ROW_NUMBER() OVER (
 PARTITION BY company, location, 
 industry, total_laid_off, percentage_laid_off, `date`,stage
 , country, funds_raised_millions) AS row_num
 FROM layoffs_staging
 )
 SELECT * 
 FROM duplicate_cte
 WHERE row_num > 1;
 
 SELECT * 
 FROM layoffs_staging
 WHERE company = 'Casper';
 
CREATE TABLE `Layoffs_staging2` (
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

 
 SELECT * 
 FROM layoffs_staging2
 WHERE row_num >1;
 
 
INSERT INTO layoffs_staging2
 SELECT *,
 ROW_NUMBER() OVER (
 PARTITION BY company, location, 
 industry, total_laid_off, percentage_laid_off, `date`,stage
 , country, funds_raised_millions) AS row_num
 FROM layoffs_staging;
 
 DELETE
 FROM layoffs_staging2
 WHERE row_num >1;
 
 
 SELECT *
 FROM layoffs_staging2;
 
 
 -- STANDARDIZING DATA
 SELECT Company,TRIM(company)
 FROM layoffs_staging2;
 
 UPDATE layoffs_staging2
 SET Company = TRIM(company);
 
 SELECT *
 FROM layoffs_staging2
 WHERE industry LIKE 'Crypto%';
 
 UPDATE layoffs_staging2
 SET industry = 'Crypto'
 WHERE industry LIKE 'Crypto%';
 
 SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
 FROM layoffs_staging2
 ORDER BY 1;
 
 UPDATE layoffs_staging2
 SET COUNTRY = TRIM(TRAILING '.' FROM country)
 WHERE country LIKE 'United States%';
 
 SELECT `date`, 
 STR_TO_DATE(`date`, '%m/%d/%Y')
 FROM layoffs_staging2;
 
 UPDATE layoffs_staging2
 SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
 
SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

 SELECT *
 FROM layoffs_staging2
 WHERE Total_laid_off is NULL;
 
 SELECT *
 FROM layoffs_staging2
 WHERE Total_laid_off is NULL
 AND percentage_laid_off IS NULL;
 
 SELECT *
 FROM layoffs_staging2
 WHERE industry IS NULL
 OR industry = '';
 
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT * 
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';
 
 
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

SELECT * 
from layoffs_staging2
WHERE total_laid_off is NULL
and percentage_laid_off is null;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off is NULL
and percentage_laid_off is null;

SELECT * 
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;
 