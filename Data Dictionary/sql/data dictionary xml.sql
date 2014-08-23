DECLARE @table varchar(100)
DECLARE tbl_Cursor CURSOR FOR
----------------
select distinct table_name from INFORMATION_SCHEMA.COLUMNS a where TABLE_NAME != 'sysdiagrams'  order by TABLE_NAME 
----------------
print '<?xml-stylesheet type="text/xsl" href="style/dd.xslt"?>'
print '<tables>'

OPEN tbl_Cursor
FETCH NEXT FROM tbl_Cursor INTO @table
WHILE @@FETCH_STATUS = 0
BEGIN

--PRINT @table 
--print char('1')+char('2');


print '    <table name="'+@table+'">';
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
	--PRINT @table_name +' '+ @
	print '        <row>';
	print '            <Field>'+@Field+'</Field>';
	print '            <ColumnName>'+@COLUMN_NAME+'</ColumnName>';
	print '            <DataType>'+@DATA_TYPE+'</DataType>';
	print '            <Prec>'+@Prec+'</Prec>';
	print '            <Cons>'+@Cons+'</Cons>';
	print '            <Ref>'+@ref+'</Ref>';
	print '            <Coded></Coded>';
	print '            <Def></Def>';
	print '            <Description></Description>';
	print '        </row>';
	print ' ';
	FETCH NEXT FROM tbl_Cursor2 INTO @table_name,@Field,@COLUMN_NAME,@DATA_TYPE,@Prec,@Cons,@ref
	END
	CLOSE tbl_Cursor2
	DEALLOCATE tbl_Cursor2
	print '    </table>';
FETCH NEXT
FROM tbl_Cursor INTO @table
END
CLOSE tbl_Cursor
DEALLOCATE tbl_Cursor
print '</tables>'