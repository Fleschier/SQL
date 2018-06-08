create database school

create table student(
	Sno char(6) primary key,
	Sname varchar(8) not null constraint ck_1 unique,
	Ssex char(2) not null constraint ck_2 check(Ssex in('男','女')),
	Sage smallint constraint ck_3 check(sage>16),
	Sdept varchar(15) default 'JSJ'
)

create trigger usp_addstudent
on student
for insert
as
	declare @age smallint
	select @age = student.sage from student INNER JOIN inserted on student.sno = inserted.sno
	if @age > 30
	begin 
		raiserror('the age should be under 30',16,10)
		rollback tran
	end


drop trigger usp_addstudent

-- 二

-- 1
create trigger usp_deletestu
on student
for delete
as
	declare @ncnt int  --存储被删除大于25的人数
	select @ncnt = count(*) from deleted	
		where sage > 25
	if @ncnt > 0
	begin
	raiserror ('can not delete those who are older than 25!',16,10)
	rollback transaction
	end

-- 2
create trigger usp_delcourse 
on course
for delete
as
	declare @ncnt int
	select @ncnt = count(*) from  deleted where cno in ('1001','1002','1003')
	if @ncnt> 0
	begin
	raiserror('cannot delete!',16,10)
	rollback transaction
	end
return

-- 3
create trigger usp_asc_update_student
on student
for update
as
	if not update(sage)
		return
	declare @ncnt int
	select @ncnt = count(*) from inserted,deleted
		where deleted.sno = inserted.sno and inserted.sage < deleted.sage
	if @ncnt > 0
	begin 
	raiserror('the age is younger than before!',16,10)
	rollback transaction
	end

-- 4
create trigger usp_choose_sc
on SC
for insert 
as
	declare @ncnt int
	select @ncnt = count(*) from inserted,student
	where student.sno = inserted.sno and sdept = 'JSJ' and inserted.cno = '1004'
	if　@cnt >0
		begin
		raiserror ('JSJ is unable to choose!',16,10)
		rollback transaction
		end

-- 5
create trigger usp_delete
on course
for delete
as 
	declare @ncnt int
	select @ncnt = count(*) from deleted 
		group by deleted.cno
		having count(cno) >= 3
	if @ncnt > 0
	begin
	raiserror ('cannot delete those have more than three course!',16,10)
	rollback transaction
	end

