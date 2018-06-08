create database School

create table student(
	Sno char(6),
	Sname varchar(8),
	Ssex char(2),
	Sage smallint,
	Sdept varchar(15)
)

create table course(
	Cno char(4),
	Cname varchar(20),
	Cpno char(4),
	Ccredit tinyint
)

create table SC(
	Sno char(4),
	Cno char(6),
	Grade decimal(12,1)
)

sp_help student

alter table student add adress varchar(60)
alter table student add inDate datetime
alter table student alter column adress varchar(50)
alter table student drop column inDate


drop table student
drop table course
drop table SC
drop database School