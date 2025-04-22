--1. Print the names of professors who work in departments that have fewer than 50 PhD students.
SELECT
	PNAME
FROM
	PROF
	JOIN DEPT ON PROF.DNAME = DEPT.DNAME
WHERE
	DEPT.DNAME IN (
		SELECT
			DNAME
		FROM
			DEPT
		WHERE
			NUMPHDS < 50
	);
--SELECT pname 
--FROM prof
--JOIN dept ON prof.dname=dept.dname
--WHERE numphds<50;

--2.Print the names of the students with the lowest GPA.
SELECT
	SNAME
FROM
	STUDENT
WHERE
	GPA = (
		SELECT
			MIN(GPA)
		FROM
			STUDENT
	);
	
--3.For each Computer Sciences class, print the class number, section number, and the average gpa of the students enrolled in the class section.
SELECT
	ENROLL.SECTNO,
	ENROLL.CNO,
	AVG(STUDENT.GPA) AS AVERAGE_GPA
FROM
	ENROLL
	JOIN STUDENT ON ENROLL.SID = STUDENT.SID
WHERE
	ENROLL.DNAME = 'Computer Sciences'
GROUP BY
	ENROLL.SECTNO,
	ENROLL.CNO;

--4.Print the names and section numbers of all sections with more than six students enrolled in them.
SELECT
	DNAME,
	SECTNO
FROM
	ENROLL
GROUP BY
	DNAME,
	SECTNO
HAVING
	COUNT(SID) > 6;

--5.Print the name(s) and sid(s) of the student(s) enrolled in the most sections.
SELECT
	SNAME,
	SID
FROM
	STUDENT
WHERE
	SID IN (
		SELECT
			SID
		FROM
			ENROLL
		GROUP BY
			sid
			order by count(*) DESC
		LIMIT
			1
	);

--6.Print the names of departments that have one or more majors who are under 18 years old.
SELECT
	DEPT.DNAME
FROM
	DEPT
	JOIN MAJOR ON DEPT.DNAME = MAJOR.DNAME
	JOIN STUDENT ON MAJOR.SID = STUDENT.SID
WHERE
	STUDENT.AGE < 18
GROUP BY
	DEPT.DNAME;

--7. Print the names and majors of students who are taking one of the College Geometry courses.
SELECT
	STUDENT.SNAME,
	MAJOR.DNAME
FROM
	STUDENT
	JOIN MAJOR ON STUDENT.SID = MAJOR.SID
	JOIN COURSE ON MAJOR.DNAME = COURSE.DNAME
WHERE
	COURSE.CNAME LIKE '%College Geometry%'
GROUP BY
	STUDENT.SNAME,
	MAJOR.DNAME;
	
--8. For those departments that have no major taking a College Geometry course print the department name and the number of PhD students in the department.
SELECT
	DEPT.DNAME,
	DEPT.NUMPHDS
FROM
	DEPT
	JOIN MAJOR ON DEPT.DNAME = MAJOR.DNAME
	JOIN COURSE ON MAJOR.DNAME = COURSE.DNAME
WHERE
	COURSE.CNAME NOT LIKE '%College Geometry%'
GROUP BY
	DEPT.DNAME,
	DEPT.NUMPHDS;
	
--9. Print the names of students who are taking both a Computer Sciences course and a Mathematics course.
SELECT
	STUDENT.SID,
	STUDENT.SNAME
FROM
	STUDENT
	INNER JOIN MAJOR ON MAJOR.SID = STUDENT.SID
WHERE
	MAJOR.DNAME = 'Computer Sciences'
	AND STUDENT.SID IN (
		SELECT
			STUDENT.SID
		FROM
			STUDENT
			INNER JOIN MAJOR ON MAJOR.SID = STUDENT.SID
		WHERE
			MAJOR.DNAME = 'Mathematics'
	);
	
--10.Print the age difference between the oldest and the youngest Computer Sciences major.
SELECT
	MAX(STUDENT.AGE) - MIN(STUDENT.AGE) AS AGE_DIFF
FROM
	STUDENT
	JOIN MAJOR ON STUDENT.SID = MAJOR.SID
WHERE
	MAJOR.DNAME LIKE '%Computer Sciences%';
	
--11.For each department that has one or more majors with a GPA under 1.0, print the name of the department and the average GPA of its majors.
SELECT
	MAJOR.DNAME,
	AVG(STUDENT.GPA)
FROM
	MAJOR
	JOIN STUDENT ON MAJOR.SID = STUDENT.SID
WHERE
	(STUDENT.GPA) < 1.0
GROUP BY
	MAJOR.DNAME;
    
--12.Print the ids, names and GPAs of the students who are currently taking all the Civil Engineering courses.
SELECT
	STUDENT.SID,
	SNAME,
	GPA
FROM
	STUDENT
	JOIN ENROLL ON STUDENT.SID = ENROLL.SID
	JOIN COURSE ON ENROLL.CNO = COURSE.CNO
WHERE
	COURSE.DNAME = 'Civil Engineering'
GROUP BY
	STUDENT.SID,
	SNAME,
	GPA
HAVING
	COUNT(ENROLL.CNO) = (
		SELECT
			COUNT(*)
		FROM
			COURSE
		WHERE
			COURSE.DNAME = 'Civil Engineering'
	)