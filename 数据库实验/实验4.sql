--ʵ��������
insert into student values (3001,'�Դ�','��',20,'SX')
insert into student values (3002,'����','Ů',21,'JSJ')
insert into student values (3001,'����','Ů',21,'SX')

insert into Course values (1081,'��������','',4)

insert into SC values (3001,1081,90)
insert into SC values (3001,1081,79)

--�û��Զ���������Լ��
alter table student add constraint cs_1 check(Ssex in ('��','Ů'))
alter table student add constraint cs_2 check(Sage >16)

alter table Course add constraint cs_3 check(Ccredit in (0,1,2,3,4,5))
alter table Course add constraint cs_4 check(Cno != Cpno)


insert into student values (3005,'�Դ�','��',14,'SX')
insert into student values (3006,'����','��',21,'JSJ') --Լ����ͻ
select * from student
delete from student

insert into Course values (1085,'C++','',9)
insert into Course values (1086,'����',1086,3)
select * from Course
delete from Course

insert into SC values (3002,1081,128)
select * from SC
delete from SC

--����������Լ��
-- 1.����ʵ��ǰ������
insert into student values (4001,'����','��',20,'SX')
insert into student values (4002,'�','Ů',20,'JSJ')

insert into Course values (1088,'java','',5)
insert into Course values (1089,'��ѧ','',3)

insert into SC values (4001,1088,90)
insert into SC values (4002,1088,86)

--2.������� 
insert into SC values (4001,1066,76)

insert into student values (4003,'�Ի�','��',21,'SX')

delete from student where Sno=4001 or Sno = 4002 --��foreign key��ͻ

update student set Sno = 4018 where Sno = 4003 --4003����Sc�йʿ��ԸĶ�
update student set Sno = 4021 where Sno = 4001 --4001��Sc����foreign key Լ��

update SC set Sno = 4011 where Sno = 4001 --��foreign key��ͻ
update SC set Sno = 4011 where Sno = 4003 



alter table student drop constraint cs_1
alter table student drop constraint cs_2
alter table student drop constraint cs_3
alter table student drop constraint cs_4


