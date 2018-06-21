
-- 1
select sno,Sname,Sage from student where sdept = 'JSJ' and ssex = '男'


-- 2
select student.sno,sname from student,sc,course
where student.sno = sc.sno and sc.cno = course.cno 
and cname = '数据库' and Grade < 60

-- 3
select student.sno,sname from student,sc as s1 where student.sno = s1.sno 
and student.sno = '1402562' and exists (
	select cno from sc as s2
	where s1.cno = s2.cno and s1.sno != s2.sno
)

-- 4
update course set Ccredit = 5 where Cname = '操作系统'

-- 5
select sum(grade) from sc where sno = '1402573'

-- 6
select cno,sum(sno) as total from sc group by Cno

-- 7
select avg(grade) as average_grade from student,sc where student.sno = sc.sno 
and Sdept = 'JSJ' and not exists (
	select grade from sc where grade < 60
)

-- 8
select cno from sc as s1 where not exists 
(
	select sno from sc as s2,student  
	where s1.cno = s2.Cno and s2.Sno = student.Sno
	and Sdept = 'JSJ'
)		-- 所有选修这门课的计算机系的学生
except
(
	select sc.sno from sc,student
	where sc.sno = student.sno
	and Sdept = 'JSJ'  --所有计算机系的学生
)

-- 9
create table SC (
	sno varchar(10),
	cno varchar(6),
	grade smallint
)