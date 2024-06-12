USE fifa;

SELECT * 
FROM fifa.coach;

SET SQL_SAFE_UPDATES = 0;  # disable safe mode
UPDATE coach
SET dob_date = dob;
SET SQL_SAFE_UPDATES = 1;  # disable safe mode

SET SQL_SAFE_UPDATES = 0;  # disable safe mode
UPDATE coach
SET dob_dt = dob;
SET SQL_SAFE_UPDATES = 1;  # disable safe mode

# DATE, DATETIME의 리터럴 타입 검색 방법
SELECT * 
FROM fifa.coach
WHERE dob_date = '1980-05-30';

SELECT * 
FROM fifa.coach
WHERE dob_dt >= '1980-05-30 00:00:00'
	AND dob_dt < '1980-05-31 00:00:00';
    
# 생일이 1990 년 5월인 선수 목록을 오름차순으로 출력하세요. (빠른 생일순)
SELECT *
FROM player
WHERE dob LIKE '1990-05%'
ORDER BY dob ASC;

# 1990 년도 선수들의 월별 생일을 집계해서 오름차순으로 출력하세요. (월별)
SELECT YEAR(dob) Y, MONTH(dob) AS M, COUNT(*) cnt
FROM player
WHERE dob BETWEEN '1990-01-01' AND '1990-12-31'
GROUP BY Y, M
ORDER BY M;

SELECT '1990', MONTH(dob) AS M, COUNT(*) cnt
FROM player
WHERE dob BETWEEN '1990-01-01' AND '1990-12-31'
GROUP BY M
ORDER BY M;

SELECT RIGHT(LEFT(dob, 7), 2) MONTH, COUNT(*) cnt
FROM player
WHERE dob BETWEEN '1990-01-01' AND '1990-12-31'
GROUP BY MONTH
ORDER BY MONTH;
