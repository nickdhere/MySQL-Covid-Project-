# Data Analytics Portfolio Project on Covid 
## COVID Data Analysis Project

## Overview

This GitHub repository contains the code for a COVID-19 data analysis project conducted by Nikhil. The project utilizes SQL queries to analyze and extract valuable insights from a dataset related to COVID-19, including information about cases, deaths, vaccinations, population, and other relevant factors. This README file provides an overview of the project, instructions for running the SQL queries, and a summary of the questions addressed in the analysis.

## Project Description

The COVID-19 pandemic has had a profound impact on countries and continents worldwide. This project aims to explore and analyze COVID-19 data to gain insights into various aspects of the pandemic. The dataset used for this analysis includes information on cases, deaths, vaccinations, population, and more, organized by location and date.

The analysis focuses on answering key questions related to COVID-19, such as:

## Questions Explored

### Total Cases and Deaths
1. How do total cases relate to total deaths, and what is the death percentage?
2. What is the trend of total cases and deaths for specific locations, like India?
3. Which locations have the highest total cases and deaths, and what is the death percentage by location?
4. What is the trend of total cases and deaths by continent, and which continents have the highest total cases and deaths?

### Cases vs. Population
5. What is the percentage of total cases relative to the population for various locations?
6. What is the trend of total cases and population for specific locations, like India?
7. What is the percentage of total cases relative to the population by continent?
8. What are the locations with the highest infection rates compared to population size?
9. What are the locations with the highest death counts per population?

### Global Statistics
10. What are the global numbers for new cases, new deaths, and the death percentage?
11. What is the overall summary of total cases and deaths globally?

### Vaccinations
12. How do new vaccinations correlate with new cases?
13. What is the trend of new vaccinations and new cases for India?
14. How do total vaccinations relate to total cases and total deaths by location?
15. How do total vaccinations relate to total deaths by location, considering new cases as well?

### Population vs. Vaccinations
16. How does population relate to new vaccinations, and what is the rolling population vaccinated?
17. What is the percentage of people vaccinated relative to the population for each location and date?

### Data Exploration
18. Identify locations with consecutive days of high new cases per million.
19. Calculate the weekly percentage change in new cases.
20. Find the date when locations reached a total cases per million of 1000 for the first time.
21. Calculate the average reproduction rate for each continent.
22. Identify locations with total cases per million below the median value.
23. Calculate the ratio of total cases per million to hospital beds per thousand.
24. What is the Average positive rate for each continent in the dataset?
25. Which location had the highest number of new tests conducted 
on a single day, and what was the date and the number of tests?
26. Calculate the 7-day rolling average of new vaccinations for each location and date.
27. For each continent, find the average new_tests_per_thousand for the first 
quarter (January to March) of 2021.
28. Identify the top 5 locations with the highest total_tests_per_thousand 
for the entire period in the dataset.
29. Calculate the median value of population_density for all locations in Asia.
30. Find the location with the highest gdp_per_capita and the location with the 
lowest gdp_per_capita for the latest date available.
31. Calculate the total number of new cases reported per continent for each date in the dataset.
32. Find the top 5 locations with the highest total number of tests conducted 
(summing new_tests) for each continent.
33. Calculate the percentage of people vaccinated (people_fully_vaccinated) for each location and date.
34. Calculate the average number of new cases per million people for each continent and date.
35. Find the locations with the highest ratio of total cases to total tests conducted 
(total_cases/total_tests) for each date.
36. Calculate the 7-day rolling average of new cases (new_cases) for each location and date.
37. Identify the dates and locations where the percentage of new cases (new_cases) 
compared to the previous day is above 10%.
38. Calculate the average human development index (HDI) for each continent and date, considering 
data from both tables.
39. Find the locations where the median age is below the overall median age, and 
the percentage of people aged 65 or older is above the overall median for each date available.


## How to Run the Code

To run the SQL queries in this project, you will need access to a MySQL database. Follow these steps:

1. Ensure you have MySQL installed on your machine.
2. Create a new database or use an existing one.
3. Load the COVID-19 dataset into your database.
4. Open a MySQL client or use a command-line tool to connect to your database.
5. Copy and paste the SQL code from the provided code file into the client or tool.
6. Execute the SQL queries one by one.

Make sure to replace any placeholders in the code, such as database names or credentials, with your own configuration.

## Data Sources

The dataset used in this project contains COVID-19 data and vaccination data from various sources and organizations. Ensure that you have the necessary permissions to access and use the data for analysis.

## Summary

This COVID-19 data analysis project provides valuable insights into the pandemic's impact on different locations, populations, and other relevant factors. By running the SQL queries provided, you can explore the data and answer important questions related to COVID-19's spread and impact.

Feel free to use and adapt this code for your own analysis or research purposes. If you have any questions or need assistance, please reach out to Nikhil.
