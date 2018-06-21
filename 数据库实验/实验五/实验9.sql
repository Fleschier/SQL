create login marry    --创建登陆账户
with password= '1234',
default_database = school

create user marry for login marry -- 为登陆账户创建数据库账户
exec sp_addrolemember 'db_owner', 'marry'  --赋予数据库用户db_owner的权限

--use school
--go create user marry for lgoin marry
--go exec sp_addrolemember 'db_owner','marry' go




drop user marry
drop login marry