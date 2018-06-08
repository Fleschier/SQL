create database School
--创建表
create table student(
	Sno char(6) primary key,
	Sname varchar(8) not null constraint ck_1 unique,
	Ssex char(2) not null constraint ck_2 check(Ssex in('男','女')),
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

--创建索引
create index Ix_student_sname on student(Sname)
create index Ix_student_sdept on student(Sdept)
create index Ix_sc_cno on SC(Cno)
create index Ix_course_cname on Course(Cname)

sp_help student  --查看索引等信息
drop index student.ix_student_sname    --删除索引

--生成大量数据
create procedure usp_makedata as 
declare @nCnt int, @sNo char(6), @sname varchar(8)
set @nCnt = 12000 --counter
while @nCnt <999999
begin 
	set @nCnt = @nCnt +1
	set @sNo = convert(varchar(6),@nCnt)
	set @sName = '张' +@sno
	insert into student (sno,sname,ssex,sage) values (@sno,@sname,'男',20)
end
return

exec usp_makedata	--执行生成过程

--生成测试
create procedure usp_test as
declare @nCount int ,@data int
set @nCount=0
while @nCount <100
begin
	select @data = count(*) from student where sname <'张3800' or sname >'张8800'
	set @nCount =@nCount + 1
end

exec usp_test --执行测试

select * from student

drop procedure usp_makedata
drop procedure usp_test