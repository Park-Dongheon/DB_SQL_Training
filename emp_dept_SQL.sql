USE ktrain;

CREATE TABLE dept (
    dno CHAR(2) PRIMARY KEY NOT NULL,
    dname VARCHAR(45) NOT NULL,
    budget BIGINT
);

CREATE TABLE emp (
    eno CHAR(2) PRIMARY KEY NOT NULL,
    ename VARCHAR(45) NOT NULL,
    dno CHAR(2) NOT NULL,
    salary BIGINT DEFAULT 0,
    FOREIGN KEY (dno) REFERENCES dept(dno)
);