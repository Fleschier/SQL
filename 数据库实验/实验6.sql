create database School
--������
create table student(
	Sno char(6) primary key,
	Sname varchar(8) not null constraint ck_1 unique,
	Ssex char(2) not null constraint ck_2 check(Ssex in('��','Ů')),
	Sage smallint constraint ck_3 check(sage>16),
	Sdept varchar(15)
)

insert into student values (4001,'����','��',20,'SX')
insert into student values (4002,'�','Ů',21,'')

--�����±�
create table sc_name(
	Sno char(6) primary key,
	Sname varchar(8) not null,
	Ssex char(2) not null,
	Cno char(6),
	Grade int
)

--������������
insert into sc_name (Sno,Sname,Ssex)
select Sno,Sname,Ssex from student where Sdept = 'SX'

--update
update student set Sdept ='JSJ' where Sno = 4001


select * from sc_name
select * from student