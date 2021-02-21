--Check for Stored Procedures--
USE WeVote

If Exists (SELECT * FROM sys.objects WHERE TYPE = 'P' and NAME = 'spDeleteDuplicates')
SELECT OBJECT_DEFINITION (OBJECT_ID(N'spDeleteDuplicates'));

EXEC dbo.spDeleteDuplicates @tablename = 100, @columnname1 = 100, @columnname2 = null, @whereclause = null


USE WeVote;
CREATE TABLE DeleteNullRecords (
tablename nvarchar(100),
columnname nvarchar(100),
columname1 nvarchar(100),
columname2 nvarchar(100),
whereclause nvarchar(100)
);

SELECT * FROM DeleteNullRecords

INSERT INTO DeleteNullRecords
VALUES    ('ABC','CDE','FGH', 'IGK', 'LMN'),
        (NULL,'CDE', 'FGH', 'IGK', 'LMN'),
        ('ABC',NULL, 'FGH', 'IGK', 'LMN'),
        ('ABC',NULL, NULL, 'IGK', 'LMN'),
		('ABC','CDE', 'FGH', NULL, 'LMN');

SELECT * FROM DeleteNullRecords

EXEC spDeleteNullRecords DeleteNullRecords,columnname;

SELECT * FROM DeleteNullRecords



--Delete SQL codes later--


DROP TABLE DeleteNullRecords

USE WeVote
SELECT * FROM Citizenship


SELECT * FROM
SELECT column_names
FROM table_name
WHERE column_name IS NOT NULL;

EXEC spFindDuplicates 'VoteCounts','VoteCounts','FK2_CandidateIDs'

EXEC spDeleteDuplicates 'VoteCounts','FK2_CandidateIDs'

USE WeVote;  
GO  




SELECT * FROM dbo.spDeleteDuplicates

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









EXEC spFindDuplicates;

EXEC spDeleteDuplicates 'VoteCounts','VoteCounts','FK2_CandidateIDs'






EXEC spDeleteDuplicates;
GO  


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