-- Write queries to return the following:
-- The following queries utilize the "world" database.

-- 1. The city name, country name, and city population of all cities in Europe with population greater than 1 million
--    Expected rows: 36
SELECT city.name AS 'City Name', country.name AS 'Country Name', city.population As 'Population' FROM city 
JOIN country ON city.countrycode = country.code 
WHERE city.population > 1000000 AND country.continent = 'Europe';

-- 2. The city name, country name, and city population of all cities in countries where French 
--is an official language and the city population is greater than 1 million
--    Expected rows: 2

--thought notes: Select city.name, country.name, countrylanguage.countrycode, city.population
--city table for city name, city population > 10000000
--countrylanguage table countrylanguage.official, countrylanguage.language

SELECT city.name AS 'City Name', country.name AS 'Country Name' , city.population AS 'Population' FROM city 
JOIN countrylanguage ON city.countrycode = countrylanguage.countrycode
JOIN country ON city.countrycode = country.code
WHERE city.population  > 1000000 AND language = 'FRENCH' AND isofficial = 1;



-- 3. The name of the countries and continents where the language Javanese is spoken
--    Expected rows: 1

SELECT name, continent FROM country
JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE language = 'Javanese';



-- 4. The names of all of the countries in Africa that speak French as an official language
--    Expected rows: 5

SELECT name AS 'Name' FROM country
JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE language = 'French' AND isofficial = 1 and continent = 'Africa';


-- 5. The average city population of cities in Europe
--    Expected: 287,684

SELECT AVG(city.population) AS 'Average Population' FROM city
JOIN country ON city.countrycode = country.code
WHERE continent = 'Europe'

-- 6. The average city population of cities in Asia
--    Expected: 395,019

SELECT AVG(city.population) AS 'Average Population' FROM city
JOIN country ON city.countrycode = country.code
WHERE continent = 'Asia'


-- 7. The number of cities in countries where English is an official language
--    Expected: 523

SELECT COUNT(name) FROM city
JOIN countrylanguage ON city.countrycode = countrylanguage.countrycode
WHERE language = 'ENGLISH' AND isofficial = 1;

-- 8. The average population of cities in countries where the official language is English
--    Expected: 285,809
SELECT AVG(city.population) AS 'Average Population' FROM city
JOIN countrylanguage ON city.countrycode = countrylanguage.countrycode
WHERE language = 'ENGLISH' AND isofficial = 1;

-- 9. The names of all of the continents and the population of the continent’s largest city
--    Expected rows: 6, largest population for North America: 8,591,309

SELECT continent, MAX(city.population) AS 'Max Population' FROM city 
JOIN country ON city.countrycode = country.code  
GROUP BY continent;

-- 10. The names of all of the cities in South America that have a population of more than
-- 1 million people and the official language of each city’s country
--     Expected rows: 29

SELECT city.name FROM city 
JOIN country ON city.countrycode = country.code
JOIN countrylanguage ON city.countrycode = countrylanguage.countrycode
WHERE isofficial = 1 AND city.population > 1000000 AND continent = 'South America';