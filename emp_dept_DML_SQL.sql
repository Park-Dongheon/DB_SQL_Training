SELECT * FROM emp;
SELECT * FROM dept;

DELETE FROM emp WHERE eno = 'E6';
DELETE FROM dept WHERE dname = 'AI';

# INSERT
# 공채를 통해 입사하는 직원을 들록해 보세요.
INSERT INTO emp (eno, ename, dno, salary) VALUES ('E5', 'PARK', 'D3', 70000);
# 2025년 조직 개편을 위해 AI 부서를 등록해보세요.
INSERT INTO dept (dno, dname, budget) VALUES ('D4', 'AI', 1500000);

# UPDATE
# 등록한 직원의 이름에 오류가 있습니다. 수정해 보세요.
UPDATE emp SET ename = 'ParkDongheon' WHERE ename = 'PARK';
# AI부서의 예산이 10,000,000,000 책정됐습니다. 수정해 보세요
UPDATE dept SET budget = 10000000000 WHERE dname = 'AI';

# DELETE
# 개발 부서의 인원을 축소해야 합니다. 연봉이 높은 직원을 LAY OFF 하세요.
DELETE emp FROM emp INNER JOIN (SELECT MAX(salary) AS MAX_salary FROM emp) AS MAX_emp ON salary = MAX_salary;

UPDATE emp
SET deleted = 1
WHERE eno = 'E3';

SELECT *
FROM emp
WHERE dno = 'D2'
ORDER BY salary DESC;

# 남아 있는 직원의 소속을 AI 부서로 변경해 주세요.
UPDATE emp SET dno = 'D4';
