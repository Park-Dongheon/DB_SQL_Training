USE fifa;

-- Liverpool 의 모든 선수 이름과 해당 팀 이름을 검색합니다.
SELECT p.short_name AS Player, t.team_name AS team
FROM team t, player p
WHERE t.team_name LIKE 'Liverpool%' AND t.team_id = p.club_team_id;

-- Tottenham 감독의 국적의 가진 선수들 중 Premier League 에서 뛰고 있는 선수를 검색합니다.
SELECT	p.long_name, n.nationality_name
FROM team t, coach c, nationality n, player p, league l
WHERE t.team_name LIKE 'Tottenham%' 
	AND l.league_name = 'Premier League'
	AND t.coach_id = c.coach_id 
	AND c.nationality_id = n.nationality_id 
    AND n.nationality_id = p.nationality_id
    AND p.nationality_id = c.nationality_id
    AND p.league_id = l.league_id;

-- 게임에서 선수들을 위치 시킬 수 있는 모든 포지션 목록을 가져옵니다.
SELECT *
FROM position;

-- Premier League 에 속한 팀 목록을 가져옵니다.
SELECT *
FROM league l, player p
WHERE l.league_name = 'Premier League'
	AND p.league_id = 13
	AND p.league_id = l.league_id;

-- 각 리그별 등록 선수을 조사하여 가장 많이 등록된 순서로 목록을 가져옵니다.
SELECT p.league_id, l.league_name, COUNT(*) CNT
FROM player p, league l
WHERE p.league_id = l.league_id
GROUP BY p.league_id
ORDER BY CNT DESC;

-- 대한민국 국적의 선수 중 30세 이상의 선수 목록을 가져옵니다.
SELECT n.nationality_name, p.*
FROM nationality n, player p
WHERE n.nationality_name = 'Korea Republic' 
	AND n.nationality_id = p.nationality_id 
    AND p.age >= 30
ORDER BY p.age DESC;

-- overall 이 가장 높은 선수 10명을 검색합니다. overall 순서로 목록을 만듭니다.
SELECT t.team_name, p.*
FROM player p, team t
WHERE p.club_team_id = t.team_id
ORDER BY p.overall DESC
LIMIT 10;

-- 연봉(wage_eur) 이 가장 높은 선수 10명을 검색합니다. wage_eur 순서로 목을 만듭니다.
SELECT t.team_name, p.*
FROM player p, team t
WHERE p.club_team_id = t.team_id
ORDER BY p.wage_eur DESC
LIMIT 10;

-- Premier League에 소속된 선수 중 연봉(wage_eur) 대비 시장 가치(value_eur) 가 높은 선수 10명을 검색합니다.
SELECT l.league_name, t.team_name, p.long_name, p.value_eur / p.wage_eur VALUE_RATIO, p.*
FROM player p, team t, league l
WHERE p.club_team_id = t.team_id
	AND p.league_id = l.league_id
    AND l.league_id = 13
    AND p.age >= 23
    ORDER BY VALUE_RATIO DESC
    LIMIT 10;