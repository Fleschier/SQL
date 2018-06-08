create database School

create table student(
	Sno char(6) primary key,
	Sname varchar(8) not null constraint ck_1 unique,
	Ssex char(2) not null constraint ck_2 check(Ssex in('ÄÐ','Å®')),
	Sage smallint constraint ck_3 check(sage>16),
	Sdept varchar(15) default 'JSJ'
)

create table course(
	Cno char(6) primary key,
	Cname varchar(20),
	Cpno char(4),
	Ccredit tinyint
)
alter table course add constraint ck_4 check(Ccredit in (0,1,2,3,4,5))
alter table course add constraint ck_5 check (Cno != Cpno)

create table SC(
	Sno char(6) not null,
	Cno char(6) not null,
	Grade decimal(12,1) constraint ck_6 check(Grade <= 100 and Grade >=0)
	constraint fk_1 foreign key (Sno) references student(sno)
)
alter table SC add constraint PK_SC primary key(Sno,Cno)
alter table SC add constraint fk_2 foreign key (Cno) references course(Cno)
alter table SC add constraint ck_6 check(Grade <= 100 and Grade >=0)

sp_help student
sp_help course
sp_help SC

alter table SC drop constraint PK_SC
alter table SC drop constraint fk_2

alter table SC add constraint PK_SC primary key(Sno,Cno)
alter table SC add constraint fk_2 foreign key (Cno) references course(Cno)

alter table SC add constraint ck_6 check(Grade <= 100 and Grade >=0)

alter table student drop constraint ck_1
alter table student drop constraint ck_2
alter table student drop constraint ck_3
alter table Course drop constraint ck_4
alter table Course drop constraint ck_5
alter table SC drop constraint ck_6

select * from student
select * from course
select * from SC

drop table student
drop table course
drop table SC
drop database School