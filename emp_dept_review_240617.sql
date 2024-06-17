CREATE DATABASE review;

USE review;

CREATE TABLE dept (
	dno VARCHAR(4) PRIMARY KEY NOT NULL,
    dname VARCHAR(45) NOT NULL,
    budget BIGINT DEFAULT 0 NOT NULL
);

CREATE TABLE emp (
	eno VARCHAR(4) PRIMARY KEY NOT NULL,
    ename VARCHAR(45) NOT NULL,
    dno VARCHAR(4) NOT NULL,
    salary BIGINT DEFAULT 0 NOT NULL,
    FOREIGN KEY (dno) REFERENCES dept (dno)
);

INSERT INTO dept (dno, dname, budget) VALUES ('D1', 'Marketing', 1000000);
INSERT INTO dept (dno, dname, budget) VALUES ('D2', 'Development', 1200000);
INSERT INTO dept (dno, dname, budget) VALUES ('D3', 'Research', 500000);
SELECT * FROM dept;

INSERT INTO emp (eno, ename, dno, salary) VALUES ('E1', 'Lopez', 'D1', 40000);
INSERT INTO emp (eno, ename, dno, salary) VALUES ('E2', 'Cheng', 'D1', 42000);
INSERT INTO emp (eno, ename, dno, salary) VALUES ('E3', 'Finzi', 'D2', 30000);
INSERT INTO emp (eno, ename, dno, salary) VALUES ('E4', 'Saito', 'D2', 35000);
SELECT * FROM emp;

# 직원 id 가 1 인 직원을 검색해 보세요.
SELECT * FROM emp WHERE eno = 'E1';

# 직원명이 Finzi 인 직원을 검색해 보세요.
SELECt * FROM emp WHERE ename = 'Finzi';

# 급여가 $40,000이상인 직원을 검색해 보세요.
SELECT * FROM emp WHERE salary >= 40000;

# Marketing 부서에 속하는 직원을 검색해 보세요.
SELECT e.*
FROM emp e, dept d
WHERE d.dname = 'Marketing' AND e.dno = d.dno;

# SQL Explain 을 확인해 보세요.(Ctrl + Alt + z)
# 테이블별로 필요한 index 를 생성해 보세요.
CREATE UNIQUE INDEX idx_emp_eno ON emp (eno);
CREATE INDEX idx_emp_ename ON emp (ename);
CREATE INDEX idx_emp_dno ON emp (dno);
CREATE INDEX idx_emp_salary ON emp (salary);

CREATE UNIQUE INDEX idx_dept_dno ON dept (dno);
CREATE INDEX idx_dept_dname ON dept (dname);
CREATE INDEX idx_dept_budget ON dept (budget);

# emp_v view 를 생성해 보세요.
CREATE VIEW emp_v AS SELECT eno, ename, dno, salary FROM emp;
CREATE VIEW dept_v AS SELECT dno, dname, budget FROM dept;
SELECT * FROM emp_v;
SELECT * FROM dept_v;
# 기존에 구현한 SQL 을 emp_v 를 이용하여 재구성 해보세요.

#  GROUP BY
# 부서별로 직원 목록을 부서명으로 오름차순으로 출력하세요.
SELECT d.dname AS dname, GROUP_CONCAT(e.ename) AS Count_emp
FROM emp e, dept d
WHERE e.dno = d.dno
GROUP BY d.dno
ORDER BY d.dname ASC;

# 부서별로 직원 연봉 합계를 내림차순으로 출력하세요.
SELECT e.dno, d.dname, SUM(e.salary) AS total_salary
FROM emp e, dept d
WHERE e.dno = d.dno
GROUP BY e.dno
ORDER BY total_salary DESC;

# INSERT
# 공채를 통해 입사하는 직원을 등록해 보세요.
INSERT INTO emp (eno, ename, dno, salary) VALUES ('E5', 'Park', 'D3', 50000);
# 2025년 조직 개편을 위해 AI 부서를 등록해 보세요.
INSERT INTO dept (dno, dname, budget) VALUES ('D4', 'AI', 2000000);

# UPDATE
# 등록한 직원의 이름에 오류가 있습니다. 수정해 보세요.
UPDATE emp SET ename = 'Kim' WHERE eno = 'E5';
# AI 부서의 예산이 10,000,000,000 책정됐습니다. 수정해 보세요.
UPDATE dept SET budget = 10000000000 WHERE dname = 'AI';

# DELETE
# 개발 부서의 인원을 축소해야 합니다. 연봉이 높은 직원을 LAY OFF 하세요.
# 남아 있는 직원의 소속을 AI 부서로 변경해 주세요.