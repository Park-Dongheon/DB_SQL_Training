-- Query 실습
-- • DataBase : world
-- • Table : country countrylanguage
-- • Query
USE world;
-- *****1.'English' 를 사용하고 있는 나라의 수를 출력하세요.*****
-- SELECT COUNT(DISTINCT country.Code) AS EnglishSpeakingCountries
-- FROM country
-- JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
-- WHERE countrylanguage.Language = 'English';

-- *****2.대한민국이 사용하고 있는 언어를 출력하세요*****
-- SELECT Language
-- FROM countrylanguage
-- WHERE CountryCode = 'KOR';


-- *****3.'English' 를 공식언어 (IsOfficial) 로 사용하고 있는 나라의 대륙과 이름을 출력하세요*****
-- SELECT country.Continent, country.Name
-- FROM country
-- JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
-- WHERE countrylanguage.Language = "English" AND countrylanguage.IsOfficial = "T";

-- *****4.'English' 를 사용하는 나라의 수를 대륙별로 출력하세요*****
-- SELECT country.Continent, COUNT(DISTINCT country.Code) AS EnglishSpeakingCountry
-- FROM country
-- JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
-- WHERE countrylanguage.Language = "English"
-- GROUP BY country.Continent

-- world 데이터베이스 실습
-- *****CITY 테이블에 저장된 데이터들의 모든 속성을 출력하세요.*****
-- SELECT * FROM city;
-- *****COUNTRY 테이블, COUNTRYLANGUAGE 테이블에 저장된 데이터들의 모든 속성도 출력하세요.*****
-- SELECT * FROM country; SELECT * FROM countrylanguage;

-- *****도시 테이블에 저장된 데이터 들 중 국가코드가 'KOR'인 데이터의 도시이름과 인구수를 출력하세요.*****
-- SELECT Name, Population
-- FROM city
-- WHERE CountryCode = "KOR";

-- *****국가코드가 'KOR'인 도시를 찾아 인구수를 역순으로 표시 하세요. Hint) order by*****
-- SELECT *
-- FROM city
-- WHERE CountryCode = "KOR"
-- ORDER BY Population DESC;
-- *****city 테이블에서 국가코드와 인구수를 출력하라 정렬은 국가코드 별로 오름차순으로 동일한 코드 국가 안에서는 인구수의 역순으로 표시하라. Hint) order by*****
-- SELECT CountryCode, Population
-- FROM city
-- ORDER BY CountryCode ASC, Population DESC;
-- *****city 테이블에서 국가코드가 'KOR', 'CHN', 'JPN'인 도시를 찾으세요. Hint) in*****
-- SELECT *
-- FROM city
-- WHERE CountryCode IN ("KOR", "CHN", "JPN");

-- *****국가코드가 'KOR'이면서 인구가 100 만 이상인 도시를 찾으세요. Hint) and*****
-- SELECT *
-- FROM city
-- WHERE CountryCode = "KOR" AND Population >= 1000000;
-- *****국가코드가 'KOR'인 도시 중 인구수가 많은 순서로 상위 10 개만 표시하세요. Hint) order by limit*****
-- SELECT *
-- FROM city
-- WHERE CountryCode = "KOR"
-- ORDER BY Population DESC
-- LIMIT 10;
-- *****city 테이블에서 국가코드가 'KOR' 이고 인구가 100 만 이상 500 만 이하인 도시를 찾으세요. Hint) and, between*****
-- SELECT *
-- FROM city
-- WHERE CountryCode = "KOR" AND Population BETWEEN 1000000 AND 5000000;

-- *****국가명 'South Korea' 에서 사용되는 언어를 검색해서 language, isofficial, percentage 를 아래 방법으로 모두 출력하세요*****
-- *****Name = ‘South Korea’*****
-- 방법 1 : select … from countrylanguage cl where exists(…); #EXISTS 서브쿼리 사용
-- SELECT Language, IsOfficial, Percentage
-- FROM countrylanguage cl
-- WHERE EXISTS(
-- 	SELECT 1
--     FROM country c
--     WHERE c.Name = "South Korea" AND c.Code = cl.CountryCode
-- );
-- 방법 2 : select … from countrylanguage cl join … on … ; #JOIN 사용
-- SELECT cl.Language, cl.IsOfficial, cl.Percentage
-- FROM countrylanguage cl
-- JOIN country c ON c.Code = cl.CountryCode
-- WHERE c.Name = "South Korea";
-- 방법 3 : select … from country c, countrylanguage cl where …; #WHERE절에서 JOIN
-- SELECT cl.Language, cl.IsOfficial, cl.Percentage
-- FROM country c, countrylanguage cl
-- WHERE c.Code = cl.CountryCode AND c.Name = "South Korea";

-- *****city 테이블에서 국가코드가 'KOR'인 도시의 수를 표시하세요. Hint) count*****
-- SELECT COUNT(*) AS CityCount
-- FROM city
-- WHERE CountryCode = "KOR";
-- *****city 테이블에서 국가별 도시의 수를 표시하세요. Hint) count, group by*****
-- SELECT CountryCode, COUNT(*) AS CityCount
-- FROM city
-- GROUP BY CountryCode;
-- *****city 테이블에서 국가별 도시의 수를 표시하고 국가명도 같이 표시하세요*****
-- SELECT ct.Name AS Country, COUNT(*) AS CityCount
-- FROM city c
-- JOIN country ct ON c.CountryCode = ct.Code
-- GROUP BY c.CountryCode;
-- *****도시의 수가 10 개 이상인 국가에 대해서 city 테이블에서 국가별 도시의 수를 표시하고 국가명도 같이 표시하세요.*****
-- SELECT ct.Name AS CountryName, COUNT(*) AS CityCount
-- FROM city c
-- JOIN country ct ON c.CountryCode = ct.Code
-- GROUP BY c.CountryCode
-- HAVING COUNT(*) >= 10;

-- *****city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 총합을 구하세요. Hint) sum*****
-- SELECT SUM(Population) AS TotalPopulation
-- FROM city
-- WHERE CountryCode = "KOR";
-- *****city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 중 최소값을 구하세요. 단 결과를 나타내는 테이블의 필드는 최소값 으로 표시하세요. Hint) min*****
-- SELECT MIN(Population) AS MinPopulation
-- FROM city
-- WHERE CountryCode = "KOR";
-- *****city 테이블에서 국가코드가 'KOR'인 도시들의 평균을 구하세요. Hint) avg*****
-- SELECT AVG(Population) AS AvgPopulation
-- FROM city
-- WHERE CountryCode = "KOR";

-- *****city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 중 최대값을 구하세요. 단 결과를 나타내는 테이블의 필드는 최대값 으로 표시하세요. Hint) max*****
-- SELECT MAX(Population) AS MaxPopulation
-- FROM city
-- WHERE CountryCode = "KOR";
-- *****country 테이블 각 레코드의 Name 칼럼의 글자수를 표시하세요. Hint) length()*****
-- SELECT Name, LENGTH(Name) AS NameLength
-- FROM country;
-- *****country 테이블의 나라명 (Name 칼럼 을 앞 세글자만 대문자로 표시하세요. Hint) upper, mid 함수*****
-- SELECT Name, CONCAT( UPPER(MID(Name, 1, 3)), MID(Name,4) ) AS ReviseName
-- FROM country;
-- *****country 테이블의 기대수명 LifeExpectancy 을 소수점 첫째자리에서 반올림해서 표시하세요. Hint) round()*****
-- SELECT Name, ROUND(LifeExpectancy, 1) AS LifeExpectancyRound
-- FROM country;

-- *****국가명 ‘South Korea'에서 사용되는 언어를 검색해서 Language, IsOfficial, Percentage 를 출력하는 프로시저를 작성하세요.*****
-- *****nationLanguage01();*****
-- DELIMITER //

-- CREATE PROCEDURE nationLanguage01()
-- BEGIN
-- 	SELECT c.Name AS Country, cl.Language, cl.IsOfficial, cl.Percentage
--     FROM country c
--     JOIN countrylanguage cl ON cl.CountryCode = c.Code
--     WHERE c.Name LIKE '%South Korea%';
-- END //

-- DELIMITER ;

-- 특정 프로시저의 생성 스크립트 보기
-- SHOW CREATE PROCEDURE nationLanguage01;
-- 기존 프로시저 삭제
-- DROP PROCEDURE IF EXISTS nationLanguage01;

-- *****프로시저 nationLanguage01() 에서 국가명을 입력 파라미터로 호출하도록 수정하세요.....*****
-- *****nationLanguage02(‘South Korea’);*****
-- DELIMITER //

-- CREATE PROCEDURE nationLanguage02(IN countryName VARCHAR(100))
-- BEGIN
-- 	SELECT c.Name AS Country, cl.Language, cl.IsOfficial, cl.Percentage
--     FROM country c
--     JOIN countrylanguage cl ON cl.CountryCode = c.Code
--     WHERE c.Name = countryName;
-- END //

-- DELIMITER ;

-- 프로시저 호출
-- CALL nationLanguage02('South Korea');

-- *****프로시저 nationLanguage02() 에서 출력 파라미터에 가장 높은 percentage 를 되돌려 주도록 수정하세요.*****
-- DELIMITER //

-- CREATE PROCEDURE nationLanguage02(IN countryName VARCHAR(100), OUT maxPercentage DECIMAL(5,2))
-- BEGIN
-- 	SELECT MAX(cl.Percentage) INTO maxPercentage
--     FROM country c
--     JOIN countrylanguage cl ON cl.CountryCode = c.Code
--     WHERE c.Name = countryName;
-- END //

-- DELIMITER ;

-- *****nationLanguage03(‘South Korea’, percent);*****
-- *****프로시저 nationLanguage03() 에서 가장 높은 percentage 를 가져오는 함수를 호출하는 방식으로 수정하세요.*****
-- DELIMITER //

-- CREATE PROCEDURE nationLanguage03(IN countryName VARCHAR(100), OUT maxPercentage DECIMAL(5,2))
-- BEGIN
-- 	CALL nationLanguage02(countryName, maxPercentage);
-- END //

-- DELIMITER ;

-- *****nationLanguage04(‘South Korea’, percent);*****
-- DELIMITER //

-- CREATE FUNCTION getMaxLanguagePercentage(countryName VARCHAR(100)) 
-- RETURNS DECIMAL(5,2)
-- BEGIN
--     DECLARE maxPercentage DECIMAL(5,2);

--     SELECT MAX(cl.Percentage)
--     INTO maxPercentage
--     FROM country c
--     JOIN countrylanguage cl ON cl.CountryCode = c.Code
--     WHERE c.Name = countryName;

--     RETURN maxPercentage;
-- END //

-- CREATE PROCEDURE nationLanguage04(IN countryName VARCHAR(100), OUT maxPercentage DECIMAL(5,2))
-- BEGIN
--     SET maxPercentage = getMaxLanguagePercentage(countryName);
-- END //

-- DELIMITER ;