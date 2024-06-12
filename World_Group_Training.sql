USE world;

-- 두 개 이상의 언어를 사용하는 국가를 출력하세요.
SELECT CountryCode, GROUP_CONCAT(Language) AS LanguageType
FROM countrylanguage
GROUP BY CountryCode;

SELECT CountryCode, COUNT(*) cnt
FROM countrylanguage
GROUP BY CountryCode
HAVING cnt >= 5
ORDER BY cnt DESC;

-- 국가별 도시들의 인구수 합계를 내림차순으로 출력하세요.
SELECT c.CountryCode, co.Name, SUM(c.Population) AS PopulationSum, co.Population
FROM city c, country co
WHERE c.CountryCode = co.Code
GROUP BY c.CountryCode
ORDER BY PopulationSum DESC;

SELECT Code, COUNT(*) cnt
FROM country
GROUP BY Code;
-- HAVING cnt > 1;

-- 국가별 인구수 대비 도시 인구의 비율을 계산하여 내림차순으로 출력하세요.
SELECT c.CountryCode, co.Name, SUM(c.Population) / co.Population AS PopulationRatio
FROM city c, country co
WHERE c.CountryCode = co.Code
GROUP BY c.CountryCode
ORDER BY PopulationRatio DESC;
