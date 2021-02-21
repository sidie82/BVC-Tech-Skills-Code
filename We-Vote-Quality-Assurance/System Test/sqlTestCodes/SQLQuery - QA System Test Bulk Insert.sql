USE WeVotePhase2;
BEGIN TRAN;
BULK INSERT WeVotePhase2.dbo.CandidateName
FROM 'C:\Users\jponc\OneDrive\Documents\testBulkInsert.csv'
WITH (
FIRSTROW = 2,
--FIELDTERMINATOR='\t',
FIELDTERMINATOR=',',
ERRORFILE = 'C:\Users\jponc\OneDrive\Documents\error.log'); 
SELECT *
FROM CandidateName;
ROLLBACK;
--DELETE CandidateName
--WHERE PK_CandidateIDs=136;
