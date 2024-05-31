USE warehouse;

-- SELECT dno
-- FROM dept
-- WHERE dname = 'Marketing';

-- SELECT e.eno, e.ename, e.dno, e.salary
-- FROM emp e
-- WHERE e.dno = 'D1'; 			-- 외래키 설정 되었있는 dno 속성을 이용하여 dept 테이블의 데이터를 가져옴 

-- SELECT e.eno, e.ename, e.dno, e.salary
-- FROM emp e, dept d
-- WHERE e.dno = d.dno AND d.dname = 'Marketing';

-- SELECT e.eno, e.ename, d.dname, e.salary
-- FROM emp e, dept d
-- WHERE e.dno = d.dno AND d.dname = 'Marketing';

-- SELECT e.eno, e.ename, d.dname, e.salary
-- FROM emp e, dept d
-- WHERE e.dno = d.dno AND e.salary >= 40000;

SELECT e.eno, e.ename, d.dname, e.salary, d.budget
FROM emp e, dept d
WHERE e.dno = d.dno AND d.budget >= 100000;