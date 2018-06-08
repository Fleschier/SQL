create database school

create table student(
	Sno char(6) primary key,
	Sname varchar(8) not null constraint ck_1 unique,
	Ssex char(2) not null constraint ck_2 check(Ssex in('男','女')),
	Sage smallint,
	Sdept varchar(15) default 'JSJ'
)
create table course(
	Cno char(6) primary key,
	Cname varchar(20),
	Cpno char(4),
	Ccredit tinyint
)
create table SC(
	Sno char(6) not null,
	Cno char(6) not null,
	Grade decimal(12,1) constraint ck_6 check(Grade <= 100 and Grade >=0)
	constraint fk_1 foreign key (Sno) references student(sno)
)
alter table SC add constraint PK_SC primary key(Sno,Cno)


insert into student values (4001,'小赵','男',17,'JSJ')
insert into student values (4002,'小杨','女',22,'SX')
insert into student values (4003,'小明','男',20,'WL')
insert into student values (4004,'杨华','女',19,'JSJ')
insert into student values (4005,'杨明花','女',27,'SX')
insert into student values (4006,'张明','男',30,'JSJ')
insert into student values (4007,'小王','男',25,'JSJ')

insert into course values (1001,'C++',1086,4)
insert into course values (1002,'Java',1085,4)
insert into course values (1003,'Scala',1088,2)
insert into course values (1004,'数据库原理',1099,2)

insert into SC values (4001,1001,89.2)
insert into SC values (4002,1003,79.5)
insert into SC values (4002,1001,89.2)
insert into SC values (4001,1002,77.8)
insert into SC values (4003,1003,86.2)
insert into SC values (4004,1001,81.1)
insert into SC values (4003,1002,91.4)
insert into SC values (4003,1001,null)
insert into SC values (4005,1002,56)
insert into SC values (4005,1003,60)
insert into SC values (4006,1001,59)
insert into SC values (4006,1002,58)
insert into SC values (4006,1003,57)
insert into SC values (4002,1004,59)
insert into SC values (4003,1004,90)
insert into SC values (4007,1003,87)
insert into SC values (4007,1001,92)
 
--单表

select Sno,Sname,Sage from student where Sage >= 19 and Sage <= 21 and Ssex = '女' order by Sage desc
-- desc表示降序，asc表示升序

select Sno,Ssex from student where Sname like '_明%'
-- _表示一个字符，%表示任意多个字符

select Sno,Cno from SC where Grade is null 
-- = null查询结果为空

select Sno,Sname,Ssex from student where (Sdept = 'JSJ' or Sdept = 'SX' or Sdept = 'WL') and Sage > 25 order by Sdept,Sno desc
-- 强调优先级用括号括起来

select Sno,Cno,cast((Grade/10) as int)from SC
-- cast(a as int)转换数据类型

select distinct Sdept from student
-- distinct写在最前面

select Grade from SC where Sno = 4001 and (Cno = 1001 or Cno = 1002)

--统计

select count(*) as number from student where Sname like '%明%'

select avg(Sage) as average_age,max(Sage) as max_age from student where Sdept = 'JSJ'

select count(*)as number from student where Sname ='张明' or Sname = '赵英'

select Cno,sum(Grade) as total_grade,avg(Grade) as avg_grade,max(Grade) as max_grade,min(Grade) as min_grade from SC  group by Cno order by avg_grade desc
-- sum()求和

select Sno,avg(Grade) as avg_grade from SC group by Sno having avg(Grade) >= 80
-- 用having 做筛选

select Sno from SC group by Sno having count(Cno) >= 2 

select Cno from SC where Grade >= 85 group by Cno having count(Sno)>10
-- 先筛选出>85分的学生，再进行group和筛选

select Sno from SC group by Sno having avg(Grade) <60

select Sno from SC where Grade <60  group by Sno having count(Cno) > 2
 
-- 连接

select distinct Cno from student,SC where student.Sno = SC.Sno and Sdept = 'JSJ'
-- 连接要写出连接条件

select Sname from student,SC where student.Sno = SC.Sno and Cno = 1002
select Sname from student join SC on student.Sno = Sc.Sno where Cno = 1002 -- JOIN..ON..语句
--嵌套执行
select Sname from student where Sno in(
	select Sno from SC where Cno = 1002
)

select student.Sno, Grade from student,course,SC where student.Sno = SC.Sno and course.Cno = SC.Cno and Cname = '数据库原理' and Grade <60
--用表名.列名来获取具有相同列名的几个表中某个表的某一列

select student.Sname from student,SC where student.Sno = SC.Sno and Grade >= 80 and Cno = 1004
select Sname from student where Sno in( --嵌套写法
	select Sno from SC where Grade > 80 and Cno in(
		select Cno from course where Cname = '数据库原理'
	)
)

select student.Sno,student.Sname,avg(Grade) avg_grade from student,SC where student.Sno = SC.Sno group by student.Sno,student.Sname having avg(Grade) < 60

select Sname from student join SC on student.Sno = SC.Sno where Ssex = '女' group by Sname having avg(Grade) > 75

select student.Sno,Sname,Cno,Grade from student join SC on student.Sno = SC.Sno where Ssex = '男' 

-- 嵌套

select count(Sno) as total from student where Sno in(
	select Sno from SC group by Sno having avg(Grade) < 60
)


select Sname from student where Sno not in (
	select Sno from SC where Cno = 1002
)

select  top 1 Sno,avg(Grade) as avg_grade from SC group by Sno order by avg(Grade) desc
select Sno,avg(Grade) as avg_grade from SC group by Sno having avg(Grade) >= all(select avg(Grade) from SC group by Sno)


select Sname from student where Sno not in (
	select Sno from SC where Cno = 1002 or Cno = 1001
)


select top 1 student.Sno from student join SC on student.Sno = SC.Sno order by Grade desc
select student.Sno from student join SC on student.Sno = Sc.Sno where Grade >= all(Select Grade from SC where Cno = 1002)


select top 3 Sno from SC group by Sno order by avg(Grade) desc


select * from student where Sno not in (
	select Sno from student where Sage <= 19
)


select Sno,Sname from student where Sno in(
	select Sno from SC where Cno = 1001 and Grade > 90 group by Sno having avg(Grade) > 85
)


create table average_t(cno char(6),average decimal(12,1))
insert into average_t select cno,avg(grade) as average from sc  group by cno
select distinct sno from sc join average_t on sc.cno = average_t.cno 
where grade > all(select average_t.average from average_t)


create table avg_age(sdept char(6),avgage decimal(12,1))
insert into avg_age select sdept,avg(sage) from student group by sdept
select sname from student join avg_age on student.sdept = avg_age.sdept
where sage > all(select avgage from avg_age)


drop table student
drop table course
drop table sc
drop database school