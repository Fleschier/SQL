create table student(
	Sno char(6) primary key,
	Sname varchar(8),Ssex char(2),
	Sage smallint,Sdept varchar(15)
)
insert into student values('5001','赵强','男','20','SX')
insert into student values('5002','李丽华','女','21','JSJ')
insert into student values('5001','李静','女','20','SX')


create table course (
	Cno char(4) primary key,
	Cname varchar(20),Cpno char(4),
	Ccredit tinyint
)
insert into course values('1801','C语言','','4')
insert into course values('1802','数据结构','1081','4')


create table sc(
	Sno char(6),
	Cno char(4),
	Grade decimal(12,2),
	primary key(Sno,Cno),
	foreign key(Sno) references student(Sno),
	foreign key(Cno) references course(Cno)
)
insert into sc values('5001','1801','90')
insert into sc values('5001','1802','79')
insert into sc values('5002','1801','91')

insert into sc values('5008','1801','99')


select * from student
select * from course
select * from sc

delete from student 
delete from course 
delete from sc

drop table student
drop table course
drop table sc