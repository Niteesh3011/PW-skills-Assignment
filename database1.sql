1. Count how many cities are there in each country?
We join the country and city tables to count the cities associated with each country name.

SQL

SELECT co.Name AS Country_Name, COUNT(ci.ID) AS City_Count
FROM country co
JOIN city ci ON co.Code = ci.CountryCode
GROUP BY co.Name;


2. Display all continents having more than 30 countries.
We use HAVING to filter results after grouping the countries by continent.

SQL

SELECT Continent, COUNT(*) AS Country_Count
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;


3. List regions whose total population exceeds 200 million.
We sum the population for each region and filter for those above 200 million.

SQL

SELECT Region, SUM(Population) AS Total_Population
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000;


4. Find the top 5 continents by average GNP per country.
We calculate the average GNP, order them descending, and limit the result to the top 5.

SQL

SELECT Continent, AVG(GNP) AS Avg_GNP
FROM country
GROUP BY Continent
ORDER BY Avg_GNP DESC
LIMIT 5;


5. Find the total number of official languages spoken in each continent.
We join the country table with the language table and filter only for languages where IsOfficial is 'T' (True).

SQL

SELECT c.Continent, COUNT(cl.Language) AS Official_Language_Count
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent;


6. Find the maximum and minimum GNP for each continent.
This query aggregates the highest and lowest GNP values found within each continent group.

SQL

SELECT Continent, MAX(GNP) AS Max_GNP, MIN(GNP) AS Min_GNP
FROM country
GROUP BY Continent;


7. Find the country with the highest average city population.
This requires calculating the average city size per country, sorting highest to lowest, and taking the top result.

SQL

SELECT co.Name, AVG(ci.Population) AS Avg_City_Population
FROM country co
JOIN city ci ON co.Code = ci.CountryCode
GROUP BY co.Name
ORDER BY Avg_City_Population DESC
LIMIT 1;


8. List continents where the average city population is greater than 200,000.
Here we calculate the average population of all cities within a continent (joining city to country to get the continent).

SQL

SELECT co.Continent, AVG(ci.Population) AS Avg_City_Population
FROM country co
JOIN city ci ON co.Code = ci.CountryCode
GROUP BY co.Continent
HAVING AVG(ci.Population) > 200000;


9. Find the total population and average life expectancy for each continent, ordered by average life expectancy descending.
SQL

SELECT Continent, 
       SUM(Population) AS Total_Population, 
       AVG(LifeExpectancy) AS Avg_Life_Expectancy
FROM country
GROUP BY Continent
ORDER BY Avg_Life_Expectancy DESC;


10. Find the top 3 continents with the highest average life expectancy, but only include those where total population is over 200 million.
This combines a WHERE/HAVING filter on population size with a sort on life expectancy.

SQL

SELECT Continent, AVG(LifeExpectancy) AS Avg_Life_Expectancy
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY Avg_Life_Expectancy DESC
LIMIT 3;