--实体完整性
insert into student values (3001,'赵达','男',20,'SX')
insert into student values (3002,'杨丽','女',21,'JSJ')
insert into student values (3001,'李寅','女',21,'SX')

insert into Course values (1081,'电子商务','',4)

insert into SC values (3001,1081,90)
insert into SC values (3001,1081,79)

--用户自定义完整性约束
alter table student add constraint cs_1 check(Ssex in ('男','女'))
alter table student add constraint cs_2 check(Sage >16)

alter table Course add constraint cs_3 check(Ccredit in (0,1,2,3,4,5))
alter table Course add constraint cs_4 check(Cno != Cpno)


insert into student values (3005,'赵达','男',14,'SX')
insert into student values (3006,'杨丽','南',21,'JSJ') --约束冲突
select * from student
delete from student

insert into Course values (1085,'C++','',9)
insert into Course values (1086,'语文',1086,3)
select * from Course
delete from Course

insert into SC values (3002,1081,128)
select * from SC
delete from SC

--参照完整性约束
-- 1.输入实验前的数据
insert into student values (4001,'赵尹','男',20,'SX')
insert into student values (4002,'杨开','女',20,'JSJ')

insert into Course values (1088,'java','',5)
insert into Course values (1089,'数学','',3)

insert into SC values (4001,1088,90)
insert into SC values (4002,1088,86)

--2.试验过程 
insert into SC values (4001,1066,76)

insert into student values (4003,'赵辉','男',21,'SX')

delete from student where Sno=4001 or Sno = 4002 --与foreign key冲突

update student set Sno = 4018 where Sno = 4003 --4003不在Sc中故可以改动
update student set Sno = 4021 where Sno = 4001 --4001在Sc中受foreign key 约束

update SC set Sno = 4011 where Sno = 4001 --与foreign key冲突
update SC set Sno = 4011 where Sno = 4003 



alter table student drop constraint cs_1
alter table student drop constraint cs_2
alter table student drop constraint cs_3
alter table student drop constraint cs_4


