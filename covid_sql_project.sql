-- going through the tables
SELECT * FROM CovidVacc ORDER BY 3,4; -- CHECKING THE DATA ACROSS TABLE 1

SELECT * FROM coviddeaths ORDER BY 3,4; -- CHECKING THE DATA ACROSS TABLE 2

----------------------------------------------------------------------------------------------------------
/* TOTAL CASES VS TOTAL DEATHS*/
-- Looking at total cases vs total deaths
SELECT location, dates, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) DeathPercentage
FROM coviddeaths
WHERE continent != 'None'
ORDER BY location, dates; 

SELECT location, dates, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) DeathPercentage
FROM coviddeaths
WHERE location LIKE '%India%' -- checking with records of my country
AND continent != 'None'
ORDER BY location, dates; 

-- checking the total cases and deaths by location 
SELECT location, MAX(total_cases) Total_Cases, MAX(total_deaths) Total_Deaths, 
ROUND((MAX(total_deaths)/MAX(total_cases))*100,2) Death_percentage
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1
ORDER BY Total_Cases DESC; 

-- continent wise total cases and deaths 
SELECT continent, dates, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) DeathPercentage
FROM coviddeaths
WHERE continent != 'None'
ORDER BY continent, dates; 

SELECT continent, MAX(total_cases) Total_Cases, MAX(total_deaths) Total_Deaths, 
ROUND((MAX(total_deaths)/MAX(total_cases))*100,2) Death_percentage
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1
ORDER BY Total_Cases DESC; 

/* To avoid duplicacy in total no of caes we use max function instead of sum
to count total cases grouping by location OR We could have summed the new cases which 
would be giving us the same result.
*/

----------------------------------------------------------------------------------------------------

-- looking at TOTAL CASES AND POPULATION
-- location with dates trend
SELECT location, dates, total_cases, population, ROUND((total_cases/population)*100,2) percentage_of_population
FROM coviddeaths
WHERE continent != 'None'
ORDER BY location, dates;

-- location wise overall
SELECT location, MAX(total_cases) TotalCases, MAX(population) Population, ROUND(MAX((total_cases/population))*100,2) percentage_of_population
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1
ORDER BY location;

SELECT location, dates, total_cases, population, ROUND((total_cases/population)*100,2) percentage_of_population
FROM coviddeaths
WHERE location LIKE '%India%' -- wrt. my country 
AND continent != 'None'
ORDER BY location, dates;

-- continent wise with dates (trend)
SELECT continent, dates, total_cases, population, ROUND((total_cases/population)*100,2) percentage_of_population
FROM coviddeaths
WHERE continent != 'None'
ORDER BY continent, dates;

-- continent wise overall
SELECT continent, MAX(total_cases) TotalCases, MAX(population) Population, ROUND(MAX((total_cases/population))*100,2) percentage_of_population
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1
ORDER BY continent;

-------------------------------------------------------------------------------------------------------

-- Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) Total_Cases, ROUND(MAX((total_cases/population))*100,2) Max_Infected_rate
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1, 2
ORDER BY Max_Infected_rate DESC;

SELECT location, population, MAX(total_cases) Total_Cases, ROUND(MAX((total_cases/population))*100,2) Max_Infected_rate
FROM coviddeaths
WHERE location LIKE '%India%' -- wrt. my country
AND continent != 'None'
GROUP BY 1, 2
ORDER BY Max_Infected_rate DESC;

------------------------------------------------------------------------------------------------------

-- Finding countries with highest DeathCount per population
SELECT location, MAX(total_deaths) Total_Deaths
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1
ORDER BY Total_Deaths DESC;

SELECT location, MAX(total_deaths) Total_Deaths
FROM coviddeaths
WHERE location LIKE '%India%' -- wrt my country
AND continent != 'None'
GROUP BY 1
ORDER BY Total_Deaths DESC;

-- taking things by continent
SELECT continent, MAX(total_deaths) Total_Deaths
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1
ORDER BY Total_Deaths DESC;

---------------------------------------------------------------------------------------------------------

-- Global Numbers for new deaths and cases
SELECT dates, SUM(new_cases) NewCases, SUM(new_deaths) NewDeaths, ROUND(((SUM(new_deaths))/(SUM(new_cases)))*100,2) DeathPercentageGlobally
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1
ORDER BY dates; 

-- Overall summary of total cases and deaths
SELECT SUM(new_cases) TotalCases, SUM(new_deaths) TotalDeaths, ROUND(((SUM(new_deaths))/(SUM(new_cases)))*100,2) DeathPercentageGlobally
FROM coviddeaths
WHERE continent != 'None';

CREATE VIEW Overall_CasesAndDeaths AS -- creating view for later visualization purposes
SELECT SUM(new_cases) TotalCases, SUM(new_deaths) TotalDeaths, ROUND(((SUM(new_deaths))/(SUM(new_cases)))*100,2) DeathPercentageGlobally
FROM coviddeaths
WHERE continent != 'None';

SELECT * FROM Overall_CasesAndDeaths;

-----------------------------------------------------------------------------------------------------------

-- checking with NEW_Vaccinations vs New Cases
SELECT cv.Continent, cv.location, cv.dates, cv.new_vaccinations, cd.new_cases
FROM covidvacc cv
JOIN covidDeaths cd
	ON cd.location = cv.location AND cd.dates = cv.dates
WHERE cv.continent != 'None'
ORDER BY 1, 2,3;

-- checking vaccination, total cases trend in India
SELECT cv.location, cv.dates, SUM(cv.new_vaccinations) TotalVaccinations, SUM(cd.new_cases) TotalCases
FROM covidvacc cv
JOIN covidDeaths cd
	ON cd.location = cv.location AND cd.dates = cv.dates
WHERE cv.location LIKE '%India%'
AND cv.continent != 'None'
GROUP BY 1,2
ORDER BY 1, 2;


-- Total Vaccinations vs Total Cases with location wise
SELECT cv.Continent, cv.location, SUM(cv.new_vaccinations) TotalVaccinations, SUM(cd.new_cases) TotalCases
FROM covidvacc cv
JOIN covidDeaths cd
	ON cd.location = cv.location AND cd.dates = cv.dates
WHERE cv.continent != 'None'
GROUP BY 1, 2
ORDER BY 1, 2;


-- Total Vaccinations vs Total Deaths with location wise
SELECT cv.Continent, cv.location, SUM(cv.new_vaccinations) TotalVaccinations, SUM(cd.new_deaths) TotalDeaths
FROM covidvacc cv
JOIN covidDeaths cd
	ON cd.location = cv.location AND cd.dates = cv.dates
WHERE cv.continent != 'None'
GROUP BY 1, 2
ORDER BY 1, 2;


-- Total Vaccinations vs Total Cases vs Total Deaths with location wise
SELECT cv.Continent, cv.location, SUM(cv.new_vaccinations) TotalVaccinations, MAX(cd.total_deaths) TotalDeaths,
SUM(cd.new_cases) TotalCases
FROM covidvacc cv
JOIN covidDeaths cd
	ON cd.location = cv.location AND cd.dates = cv.dates
WHERE cv.continent != 'None'
GROUP BY 1, 2
ORDER BY 1, 2;



/*---------------------------------------------------------------------------------------------------------*/

-- Total Population vs vaccinations
SELECT cd.continent, cd.location, cd.dateS, cd.population, cv.new_vaccinations
FROM coviddeaths cd
	JOIN covidvacc cv 
		ON cd.dates = cv.dates AND cd.location = cv.location
WHERE cv.continent != 'None'
ORDER BY 1,2,3;

-- RollingPopulationVaccination by location
SELECT cd.continent, cd.location, cd.dateS, cd.population, cv.new_vaccinations,
SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.location, cd.dates) RollingPeopleVaccinated
FROM coviddeaths cd
	JOIN covidvacc cv 
		ON cd.dates = cv.dates AND cd.location = cv.location
WHERE cv.continent != 'None'
ORDER BY 1,2,3;

-- Creating CTE for previous query 
WITH pop_vs_vacc (Continent, Location, Date, Population, New_Vaccination, RollingPeopleVaccinated)
AS
(
SELECT cd.continent, cd.location, cd.dates, cd.population, cv.new_vaccinations,
SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.location, cd.dates) RollingPeopleVaccinated
FROM coviddeaths cd
	JOIN covidvacc cv 
		ON cd.dates = cv.dates AND cd.location = cv.location
WHERE cv.continent != 'None'
)
SELECT *, (RollingPeopleVaccinated/Population)*100 RollingPeopleVaccinated_percent_population
FROM pop_vs_vacc;

-- creating the previous query by temporary table
CREATE TEMPORARY TABLE RollingPupilVaccinated
SELECT cd.continent, cd.location, cd.dateS, cd.population, cv.new_vaccinations,
SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.location, cd.dates) RollingPeopleVaccinated
FROM coviddeaths cd
	JOIN covidvacc cv 
		ON cd.dates = cv.dates AND cd.location = cv.location
WHERE cv.continent != 'None';

SELECT *, (RollingPeopleVaccinated/Population)*100 RollingPeopleVaccinated_percent_population
FROM RollingPupilVaccinated;



-- creating view for previous query for later visualization purpose
CREATE VIEW PercentPeopleVaccinated AS
SELECT cd.continent, cd.location, cd.dateS, cd.population, cv.new_vaccinations,
SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.location, cd.dates) RollingPeopleVaccinated
FROM coviddeaths cd
	JOIN covidvacc cv 
		ON cd.dates = cv.dates AND cd.location = cv.location
WHERE cd.continent IS NOT NULL;


-----------------------------------------------------------------------------------------------------------
-- EXPLORING DATA 

/* 2. Identify the locations where the new_cases_smoothed_per_million 
exceeded 100 for at least five consecutive days.*/
WITH ConsecutiveDays AS (
    SELECT 
        location,
        dates,
        new_cases_smoothed_per_million,
        ROW_NUMBER() OVER (PARTITION BY location ORDER BY dates) -
        ROW_NUMBER() OVER (PARTITION BY location, new_cases_smoothed_per_million > 100 ORDER BY dates) AS group_id
    FROM coviddeaths
)
SELECT DISTINCT location
FROM ConsecutiveDays
WHERE new_cases_smoothed_per_million > 100
GROUP BY location, group_id
HAVING COUNT(*) >= 5 ;





/* Calculate the weekly percentage change in new_cases for each location, and 
find the location with the highest and lowest percentage change. */
WITH WeeklyPercentageChange AS (
    SELECT location, dates, new_cases,
           (new_cases - LAG(new_cases,7) OVER (PARTITION BY location ORDER BY dates)) / LAG(new_cases,7) OVER (PARTITION BY location ORDER BY dates) * 100 AS percentage_change
    FROM coviddeaths
)
SELECT location,
       ROUND(MAX(percentage_change),2) AS highest_percentage_change,
       ROUND(MIN(percentage_change),2) AS lowest_percentage_change
FROM WeeklyPercentageChange
GROUP BY location;

/* For locations with a population above 10 million, find the date when 
they reached a total_cases_per_million of 1000 for the first time. */
SELECT location, MIN(dates) date, MAX(total_cases_per_million) total_cases_per_million
FROM coviddeaths
WHERE population > 10000000 
AND total_cases_per_million > 1000
AND continent != 'None'
GROUP BY 1;


/* Calculate the average reproduction_rate for each continent and determine which continent
 had the highest average reproduction rate. */
 SELECT continent, ROUND(AVG(reproduction_rate),2) Avg_reproduction_rate
 FROM coviddeaths
 WHERE continent != 'None'
 GROUP BY 1
 ORDER BY Avg_reproduction_rate DESC;
 
 
 /* Identify locations where the total_cases_per_million is below the median value 
 of total_cases_per_million for all locations in the dataset.*/

SELECT cd.total_cases_per_million INTO @median_total_cases_per_million
FROM
(SELECT location, total_cases_per_million,
ROW_NUMBER() OVER(ORDER BY location) row_numberr,
COUNT(*) OVER() AS rn
FROM coviddeaths
) cd
WHERE cd.row_numberr = ((rn+1)/2);
 
SELECT cd.location, MAX(cd.total_cases_per_million) total_cases_per_million
FROM coviddeaths cd
WHERE total_cases_per_million < @median_total_cases_per_million
GROUP BY 1;


/* Calculate the ratio of total_cases_per_million to hospital_beds_per_thousand for 
each location and date, and identify locations where this ratio exceeds 100.*/
SELECT cd.location, cd.dates, ROUND(MAX(cd.total_cases_per_million/cv.hospital_beds_per_thousand),2) ratio_of_cases_to_hospitalbeds
FROM coviddeaths cd
LEFT JOIN covidvacc cv
ON cd.location = cv.location AND cd.dates = cv.dates
WHERE cd.total_cases_per_million/cv.hospital_beds_per_thousand > 100
GROUP BY 1,2;

-------------------------------------------------------------------------------------------------------
-- EXPLORING DATA FOR CovidVaccination

-- What is the Average positive rate for each continent in the dataset?

SELECT Continent, ROUND(AVG(positive_rate),2) Avg_positive_rate
FROM covidvacc
WHERE continent != 'None'
GROUP BY 1;


/* Which location had the highest number of new tests conducted 
on a single day, and what was the date and the number of tests? */
SELECT location, dates, MAX(new_tests) no_of_tests
FROM covidvacc
WHERE continent != 'None'
GROUP BY 1,2
ORDER BY no_of_tests DESC;


 -- Calculate the 7-day rolling average of new vaccinations for each location and date.
SELECT location, dates, new_vaccinations, AVG(new_vaccinations) OVER(PARTITION BY location ORDER BY dates ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) seven_dayrolling_avg
FROM covidvacc
WHERE continent != 'None'
ORDER BY 1,2;


/* For each continent, find the average new_tests_per_thousand for the first 
quarter (January to March) of 2021. */
SELECT continent, ROUND(AVG(new_tests_per_thousand),2) Avg_NewTests_per_thousand
FROM covidvacc
WHERE dates BETWEEN '2021-01-01' AND '2021-03-31'
AND continent != 'None'
GROUP BY 1;


/*  Identify the top 5 locations with the highest total_tests_per_thousand 
for the entire period in the dataset. */
SELECT location, MAX(total_tests_per_thousand) total_tests_per_thousand
FROM covidvacc
WHERE continent != 'None'
GROUP BY 1
ORDER BY total_tests_per_thousand DESC
LIMIT 5;


-- Calculate the median value of population_density for all locations in Asia.
SELECT ROUND(AVG(cv.population_density),2) median_for_population_density
FROM
(SELECT location, population_density,
ROW_NUMBER() OVER(ORDER BY location) row_numberr,
COUNT(*) OVER() AS rn
FROM covidvacc cv
WHERE continent LIKE '%Asia%'
) cv
WHERE cv.row_numberr IN ((rn+2)/2, rn/2);


/* 	Find the location with the highest gdp_per_capita and the location with the 
lowest gdp_per_capita for the latest date available. */
SELECT 
location, MAX(dates) latest_date, MAX(gdp_per_capita) highest_gdp
FROM covidvacc
WHERE continent != 'None'
GROUP BY 1
ORDER BY 3 DESC
LIMIT 1;

SELECT location, MAX(dates) latest_date, MIN(gdp_per_capita) lowest_gdp
FROM covidvacc
WHERE gdp_per_capita IS NOT NULL
AND continent != 'None'
GROUP BY 1
ORDER BY 3 
LIMIT 1;


------------------------------------------------------------------------------------------------------

--  Calculate the total number of new cases reported per continent for each date in the dataset.
SELECT Continent, dates, SUM(new_cases) Total_NewCases
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1,2
ORDER BY 1,2;

/*  Find the top 5 locations with the highest total number of tests conducted 
(summing new_tests) for each continent. */

SELECT Continent, location, Total_tests
FROM 
(SELECT Continent, location, Total_tests, ROW_NUMBER() OVER(PARTITION BY continent ORDER BY Total_tests DESC) n
FROM (SELECT Continent, location, SUM(new_tests) Total_tests
FROM covidvacc
WHERE continent != 'None'
GROUP BY 1,2
ORDER BY 3 DESC) Y
) X
WHERE n <= 5;


-- Calculate the percentage of people vaccinated (people_fully_vaccinated) for each location and date.
SELECT cv.location, cv.dates, MAX(people_fully_vaccinated), (MAX(cv.people_fully_vaccinated)/MAX(cd.population))*100 percent_of_vaccinated_people
FROM covidvacc cv
LEFT JOIN coviddeaths cd
ON cd.location = cv.location AND cd.dates = cv.dates
WHERE continent != 'None'
GROUP BY 1, 2;



-- 	Calculate the average number of new cases per million people for each continent and date.
SELECT continent, dates, ROUND(AVG(new_cases_per_million),2) Avg_new_cases
FROM coviddeaths
WHERE continent != 'None'
GROUP BY 1,2;


/* 	Find the locations with the highest ratio of total cases to total tests conducted 
(total_cases/total_tests) for each date.*/
SELECT cd.location, cd.dates, ROUND((cd.total_cases/cv.total_tests),2) ratio_of_cases_to_tests
FROM coviddeaths cd
JOIN covidvacc cv
ON cd.location = cv.location AND cv.dates = cd.dates
WHERE continent != 'None'
ORDER BY ratio_of_cases_to_tests DESC;


-- 	Calculate the 7-day rolling average of new cases (new_cases) for each location and date.
SELECT location, dates, new_cases, 
AVG(new_cases) OVER(PARTITION BY location ORDER BY dates ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) seven_dayrolling_avg
FROM coviddeaths
WHERE continent != 'None'
ORDER BY 1,2;


/* Identify the dates and locations where the percentage of new cases (new_cases) 
compared to the previous day is above 10%. */
SELECT location, dates, new_cases, ROUND((new_cases / prev_day_cases)*100,2) percentage_of_NewCases
FROM (
SELECT location, dates, new_cases, lag(new_cases,1) OVER(ORDER BY location, dates) prev_day_cases
FROM coviddeaths) t
WHERE (new_cases / prev_day_cases)*100 > 10
;


/* Calculate the average human development index (HDI) for each continent and date, considering 
data from both tables. */
SELECT continent, dates, ROUND(AVG(human_development_index),2) Avg_Human_Dev_Index
FROM covidvacc
WHERE continent != 'None'
GROUP BY 1, 2
ORDER BY 1,2;


/* 	Find the locations where the median age is below the overall median age, and 
the percentage of people aged 65 or older is above the overall median for each date available. */ 

SELECT cv.median_age INTO @median_for_overall_med_age
FROM
(SELECT location, dates, median_age,
ROW_NUMBER() OVER(ORDER BY location) row_numberr,
COUNT(*) OVER() AS rn
FROM covidvacc 
) cv
WHERE cv.row_numberr IN ((rn+1)/2);

SELECT cv.aged_65_older INTO @median_for_overall_aged_65_older
FROM
(SELECT location, dates, aged_65_older,
ROW_NUMBER() OVER(ORDER BY location) row_numberr,
COUNT(*) OVER() AS rn
FROM covidvacc 
) cv
WHERE cv.row_numberr IN ((rn+1)/2);


SELECT location, dates, median_age, aged_65_older
FROM covidvacc
WHERE median_age < @median_for_overall_med_age AND aged_65_older > @median_for_overall_aged_65_older;

