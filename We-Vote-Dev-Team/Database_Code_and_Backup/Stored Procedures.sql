USE WeVote


--Stored Procedures to remove NULL records --

CREATE PROCEDURE spDeleteNullRecords
	@tablename NVARCHAR(45),
	@columnname NVARCHAR(35)
		AS
		BEGIN
			DECLARE @sql NVARCHAR(100)
		SET @sql =
		'DELETE FROM '+@tablename+
		' WHERE '+@columnname+
		' IS NULL'
	EXEC sp_executesql @sql
END;

--Stored Procedures to find duplicate records with one column as input--

CREATE PROCEDURE spFindDuplicates_SelectOneColumn
	@tablename   NVARCHAR(45),
	@columnname  NVARCHAR(35),
	@whereclause NVARCHAR(35)='0=0'
		AS
		BEGIN
			DECLARE @sql NVARCHAR(MAX)
		SET @sql=
		'WITH cte AS ( 
			SELECT ' +@columnname+',
			COUNT(*) occurences
			FROM '+@tablename+'
			WHERE '+@whereclause+'
		GROUP BY '+@columnname+'
		HAVING
			COUNT(*)>1)
			SELECT '+@tablename+'.'+@columnname+'
			FROM '+@tablename+'
				INNER JOIN cte 
					ON cte.'+@columnname+'='+@tablename+'.'+@columnname+'
			ORDER BY '+@tablename+'.'+@columnname

EXEC sp_executesql @sql
END;

--Stored Procedures to find duplicate records with two columns as input--

CREATE PROCEDURE spFindDuplicates_SelectTwoColumns 
	@tablename   NVARCHAR(45),
	@columnname1  NVARCHAR(35),
	@columnname2  NVARCHAR(35),
	@whereclause NVARCHAR(35) = '0 = 0'
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
--Store Procedure to delete duplicates with one column as input--

CREATE PROCEDURE spDeleteDuplicates_SelectOneColumn
		@tablename   NVARCHAR(45),
		@columnname  NVARCHAR(35),
		@whereclause NVARCHAR(35)='0=0'
			AS
			BEGIN
				DECLARE @sql NVARCHAR(MAX)
			SET @sql=
			'WITH cte AS ( 
				SELECT '+@columnname+',
			 ROW_NUMBER() OVER (
				PARTITION BY
				'+@columnname+'
				ORDER BY
				'+@columnname+'
				) row_num
			FROM '+@tablename+'
			WHERE '+@whereclause+'
			)
			DELETE FROM cte
			WHERE row_num > 1'
EXEC (@sql)
END;

--Store Procedure to delete duplicates with two columns as input--

CREATE PROCEDURE spDeleteDuplicates_SelectTwoColumns
		@tablename   NVARCHAR(45),
		@columnname1  NVARCHAR(35),
		@columnname2  NVARCHAR(35),
		@whereclause NVARCHAR(35) = '0 = 0'
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
			WHERE '+@whereclause+'
			)
			DELETE FROM cte
			WHERE row_num > 1'
EXEC (@sql)
END;

/* Execute stored procedure, using table name, column name and "where" clause (optional) as an input
EXEC spDeleteNullRecords 'Select TableName', 'Select ColumnName'
EXEC spFindDuplicates_SelectOneColumn 'Select TableName', 'Select ColumnName'
EXEC spDeleteDuplicates_SelectOneColumn 'Select TableName', 'Select ColumnName'
EXEC spFindDuplicates_SelectTwoColumns 'Select TableName', 'Select ColumnName1', 'Select ColumnName2'
EXEC spDeleteDuplicates_SelectTwoColumns 'Select TableName', 'Select ColumnName1', 'Select ColumnName2'
*/
