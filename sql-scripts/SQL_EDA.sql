use world_layoffs;

-- Exploratory Data Analysis
Select * from layoffs_staging2;

-- 1. Which industry was impacted the MOST due to layoffs

SELECT industry, SUM(total_laid_off) AS total_laid_off
from layoffs_staging2
Group BY industry
ORDER BY total_laid_off desc; 

-- 2. Which industries country-wise  was impacted due to layoffs

SELECT country, industry, SUM(total_laid_off) AS total_laid_off, 
DENSE_RANK() OVER(partition BY country ORDER BY SUM(total_laid_off) DESC ) AS ranking
from layoffs_staging2
Group BY country, industry
HAVING total_laid_off IS NOT NULL
ORDER by country desc , total_laid_off desc;

-- 3. Top 3 companies laid off the employees

SELECT company, SUM(total_laid_off) AS total_laid_off
from layoffs_staging2
Group BY company
HAVING total_laid_off IS NOT NULL
ORDER by total_laid_off desc
LIMIT 10;

-- 4. Year wise stats

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT YEAR(`date`) AS year_, SUM(total_laid_off) AS total_laid_off
from layoffs_staging2
Group BY year_
ORDER BY 1 desc; 

-- 5. Layoffs Vs Stage 

SELECT stage, SUM(total_laid_off) AS total_laid_off
from layoffs_staging2
Group BY stage
ORDER BY 2 desc; 

SELECT stage, company, percentage_laid_off,
DENSE_RANK() OVER (partition by stage ORDER by percentage_laid_off desc) as row_num
from layoffs_staging2
WHERE total_laid_off IS NOT NULL
AND percentage_laid_off IS NOT NULL
AND stage IS NOT NULL;

-- 6.  Rolling total number of layoff by year-month 

WITH rolling_total AS
(
SELECT SUBSTRING(`date`,1,7) AS timeline, SUM(total_laid_off) AS total_laid_off
from layoffs_staging2
GROUP BY timeline
HAVING timeline IS NOT NULL
ORDER BY 1 ASC
)
SELECT timeline, total_laid_off, 
SUM(total_laid_off) OVER(ORDER BY timeline) AS rolling_total
FROM rolling_total;

-- 7. Companies layoff per year 

WITH company_year AS
(
SELECT company, YEAR(`date`) AS years_, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company, years_
),
company_year_rank AS
(
SELECT *,
DENSE_RANK() OVER (partition by years_ order by total_laid_off desc) as ranking
FROM company_year
WHERE years_ IS NOT NULL
)
SELECT * from company_year_rank
WHERE ranking <= 5;