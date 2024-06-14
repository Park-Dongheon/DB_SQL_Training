CREATE DATABASE hrm;

USE hrm;

CREATE TABLE dept (
	dno CHAR(4) PRIMARY KEY NOT NULL,
    dname VARCHAR(45) NOT NULL,
    budget BIGINT NOT NULL DEFAULT 0
);

CREATE TABLE emp (
	eno CHAR(4) PRIMARY KEY NOT NULL,
    ename VARCHAR(45) NOT NULL,
    dno CHAR(4) NOT NULL,
    salary BIGINT NOT NULL DEFAULT 0,
    FOREIGN KEY (dno) REFERENCES dept(dno)
);

SELECT * FROM hrm.dept;
INSERT INTO dept VALUES ('D1', 'Marketing', 1000000);
INSERT INTO dept VALUES ('D2', 'Development', 1200000);
INSERT INTO dept VALUES ('D3', 'Research', 500000);

SELECT * FROM hrm.emp;
INSERT INTO emp VALUES ('E1', 'Lopez', 'D1', 40000);
INSERT INTO emp VALUES ('E2', 'Cheng', 'D1', 42000);
INSERT INTO emp VALUES ('E3', 'Finzi', 'D2', 30000);
INSERT INTO emp VALUES ('E4', 'Saito', 'D2', 35000);

# 직원 id 가 1 인 직원을 검색해 보세요.
SELECT eno, ename, dno, salary
FROM emp
WHERE eno = 'E1';

# 직원명이 Finzi 인 직원을 검색해 보세요.
SELECT eno, ename, dno, salary
FROM emp
WHERE ename = 'Finzi';

# 급여가 $40,000이상인 직원을 검색해 보세요.
SELECT eno, ename, dno, salary
FROM emp
WHERE salary >= 40000;

# Marketing 부서에 속하는 직원을 검색해 보세요.
SELECT *
FROM dept
WHERE dname = 'Marketing';

# 테이블별로 필요한 index 를 생성해 보세요.
CREATE INDEX idx_eno ON emp(eno);
CREATE INDEX idx_name ON emp(ename);
CREATE INDEX idx_salary ON emp(salary);
CREATE INDEX idx_dno ON dept(dno);
CREATE INDEX idx_dname ON dept(dname);
CREATE INDEX idx_budget ON dept(budget);

# 기존에 구현한 SQL 을 emp_v 를 이용하여 재구성 해보세요.
CREATE VIEW emp_v AS
SELECT e.eno, e.ename, d.dname
FROM emp e, dept d;

SELECT *
FROM emp_v;

# GROUP BY
# 부서별로 직원 목록을 부서명으로 오름차순으로 출력하세요.
# 잘못된 이득이 없음
SELECT dno, dname, 1 cnt
-- , COUNT(*) cnt
FROM dept;
-- GROUP BY dno;

########## GROUP_CONCAT 중요 ###########
SELECT d.dname, SUM(e.salary) Total
FROM emp e, dept d
WHERE e.dno = d.dno
GROUP BY e.dno
ORDER BY Total DESC;


# 부서별로 직원 연봉 합계를 내림차순으로 출력하세요.