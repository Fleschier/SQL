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

insert into student values(4001,'李文庆','男',20,'JSJ')
insert into student values (4002,'小杨','女',22,'SX')
insert into student values (4003,'小明','男',20,'WL')
insert into student values (4004,'杨华','女',19,'JSJ')
insert into student values (4005,'杨明花','女',27,'SX')
insert into student values (4006,'张明','男',30,'JSJ')
insert into student values (4007,'小王','男',25,'JSJ')
insert into course values(1001,'C++',89,4)
insert into course values (1002,'Java',1085,4)
insert into course values (1003,'Scala',1088,2)
insert into course values (1004,'数据库原理',1099,2)
insert into sc values (4001,1001,89)
insert into SC values (4002,1003,79.5)
insert into SC values (4002,1001,89.2)
insert into SC values (4001,1002,77.8)
insert into SC values (4003,1003,86.2)
insert into SC values (4004,1001,81.1)
insert into SC values (4003,1004,91.4)
insert into SC values (4005,1002,56)
insert into SC values (4005,1003,60)
insert into SC values (4006,1001,59)
insert into SC values (4006,1002,58)
insert into SC values (4006,1003,57)
insert into SC values (4002,1004,59)

create view v_sc as 
select student.sno,sname,ssex,cno,grade from student,sc where student.sno = sc.sno

select * from v_sc

create view v_age as
select sno,sname,(2018 - sage) as birth_year from student

select * from v_age

create view V_JSJ as
select sno,sname,ssex,sage from student
where sdept = 'JSJ'

select * from V_JSJ


create view V_avggrade as
select cno,avg(grade) as avggrade from sc group by cno

select * from V_avggrade

update v_jsj set sage = 21 
	where sname = '李文庆'  --更改视图原表也会受到影响

select sname,sage from v_JSJ where sname = '李文庆'
select sname,birth_year from v_age where sname = '李文庆'


create view cont as
select cno,count(student.sno) as total from student,sc where student.sno = sc.sno
group by cno

create view pass_rate as
select (count(sno)*100.0/total) as rate from cont,sc where cont.cno = sc.cno and sc.grade >= 60
group by sc.cno , cont.total

select * from pass_rate
