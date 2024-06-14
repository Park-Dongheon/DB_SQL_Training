CREATE table member (
	id varchar(10) NOT NULL,
    pass varchar(10) NOT NULL,
    name varchar(10) NOT NULL, 
    regidate date NOT NULL DEFAULT (current_date),
    PRIMARY KEY (id)
);

CREATE table board (
	num int not null auto_increment,
    title varchar(200) not null,
    content varchar(2000) not null,
    id varchar(10) not null,
    postdate date NOT NULL DEFAULT (current_date),
    visitcount decimal(6) default 0,
     primary key (num)
);