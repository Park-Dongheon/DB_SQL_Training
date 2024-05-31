-- SELECT count(*)
-- FROM city
-- GROUP BY CountryCode;

-- SELECT Name, Population
-- FROM city
-- WHERE CountryCode='kor' and Population>1000000 and Population < 5000000
-- ORDER BY Name Desc;

-- SELECT count(*)
-- from city
-- WHERE CountryCode='kor' and Population>1000000 and Population < 5000000;

-- SELECT CountryCode, Population
-- FROM city
-- ORDER BY CountryCode ASC, Population DESC;

-- SELECT Name
-- from city
-- WHERE CountryCode IN ('KOR', 'CHN', 'JPN');

-- SELECT Name, Population
-- FROM city
-- WHERE CountryCode='kor' and Population>1000000
-- ORDER BY LIMIT;



-- SELECT Code
-- FROM country
-- WHERE Name LIKE "%KOREA%" ;

-- 방법 1*******실패
SELECT cl.Language, cl.IsOfficial, cl.Percentage
FROM countrylanguage cl

-- 방법 2
-- SELECT cl.Language, cl.IsOfficial, cl.Percentage
-- FROM countrylanguage cl
-- JOIN country c ON cl.CountryCode = c.Code
-- WHERE c.Name = "South Korea";

-- 방법 3
-- SELECT b.Language, b.IsOfficial, b.Percentage
-- FROM country a, countrylanguage b
-- WHERE a.Name = "SOUTH KOREA" AND a.Code = b.CountryCode;

-- SELECT Name, count(*)
-- FROM city
-- GROUP BY Name
-- HAVING count(*) >= 10;