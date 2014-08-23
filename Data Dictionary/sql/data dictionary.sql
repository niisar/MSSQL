create table #a
(
	table_name varchar(100),
	Field varchar(100),
	COLUMN_NAME varchar(100),
	DATA_TYPE varchar(100),
	Prec varchar(100),
	Cons varchar(100),
	Ref varchar(100),
	Coded_Val varchar(100),
	Def varchar(100),
	Description varchar(100)
)

DECLARE @table varchar(100)
DECLARE tbl_Cursor CURSOR FOR
----------------
select distinct table_name from INFORMATION_SCHEMA.COLUMNS a where TABLE_NAME != 'sysdiagrams' order by TABLE_NAME 
----------------
OPEN tbl_Cursor
FETCH NEXT FROM tbl_Cursor INTO @table
WHILE @@FETCH_STATUS = 0
BEGIN
--PRINT @table 
insert into #a(table_name,Field,COLUMN_NAME,DATA_TYPE,Prec,Cons,Ref,Coded_Val,Def,Description)
values('','','','','','','','','','');
insert into #a(table_name,Field,COLUMN_NAME,DATA_TYPE,Prec,Cons,Ref,Coded_Val,Def,Description)
values('','','','','','','','','','');
insert into #a(table_name,Field,COLUMN_NAME,DATA_TYPE,Prec,Cons,Ref,Coded_Val,Def,Description)
values('','',@table,'','','','','','','');
insert into #a(table_name,Field,COLUMN_NAME,DATA_TYPE,Prec,Cons,Ref,Coded_Val,Def,Description)
values('','Fields','DataBase Fields','Data Type','Prec.','Cons.','Ref.','Coded Val','Def. Val','Description');

		DECLARE @table_name varchar(100),@Field varchar(100),@COLUMN_NAME varchar(100),@DATA_TYPE varchar(100),@Prec varchar(100),@Cons varchar(100),@ref varchar(100)
	DECLARE tbl_Cursor2 CURSOR FOR
	----------------
	select table_name,
		   '' as Field,
		   COLUMN_NAME as 'COLUMN_NAME',
		   DATA_TYPE as 'DATA_TYPE',
		   case when (CHARACTER_MAXIMUM_LENGTH = -1) then 'max' when (CHARACTER_MAXIMUM_LENGTH IS null) then '' when(CHARACTER_MAXIMUM_LENGTH = 2147483647) then '' else convert(varchar(20),CHARACTER_MAXIMUM_LENGTH) end as 'Prec.',
		   case when(ORDINAL_POSITION = 1) then 'PK' when((select count(TABLE_NAME) from INFORMATION_SCHEMA.COLUMNS where ORDINAL_POSITION = 1 and COLUMN_NAME = a.COLUMN_NAME and a.ORDINAL_POSITION <> 1 group by COLUMN_NAME) = 1) then 'FK' else '' end as 'Cons.'
		   ,isnull((select MAX(TABLE_NAME) from INFORMATION_SCHEMA.COLUMNS where ORDINAL_POSITION = 1 and COLUMN_NAME = a.COLUMN_NAME and a.ORDINAL_POSITION <> 1 group by COLUMN_NAME),'') as 'Ref'
	from INFORMATION_SCHEMA.COLUMNS a
	where TABLE_NAME != 'sysdiagrams' and table_name = @table
	order by TABLE_NAME,ORDINAL_POSITION 
	----------------
	OPEN tbl_Cursor2
	FETCH NEXT FROM tbl_Cursor2 INTO @table_name,@Field,@COLUMN_NAME,@DATA_TYPE,@Prec,@Cons,@ref
	WHILE @@FETCH_STATUS = 0
	BEGIN
	--PRINT @table_name +' '+ @COLUMN_NAME
	insert into #a(table_name,Field,COLUMN_NAME,DATA_TYPE,Prec,Cons,ref,Coded_Val,Def,Description)
	values('',@Field,@COLUMN_NAME,@DATA_TYPE,@Prec,@Cons,@ref,'','','');
		
	FETCH NEXT FROM tbl_Cursor2 INTO @table_name,@Field,@COLUMN_NAME,@DATA_TYPE,@Prec,@Cons,@ref
	END
	CLOSE tbl_Cursor2
	DEALLOCATE tbl_Cursor2
FETCH NEXT
FROM tbl_Cursor INTO @table
END
CLOSE tbl_Cursor
DEALLOCATE tbl_Cursor

select Field,COLUMN_NAME,DATA_TYPE,Prec,Cons,ref,Coded_Val,Def,Description from #a
drop table #a