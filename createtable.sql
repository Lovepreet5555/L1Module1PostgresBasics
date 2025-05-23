CREATE TABLE STUDENT (
	SID INTEGER PRIMARY KEY,
	SNAME VARCHAR(60),
	SEX VARCHAR(1),
	AGE INTEGER,
	YEARNUM INTEGER,
	GPA NUMERIC(17, 16)
);

CREATE TABLE dept(
dname VARCHAR(40) PRIMARY KEY,
numphds INTEGER
);

CREATE TABLE prof(
pname VARCHAR(60) PRIMARY KEY,
dname VARCHAR(40),
FOREIGN KEY(dname) REFERENCES dept(dname)
);

CREATE TABLE course(
cno INTEGER PRIMARY KEY,
cname TEXT,
dname VARCHAR(40),
FOREIGN KEY(dname) REFERENCES dept(dname)
);

CREATE TABLE major(
dname VARCHAR(40),
sid INTEGER,
PRIMARY KEY(dname,sid),
FOREIGN KEY(dname) REFERENCES dept(dname),
FOREIGN KEY(sid) REFERENCES student(sid)
);

CREATE TABLE section1(

dname VARCHAR(40),
cno INTEGER,
sectno INTEGER PRIMARY KEY,
pname VARCHAR(60),
FOREIGN KEY(dname) REFERENCES dept(dname),
FOREIGN KEY(cno) REFERENCES course(cno)
);

CREATE TABLE enroll(
sid INTEGER,
grade NUMERIC(2,1),
dname VARCHAR(40),
cno INTEGER,
sectno INTEGER,
PRIMARY KEY(sid,dname,cno,sectno),
FOREIGN KEY(sid) REFERENCES student(sid),
FOREIGN KEY(cno) REFERENCES course(cno),
FOREIGN KEY(dname) REFERENCES dept(dname),
FOREIGN KEY(sectno) REFERENCES section1(sectno)
)
