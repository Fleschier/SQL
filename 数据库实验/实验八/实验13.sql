-- һ
create database school

create table student(
	Sno char(6) primary key,
	Sname varchar(8) not null constraint ck_1 unique,
	Ssex char(2) not null constraint ck_2 check(Ssex in('��','Ů')),
	Sage smallint constraint ck_3 check(sage>16),
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

insert into student values('0001','Jame','��',20,'JSJ')
insert into student values('0002','Sam','��',21,'WL')

insert into SC values ('0001','1001',90)
insert into SC values ('0002','1001',85)

-- 1
Select * from student where sno = '0001'

-- 2
BEGIN transaction
	Update student set sage = sage + 1 
	where sno = '0001'
	select * from student where sno = '0002'
-- ����û�н�������û��commit

-- 3
Select * from student where sno = '0001'
-- ������

-- 4
rollback transaction

select * from student where sno = '0001'
--�����ֻص�ԭ����״̬�ˣ���Ϊ֮ǰ������������񱻻�����


-- ��

-- 1
select * from student where sno = '0001'
--���� 20

-- 2
begin transaction
	update student set sage = sage + 1 
	where sno = '0001'
	select * from student 
	where sno = '0002'

-- 3
commit transaction 
select * from student where sno = '0001'
-- ������ñ�����

-- ��
begin transaction
	update student set sage = sage + 1
	where sno = '0001'
	update sc set grade = grade + 1 
	where sno  = '0002' and cno = '1001'

select * from sc

drop table student
drop table course
drop table SC