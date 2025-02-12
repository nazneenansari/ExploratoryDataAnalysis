use world_layoffs;

Select * From layoffs;

-- CREATE Staging table and copy all the rows from the main table 
CREATE TABLE layoffs_staging
LIKE layoffs;

Select * from layoffs_staging;

INSERT Layoffs_staging
SELECT *
FROM layoffs;

-- DATA CLEANING
-- 1. Remove Duplicate 

WITH CTE AS
(
SELECT *,
ROW_NUMBER() OVER(partition by company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
Select * from CTE 
WHERE row_num > 1;

-- Create another table with row_num as there is no PK in the data 
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * from layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(partition by company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging; 

DELETE from layoffs_staging2 
WHERE row_num > 1;

SELECT * from layoffs_staging2 
WHERE row_num > 1;

-- 2. Standardize Data

SELECT * from layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

########################
Select Distinct location 
From layoffs_staging2
Order by 1;

########################
Select Distinct country 
From layoffs_staging2
Order by 1;

Update layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

########################
Select Distinct industry 
From layoffs_staging2
Order by 1;

Update layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

########################
Select `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
from layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER Table layoffs_staging2
modify column `date` DATE ;

-- 3. Handle Null Values or Blank Values 

SELECT * FROM layoffs_staging2
WHERE industry is NULL 
OR industry = '';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL;

SELECT * FROM layoffs_staging2
WHERE company LIKE 'BALLY%';

-- 4. Remove any columns
Select * from layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

DELETE from layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

########################
Alter Table layoffs_staging2
Drop COLUMN row_num;

Select * from layoffs_staging2;