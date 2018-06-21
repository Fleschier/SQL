create database school

create table student(
	Sno char(6) primary key,
	Sname varchar(8) not null constraint ck_1 unique,
	Ssex char(2) not null constraint ck_2 check(Ssex in('ÄÐ','Å®')),
	Sage smallint constraint ck_3 check(sage>16),
	Sdept varchar(15) default 'JSJ'
)

create procedure bulk_makedata as 
	declare @nCnt int, @sno char(6), @sname varchar(8)
	set @ncnt = 12000 --counter
	while @ncnt < 10000
	begin
		set @ncnt = @ncnt + 1  --count ++
		set @sno = convert(varchar(6),@ncnt)
		set @sname = 'wang' + @sno
		insert into student (sno,sname,ssex,sage) values (@sno,@sname,'man',30)
	end 
return 

create index Ix_student_sname on student(sname)  --create index
create index Ix_student_sdept on student(sdept)

drop index student.Ix_student_sname 

exec bulk_makedata

drop procedure bulk_makedata

drop table student 
drop database school