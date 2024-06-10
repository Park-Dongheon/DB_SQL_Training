USE fifa;

SELECT COUNT(*) FROM player;				# 53110
SELECT COUNT(*) FROM team;					# 1145
SELECT COUNT(*) FROM league;				# 56
SELECT COUNT(*) FROM coach;					# 1369
SELECT COUNT(*) FROM position;				# 15
SELECT COUNT(*) FROM nationality;			# 189
SELECT COUNT(*) FROM player_position;		# 84986

SELECT *
FROM player
WHERE long_name LIKE '%손흥민%';

SELECT player_id, COUNT(*) AS cnt
FROM fifa.player_position
GROUP BY player_id
ORDER BY cnt DESC;