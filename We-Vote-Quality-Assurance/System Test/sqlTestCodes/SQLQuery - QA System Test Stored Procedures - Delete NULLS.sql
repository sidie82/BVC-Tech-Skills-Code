use WeVotePhase2;
CREATE TABLE TestDeleteNull (
Col1 varchar(5),
Col2 int,
Col3 varchar(10));
DROP TABLE TestDeleteNull;

INSERT INTO TestDeleteNull
VALUES	('ABC',1,'Hello'),
		(NULL,2,'There'),
		('ABC',3,NULL),
		('ABC',NULL,'World');

EXEC spDeleteNullRecords TestDeleteNull,Col1;

SELECT *
FROM TestDeleteNull;