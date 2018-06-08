-- 一
create database school

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

insert into student values('0001','Jame','男',20,'JSJ')
insert into student values('0002','Sam','男',21,'WL')

insert into SC values ('0001','1001',90)
insert into SC values ('0002','1001',85)

-- 1
set transaction isolation level serializable

-- 2
set lock_timeout 5000

-- 3
sp_lock


-- 二

-- 1
begin transaction
	update student set sage = sage + 1
	where sno = '0001'
	select * from student where sno = '0002'

-- 2

-- (1) 
--可以执行，虽然事务还未结束，但是对'0002'的操作只有读，加的是S锁，允许别的读操作

-- (2)
--无法执行，一直在等待。因为事务对'0002'是写操作，加的是X锁，不允许别的读取

--(3)
--可以执行。因为事务上加的是S锁，默认是读取结束后便释放掉S锁。因此可以在事务未提交的时候其他查询再获取X锁。

-- (4)
--结果如下：
--早的活动事务:
--   SPID (服务器进程 ID): 65
--    UID (用户 ID): -1
--    名称          : user_transaction
--    LSN           : (10465:408:2)
--    开始时间    : 06  1 2018  9:58:20:390AM
--    SID           : 0x01050000000000051500000010138cb527ce4c38b902862de9030000
--DBCC 执行完毕。如果 DBCC 输出了错误信息，请与系统管理员联系。

-- (5)
--无法执行。事务未结束，对'0001'加的是X锁，还未释放，所以别的查询不能获取S锁。

commit tran

-- 此时另一个查询可以正常进行。因为事务结束了，释放了X锁，别的查询就可以获取S锁了。

-- 三

-- 1

begin tran 
	select * from student where sno = '0001'
	print 'server process ID (spid): '
	print @@spid

--(1)
exec sp_lock
--server process ID (spid); 65


-- (2)
commit tran
exec sp_lock
--没有锁信息

-- 3
set transaction isolation level serializable

-- commit之前

-- commit之后


-- 4
begin tran
	select * from student (TABLOCKX) where sno = '0002'
	print 'server process ID (spid):'
	print @@spid
--spid:65

exec sp_lock

-- 5

--(1)
set lock_timeout 1000
go 
begin tran
	select * from student (TABLOCKX) where sno = '0002'

--(2)
-- 第二个连接会一直等待，没有执行

--(3)
--结果：
--消息 1222，级别 16，状态 56，第 28 行
--已超过了锁请求超时时段。


-- 五

-- 1
create procedure usp_update1
as
begin tran
	select grade from SC 
	where grade > 80
	update grade set grade = grade + 2

end

exec usp_update1 --执行测试

-- 2
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

