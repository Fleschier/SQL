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
set transaction isolation level serializable

-- 2
set lock_timeout 5000

-- 3
sp_lock


-- ��

-- 1
begin transaction
	update student set sage = sage + 1
	where sno = '0001'
	select * from student where sno = '0002'

-- 2

-- (1) 
--����ִ�У���Ȼ����δ���������Ƕ�'0002'�Ĳ���ֻ�ж����ӵ���S���������Ķ�����

-- (2)
--�޷�ִ�У�һֱ�ڵȴ�����Ϊ�����'0002'��д�������ӵ���X�����������Ķ�ȡ

--(3)
--����ִ�С���Ϊ�����ϼӵ���S����Ĭ���Ƕ�ȡ��������ͷŵ�S������˿���������δ�ύ��ʱ��������ѯ�ٻ�ȡX����

-- (4)
--������£�
--��Ļ����:
--   SPID (���������� ID): 65
--    UID (�û� ID): -1
--    ����          : user_transaction
--    LSN           : (10465:408:2)
--    ��ʼʱ��    : 06  1 2018  9:58:20:390AM
--    SID           : 0x01050000000000051500000010138cb527ce4c38b902862de9030000
--DBCC ִ����ϡ���� DBCC ����˴�����Ϣ������ϵͳ����Ա��ϵ��

-- (5)
--�޷�ִ�С�����δ��������'0001'�ӵ���X������δ�ͷţ����Ա�Ĳ�ѯ���ܻ�ȡS����

commit tran

-- ��ʱ��һ����ѯ�����������С���Ϊ��������ˣ��ͷ���X������Ĳ�ѯ�Ϳ��Ի�ȡS���ˡ�

-- ��

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
--û������Ϣ

-- 3
set transaction isolation level serializable

-- commit֮ǰ

-- commit֮��


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
-- �ڶ������ӻ�һֱ�ȴ���û��ִ��

--(3)
--�����
--��Ϣ 1222������ 16��״̬ 56���� 28 ��
--�ѳ�����������ʱʱ�Ρ�


-- ��

-- 1
create procedure usp_update1
as
begin tran
	select grade from SC 
	where grade > 80
	update grade set grade = grade + 2

end

exec usp_update1 --ִ�в���

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

