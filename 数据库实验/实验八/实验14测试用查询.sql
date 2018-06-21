--¶þ

-- 2
--(1)
select * from student where sno = '0002'

-- (2)
select * from student where sno = '0001'

--(3)
 update student set sname='aaa' where sno='0002'

 -- (4)
DBCC opentran

-- (5)
select * from student where sno = '0001'


-- 5
--(2)

select * from student

--(3)
set lock_timeout 10000

go 
select * from student