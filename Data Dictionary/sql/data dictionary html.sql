DECLARE @table varchar(100)
DECLARE tbl_Cursor CURSOR FOR
----------------
select distinct table_name from INFORMATION_SCHEMA.COLUMNS a where TABLE_NAME != 'sysdiagrams'  order by TABLE_NAME 
----------------
print '<html>'

OPEN tbl_Cursor
FETCH NEXT FROM tbl_Cursor INTO @table
WHILE @@FETCH_STATUS = 0
BEGIN

--PRINT @table 
--print char('1')+char('2');


print '<table class="Nisar">';
print ' <tr>';
print '  <td colspan="8" style="font-weight:bold; font-weight:"20";">'+@table+'</td>';
print ' </tr>';
print ' <tr>';
print '  <td><b>Fields</b></td><td><b>DataBase Fields</b></td><td><b>Data Type<b></td><td><b>Prec.</b></td><td><b>Ref.<b></td><td><b>Coded Val</b></td><td><b>Def. Val</b></td><td><b>Description</b></td>';
print ' </tr>';
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
	print ' <tr>';
	print '  <td>'+case when (@Field = '') then '&nbsp;' else @Field end+'</td><td>'+case when (@COLUMN_NAME = '') then '&nbsp;' else @COLUMN_NAME end+'</td><td>'+case when (@DATA_TYPE = '') then '&nbsp;' else @DATA_TYPE end+'</td><td>'+case when (@Prec = '') then '&nbsp;' else @Prec end+'</td><td>'+case when (@Cons = '') then '&nbsp;' else @Cons end+'</td><td>'+case when (@ref = '') then '&nbsp;' else @ref end+'</td><td>&nbsp;</td><td>&nbsp;</td>';
	print ' </tr>';		
	FETCH NEXT FROM tbl_Cursor2 INTO @table_name,@Field,@COLUMN_NAME,@DATA_TYPE,@Prec,@Cons,@ref
	END
	CLOSE tbl_Cursor2
	DEALLOCATE tbl_Cursor2
	print '</table>';
	print '<br/>';
FETCH NEXT
FROM tbl_Cursor INTO @table
END
CLOSE tbl_Cursor
DEALLOCATE tbl_Cursor
print '</html>'