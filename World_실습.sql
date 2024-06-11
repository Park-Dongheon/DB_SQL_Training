USE world;

-- 1. 수도 이름과 함께 국가 이름을 검색합니다. (WHERE C.CAPITAL = CI.ID)
SELECT c.Name COUNTRY_NAME, c2.Name CITY_NAME
FROM Country c, City c2
WHERE c.Capital = c2.Id;

-- 2. 세계에서 인구가 가장 많은 상위 5개 도시의 이름과 인구를 검색합니다. 결과를 인구별로 내림차순으로 정렬합니다. (ORDER BY POPULATION DESC)
SELECT Name, Population
FROM City
ORDER BY Population DESC
LIMIT 5;

-- 3. 미국(United States)에 있는 모든 도시의 이름을 검색합니다.
SELECT c.Name AS COUNTRY_NAME, c2.Name 
FROM Country c, City c2
WHERE c.Name IN ('United States') AND c.Code = c2.CountryCode
ORDER BY c2.Name;

-- 4. 중국(China)에서 사용되는 모든 언어의 이름을 검색합니다.
SELECT cl.Language
FROM Country c, Countrylanguage cl
WHERE c.Name = 'China' AND c.Code = cl.CountryCode;

-- 5. 인구가 100만 명 이상인 유럽 국가의 이름을 검색합니다.
SELECT Name, Population
FROM Country
WHERE Continent = 'Europe' AND Population >= 1000000
ORDER BY Population DESC;

-- 6. 1900년 이후 독립한 국가의 이름을 검색합니다.
SELECT Name, IndepYear
FROM Country
WHERE IndepYear > 1900
ORDER BY IndepYear DESC;

-- 7. 영어가 공용어가 아니고 국민총생산(GNP)이 1,000보다 큰 국가의 이름을 검색합니다.
SELECT c.Name, c.GNP, cl.Language, cl.IsOfficial
FROM Country c, CountryLanguage cl
WHERE cl.Language = 'English' AND cl.IsOfficial = 'F' AND c.GNP > 1000 AND c.Code = cl.CountryCode
ORDER BY GNP DESC;