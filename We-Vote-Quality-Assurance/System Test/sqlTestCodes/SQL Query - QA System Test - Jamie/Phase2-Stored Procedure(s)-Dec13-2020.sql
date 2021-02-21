-- Stored Procedures to remove NULL records --

CREATE PROCEDURE spDeleteNullRecords
	@tablename NVARCHAR(100),
	@columnname NVARCHAR(100)
		AS
		BEGIN
			DECLARE @sql NVARCHAR(100)
		SET @sql=
		'DELETE FROM '+@tablename+
		' WHERE '+@columnname+
		' IS NULL'
	EXEC sp_executesql @sql
END;

-- Stored Procedures to find duplicate records --

CREATE PROCEDURE spFindDuplicates
	@tablename   NVARCHAR(100),
	@columnname1  NVARCHAR(100),
	@columnname2  NVARCHAR(100)='0=0',
	@whereclause NVARCHAR(100)='0=0'
		AS
		BEGIN
			DECLARE @sql NVARCHAR(MAX)
		SET @sql=
		'WITH cte AS ( 
			SELECT ' +@columnname1+',
					'+@columnname2+',
			COUNT(*) occurences
			FROM '+@tablename+'
			WHERE '+@whereclause+'
		GROUP BY '+@columnname1+',
				'+ @columnname2+'
		HAVING
			COUNT(*)>1)
			SELECT '+@tablename+'.'+@columnname1+',
					'+@tablename+'.'+@columnname2+'
			FROM '+@tablename+'
				INNER JOIN cte 
					ON cte.'+@columnname1+'='+@tablename+'.'+@columnname1+' AND
						cte.'+@columnname2+'='+@tablename+'.'+@columnname2+'
			ORDER BY '+@tablename+'.'+@columnname1+',
					'+@tablename+'.'+@columnname2
						
 
EXEC sp_executesql @sql
END;

--Store Procedure to delete duplicates--
CREATE PROCEDURE spDeleteDuplicates
		@tablename   NVARCHAR(100),
		@columnname1  NVARCHAR(100),
		@columnname2  NVARCHAR(100)='0=0',
		@whereclause NVARCHAR(100)='0=0'
AS
BEGIN
  DECLARE @sql NVARCHAR(MAX)
  SET @sql=
  'WITH cte AS ( 
		SELECT '+@columnname1+',
			   '+@columnname2+',
		ROW_NUMBER() OVER (
			PARTITION BY
				'+@columnname1+',
				'+@columnname2+'
			ORDER BY
				'+@columnname1+',
				'+@columnname2+'
		) row_num
		FROM '+@tablename+'
	)
	DELETE FROM cte
	WHERE row_num > 1'
EXEC (@sql)
END

/* Execute stored procedure and put input
EXEC spDeleteNullRecords 'Select TableName', 'Select ColumnName'
EXEC spFindDuplicates 'Select TableName', 'Select ColumnName'
EXEC spDeleteDuplicates 'Select TableName', 'Select ColumnName'
*/