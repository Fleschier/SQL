create database School
sp_helpdb School

drop database School

create database School on(
	name = 'School_data',
	filename = 'c:\data\School_data.mdf',
	size = 5mb,
	filegrowth = 1mb
)