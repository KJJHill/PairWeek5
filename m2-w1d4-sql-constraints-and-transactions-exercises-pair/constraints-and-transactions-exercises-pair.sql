-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The 
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on 
-- Wikipedia.)

INSERT INTO [dbo].[city]
			([name],
			[district],
			[population],
			[countrycode])
			VALUES
			('Smallville',
			'Kansas',
			45001,
			'USA')

-- test, for above ^ -->  SELECT * FROM city WHERE population = 45001;

-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.

INSERT INTO [dbo].[countrylanguage]
		([countrycode],
		[language],
		[isofficial],
		[percentage])
		VALUES
		('USA',
		'Kryptonese',
		0,
		.0001)

--  test,  for above ^ --> SELECT * FROM countrylanguage WHERE language = 'Kryptonese';

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change 
-- the appropriate record accordingly.

UPDATE [dbo].[countrylanguage]
     SET language = 'Krypto-babble'
	 WHERE language = 'Kryptonese';	

-- test, for above ^ ---> SELECT * FROM countrylanguage WHERE language like 'Krypto%';

-- 4. Set the US captial to Smallville, Kansas in the country table.

UPDATE [dbo].[country]
	SET capital = 4081
	WHERE code = 'USA'

--> test, for the above ^ ----> SELECT * from country WHERE code = 'USA'


-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

DELETE 
 FROM city WHERE name = 'Smallville'
  

-- **No, because an affected column is connected via foreign key to the country table, where it is referenced.

-- 6. Return the US capital to Washington.

UPDATE [dbo].[country]
	SET capital = 3813
	WHERE code = 'USA'

--> test, for the above ^ ----> SELECT * from country WHERE code = 'USA'

-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

DELETE 
 FROM city WHERE name = 'Smallville'

-- test, for the above ^ ----> SELECT * FROM city WHERE name = 'Smallville';

-- Yes, it worked.  Because the foreign key was removed as a reference in the country table


-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972 
-- (exclusive). 
-- (590 rows affected)

UPDATE [dbo].[countrylanguage]
	SET isofficial = ~ isofficial
	FROM countrylanguage
	JOIN country ON country.code = countrylanguage.countrycode
	WHERE indepyear BETWEEN 1800 AND 1972

-- confirmed 590 rows affected

-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4068 rows affected)

UPDATE [dbo].[city]
		SET population = (round(population, -3) / 1000)


-- 10. Assuming a country's surfacearea is expressed in miles, convert it to 
-- meters for all countries where French is spoken by more than 20% of the 
-- population.
-- (7 rows affected)

UPDATE [dbo].[country]
	SET surfacearea = surfacearea * 2589988.11
	FROM country
	JOIN countrylanguage ON countrylanguage.countrycode = country.code
	WHERE language = 'French' AND percentage > 20
