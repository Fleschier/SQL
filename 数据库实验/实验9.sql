create login marry    --������½�˻�
with password= '1234',
default_database = school

create user marry for login marry -- Ϊ��½�˻��������ݿ��˻�
exec sp_addrolemember 'db_owner', 'marry'  --�������ݿ��û�db_owner��Ȩ��

--use school
--go create user marry for lgoin marry
--go exec sp_addrolemember 'db_owner','marry' go


grant select,insert,delete,update to marry
go

drop user marry
drop login marry