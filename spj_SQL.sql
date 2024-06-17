USE cjdate;

# 8.6 SQL 프로그래밍
SELECT color, city FROM p;

SELECT DISTINCT color, city FROM p;

SELECT DISTINCT color, city FROM p ORDER BY city;

# 1. 부품의 무게가 10 pound 이상이고 부품의 도시가 파리가 아닌 부품의 도시와 색상을 찾아라.
SELECT px.color, px.city FROM p AS px WHERE px.city <> 'paris' AND px.weight > 10.0;
--  tuple calculus 스타일로서 range 변수로서 px를 사용하는 것이다.
--  implicit range variable로서 다음과 같이 relation 이름을 변수처럼 사용한다.
SELECT p.color, p.city
FROM p
WHERE p.city <> 'Paris' AND p.weight > 10;
-- unqualified column name을 사용하는 것은 같은 attribute를 사용하지 않을 때 가능하다.
SELECT color, city
FROM p
WHERE city <> 'Paris' AND weight > 10;

# 2. 모든 부품에 대하여 부품 번호와 부품의 무게를 그램으로 찾아라.
SELECT p.pno, p.weight * 454 AS gmwt FROM p;

# 3. 공급자의 도시와 부품의 도시가 같은 공급자와 부품 정보를 찾아라.
-- 1) from 절에서 Cartesian product를 수행한다. 이 개념은 tuple calculus에서 따온 것이다.
SELECT s.sno, s.sname, s.status, s.city, P.pno, P.PNAME, P.color, P.WEIGHT
FROM s, p
WHERE s.city = P.city;
-- 2) where 절에서 restriction 하는 것은 relational algebra에서 따온 것이다.
SELECT * FROM s JOIN p ON s.city = p.city;
-- 3) select 절에서 projection 하는 것은 relational algebra에서 따온 것이다.
SELECT * FROM s, p WHERE s.city = p.city;

# 4. first city에 있는 공급자가 second city에 있는 부품을 공급할 때 두 도시 쌍을 찾아라.
SELECT * FROM s JOIN sp JOIN p ON s.sno = sp.sno AND sp.pno = p.pno;
SELECT DISTINCT s.city AS scity, p.city AS pcity FROM s JOIN sp JOIN p ON s.sno = sp.sno AND sp.pno = p.pno;

# 5. 같은 도시에 있는 공급자의 모든 공급자 번호 쌍을 찾아라.
SELECT a.sno AS sa, b.sno AS sb
FROM s AS a, s AS b
WHERE a.city = b.city AND a.sno < b.sno;

SELECT s1.*
FROM s AS s1, s AS s2
WHERE s1.city = s2.city 
	AND s1.sno < s2.sno;

# 6. 공급자 전체 숫자를 찾아라.
SELECT COUNT(*) AS n FROM s;
-- count, sum, avg, max, min, every, any가 aggregate function이다. sum(distinct qty)를 사용하면 중복 qty를 제거하므로 결과가 다르다.
-- group by를 사용한 aggregation 함수 처리.
SELECT pno, SUM(qty) FROM sp GROUP BY pno;
SELECT pno, SUM(DISTINCT qty) FROM sp GROUP BY pno;

# 7. 부품 p2의 최대, 최소 qty 값을 찾아라.
SELECT MAX(sp.qty) AS maxq, MIN(sp.qty) AS minq FROM sp WHERE sp.pno = 'p2';
SELECT pno, MAX(qty) AS max, MIN(qty) AS min FROM sp GROUP BY pno HAVING pno = 'p2';
SELECT AVG(SUM(sp.qty)) FROM sp;	# 오류가 발생한다.

# 8. 공급된 부품에 대하여 부품 번호와 공급된 부품 수량을 찾아라.
SELECT sp.pno, SUM(sp.QTY) AS TOTQTY FROM sp GROUP BY sp.pno;
-- = SUMMARIZE sp BY (pno) ADD SUM(QTY) as TOTQTY
-- SQL의 sum() 함수는 relational algebra의 summarize 연산자를 따왔다.

SELECT P.pno, (SELECT SUM(sp.QTY) FROM sp WHERE sp.pno = P.pno) AS TOTQTY FROM P;
-- P: free variable, sp: bound variable로서 relational calculus에서 따왔다.

# 9. 한 명 이상의 공급자에 공급된 부품의 번호를 찾아라.
SELECT sp.pno
FROM sp
GROUP BY sp.pno
HAVING COUNT(sp.sno) > 1;

SELECT pno, COUNT(*) cnt
FROM sp
GROUP BY pno
HAVING cnt > 1;

# 10. 부품 p2를 공급하는 공급자의 이름을 찾아라.
SELECT DISTINCT S.sname
FROM s
WHERE s.sno IN (SELECT sp.sno FROM sp WHERE sp.pno = 'P2');

SELECT *
FROM s
WHERE sno IN (SELECT sno FROM sp WHERE pno = 'P2');

-- in (subquery)의 결과가 s1, s2, s3, s4이면 다음과 같은 질의로 생각하면 된다.
SELECT DISTINCT s.sname
FROM s
WHERE s.sno IN ('s1', 's2', 's3', 's4');

SELECT DISTINCT sname
FROM s
WHERE sno IN ('s1', 's2', 's3', 's4');
-- subquery를 사용하지 않고 join으로 표현할 수도 있다.
SELECT DISTINCT S.sname
FROM s, sp
WHERE s.sno = sp.sno AND sp.pno = 'P2';

SELECT DISTINCT s.sname
FROM s
WHERE exists 
	(SELECT * 
    FROM sp
    WHERE sp.sno = s.sno AND sp.pno = 'P2');
    
# 11. red 부품을 적어도 한 개 이상 공급하는 공급자의 이름을 찾아라.
SELECT DISTINCT s.sname FROM s
WHERE s.sno IN (SELECT sp.sno FROM sp
		WHERE sp.pno IN (SELECT p.pno FROM p WHERE p.color = 'red'));

SELECT sx.sname FROM s sx WHERE exists (SELECT * FROM sp spx WHERE sx.sno = spx.sno AND
EXISTS (SELECT * FROM p px WHERE px.color = 'red' AND px.pno = spx.pno));

SELECT s.sname
FROM p, sp, s
WHERE color = 'red'
	AND p.pno = sp.pno
    AND sp.sno = s.sno
GROUP BY s.sname;

# 12. s 테이블의 최대 status 값보다 작은 status를 갖는 공급자 이름을 찾아라.
SELECT s.sno FROM s WHERE s.status < (SELECT MAT(s.status) FROM s);

# 13. 부품 p2를 공급하는 공급자 이름을 찾아라.
SELECT DISTINCT s.sname FROM s
WHERE EXISTS (SELECT * FROM sp WHERE sp.sno = s.sno AND sp.pno = 'P2');
-- exists(select from )의 tuple calculus의 exists에 해당한다. sp가 bound variable이다.

# 14. 부품 p2를 공급하지 않는 공급자의 이름을 찾아라.
SELECT DISTINCT s.sname FROM s
WHERE NOT EXISTS (SELECT * FROM sp WHERE sp.sno = s.sno AND sp.pno = 'P2');

SELECT DISTINCT s.sname FROM s
WHERE s.sno NOT IN (SELECT sp.sno FROM sp WHERE sp.pno = 'P2');

# 15. 모든 부품을 공급하는 공급자의 이름을 찾아라.
SELECT DISTINCT s.sname
FROM s
WHERE NOT EXISTS (
	SELECT *
    FROM p
    WHERE NOT EXISTS (
		SELECT *
        FROM sp
        WHERE sp.sno = s.sno AND sp.pno = p.pno));