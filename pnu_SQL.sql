SHOW VARIABLES LIKE 'character_set_server';
SHOW VARIABLES LIKE 'collation_server';

SET GLOBAL collation_server = 'utf8mb4_unicode_ci';

USE pnu;
SELECT C.CNO AS NO, D.주관학과명 AS 개설학과,
	C.분반, C.교과구분, S.SNAME AS 교과목명,
    C.학점, C.제한인원, I.교수명, C.시간표
FROM DEPT D, COURSE C, INSTRUCTOR I, SUBJECT S
WHERE D.주관학과명 = '문헌정보학과'
	AND D.DNO = C.DNO
    AND C.INO = I.INO
    AND C.SNO = S.SNO;
    
CREATE VIEW NEW_COURSE AS
SELECT C.CNO AS NO, D.주관학과명 AS 개설학과,
	C.분반, C.교과구분, S.SNAME AS 교과목명,
    C.학점, C.제한인원, I.교수명, C.시간표
FROM DEPT D, COURSE C, INSTRUCTOR I, SUBJECT S
WHERE 
	AND D.DNO = C.DNO
    AND C.INO = I.INO
    AND C.SNO = S.SNO;