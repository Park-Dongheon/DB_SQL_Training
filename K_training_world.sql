USE world;
-- 1. 수도와 함께 국가 이름을 검색합니다.
SELECT ct.Name, c.Name
FROM country ct, city c
WHERE ct.Capital = c.ID;

-- 2. 세계에서 인구가 가장 많은 상위 5개 도시의 이름과 인구를 검색합니다. 결과를 인구별로 내림차순으로 정렬합니다.
SELECT Name, Population
FROM city
ORDER BY Population DESC
LIMIT 5;

-- 3. 미국(USA)에 있는 모든 도시의 이름을 검색합니다.
SELECT ct.Name, c.Name
FROM country ct, city c
WHERE ct.Name = 'United States' AND ct.Code = c.CountryCode;

-- 4. 중국에서 사용되는 모든 언어의 이름을 검색합니다.
SELECT c.Code, c.Name, cl.Language
FROM country c, countrylanguage cl
WHERE c.Name = 'China' AND c.Code = cl.CountryCode;

-- 5. 인구가 100만 명 이상인 유럽 국가의 이름을 검색합니다.
SELECT Code, Name
FROM country
WHERE Continent = 'Europe' AND Population >= 1000000;

-- 6. 1900년 이후 독립한 국가의 이름을 검색합니다.
SELECT Code, Name, IndepYear
FROM country
WHERE IndepYear > 1900;

-- 7. 영어가 공용어가 아니고 국민총생산(GNP)이 1,000보다 큰 국가의 이름을 검색합니다.
SELECT c.Name, cl.Language, cl.IsOfficial
FROM CountryLanguage cl, country c
WHERE cl.Language = 'English' AND cl.IsOfficial = 'F' AND cl.CountryCode = c.Code AND c.GNP > 1000;

SELECT c.Name, cl.Language, cl.IsOfficial
FROM country c, countrylanguage cl
WHERE cl.Language NOT IN ('English') AND cl.IsOfficial = 'F' AND cl.CountryCode = c.Code AND c.GNP > 1000;
