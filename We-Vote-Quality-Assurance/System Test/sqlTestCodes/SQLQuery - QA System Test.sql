USE WeVotePhase2;
--check for Identity Column
SELECT TABLE_NAME+'.'+COLUMN_NAME AS identityColumns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='dbo'
AND COLUMNPROPERTY(OBJECT_ID(TABLE_NAME),COLUMN_NAME,'IsIdentity')=1
ORDER BY TABLE_NAME;
--master table update
SELECT	CandidateIDs, 
		VotingStationIDs, 
		VoteCounts, 
		CONCAT(VotinStationIDs,(RIGHT(CONCAT(REPLICATE('0',2),CandidateIDs),3))) AS VotingStationCandidateIDs
INTO TestVoteCounts 
FROM VotingCandidateDataMaster;
SELECT *
FROM TestVoteCounts
WHERE VotingStationIDs=130;
DROP TABLE TestVoteCounts;
DROP TABLE TestCandidateType;
DROP TABLE TestWardChange;
SELECT CONCAT(VotingStationTypeIDs,(RIGHT(CONCAT(REPLICATE('0',2),CandidateIDs),3))), CandidateIDs
FROM VotingCandidateDataMaster;

--testCase for WardChange
--validate distinct values from csv file
SELECT *
FROM WardChange;
SELECT DISTINCT *
FROM WardChange;
--1c
BEGIN TRAN;
--existing row
--delete
DELETE FROM WardChange
WHERE OldWardIDs=1;
--insert row using existing FK FK_NewWardIDs=11
INSERT INTO WardChange (OldWardIDs,FK_NewWardIDs,PK_WardChangeIDs)
VALUES (5,11,23);
--update row using existing FK FK_NewWardIDs=11
UPDATE WardChange
SET FK_NewWardIDs=11
WHERE FK_NewWardIDs=4;
SELECT *
FROM WardChange
WHERE	OldWardIDs=1 OR --deleted
		PK_WardChangeIDs=23 OR --inserted
		FK_NewWardIDs=4 --updated
;
ROLLBACK;
--1d
BEGIN TRAN;
--non-existing row
--delete
DELETE FROM WardChange
WHERE OldWardIDs=15;
--insert row using non-existing FK FK_NewWardIDs=15
INSERT INTO WardChange (OldWardIDs,FK_NewWardIDs,PK_WardChangeIDs)
VALUES (5,15,23);
--update row using non-existing FK FK_NewWardIDs=15
UPDATE WardChange
SET FK_NewWardIDs=15
WHERE FK_NewWardIDs=4;
SELECT *
FROM WardChange
WHERE	OldWardIDs=15 OR --no row deleted
		PK_WardChangeIDs=23 OR --no new row inserted (referential integrity)
		FK_NewWardIDs=4 --no rows updated (referential integrity)
;
ROLLBACK;
--testCase for NewWard
--b
SELECT *
FROM NewWard;
--validate distinct values from csv file
SELECT DISTINCT PK_NewWardIDs
FROM NewWard
ORDER BY PK_NewWardIDs ASC;
--1c
BEGIN TRAN;
--existing row
--delete
DELETE FROM NewWard
WHERE PK_NewWardIDs=1;
--insert row using existing PK PK_NewWardIDs=11
INSERT INTO NewWard
VALUES (11);
--update row using existing PK PK_NewWardIDs=11
UPDATE NewWard
SET PK_NewWardIDs=11
WHERE PK_NewWardIDs=4;
SELECT *
FROM NewWard
WHERE	PK_NewWardIDs=1 OR --not deleted due to relationship with other table (referential integrity)
		PK_NewWardIDs=11 OR --no new row inserted due to duplicate key, old row retrieved
		PK_NewWardIDs=4 --no row updated due to duplicate key, old row retrieved
;
ROLLBACK;
--d
BEGIN TRAN;
--non-existing row
--delete
DELETE FROM NewWard
WHERE PK_NewWardIDs=15;
--insert row using non-existing PK PK_NewWardIDs=15
INSERT INTO NewWard
VALUES (15);
--update row using non-existing PK PK_NewWardIDs=15
UPDATE NewWard
SET PK_NewWardIDs=16
WHERE PK_NewWardIDs=4;
SELECT *
FROM NewWard
WHERE	PK_NewWardIDs=15 OR --no row deleted
		PK_NewWardIDs=15 OR --new row inserted
		PK_NewWardIDs=4 --no row updated due to relationship with other table (referential integrity)
;
ROLLBACK;

--testCase for OfficeType
--b
--validate distinct values from csv file
SELECT *
FROM OfficeType;
SELECT DISTINCT *
FROM OfficeType;

--c
BEGIN TRAN;
--existing row
--delete
DELETE FROM OfficeType
WHERE PK_OfficeTypeIDs=10;
--insert row using existing PK PK_OfficeTypeIDs=20
INSERT INTO OfficeType
VALUES (20,'Mayor');
--update row using existing PK PK_NewWardIDs=30
UPDATE OfficeType
SET PK_OfficeTypeIDs=40
WHERE PK_OfficeTypeIDs=30;
SELECT *
FROM OfficeType
WHERE	PK_OfficeTypeIDs=10 OR --not deleted due to relationship with other table (referential integrity)
		PK_OfficeTypeIDs=20 OR --no new row inserted due to duplicate key, old row retrieved
		PK_OfficeTypeIDs=30 --no row updated due to duplicate key, old row retrieved
;
ROLLBACK;
--d
BEGIN TRAN;
--non-existing row
--delete
DELETE FROM OfficeType
WHERE PK_OfficeTypeIDs=70;
--insert row using non-existing PK PK_OfficeTypeIDs=50
INSERT INTO OfficeType
VALUES (50,'Mayor');
--update row using non-existing PK PK_OfficeTypeIDs=40
UPDATE OfficeType
SET PK_OfficeTypeIDs=60
WHERE PK_OfficeTypeIDs=40;
SELECT *
FROM OfficeType
WHERE	PK_OfficeTypeIDs=70 OR --no row deleted
		PK_OfficeTypeIDs=50 OR --new row inserted
		PK_OfficeTypeIDs=60 --no row updated due to relationship with other table (referential integrity)
;
ROLLBACK;

CREATE TABLE TestCandidateType (
CandidateTypeIDs int Primary Key Identity(1,1),
CandidateType varchar(23),
Incumbent varchar(1),
Acclaimed varchar(1));
INSERT INTO TestCandidateType 
VALUES	
('Incumbent and Acclaimed','T','T'),
('Incumbent','T','F'),
('Acclaimed','F','T'),
('Unacclaimed','F','F');
DROP TABLE TestCandidateType;
SELECT *
FROM CandidateName;
--not in it's normal form
SELECT *
FROM CandidateType;
--expected normal form
SELECT *
FROM TestCandidateType;



SELECT *
FROM OfficeType;
SELECT *
FROM Candidate_Result;






--test RegularVotingStation_Result
SELECT *
FROM VotingStationName;
SELECT *
FROM VotingStationType;
SELECT *
FROM RegularSpecialVotingStation_Result;
SELECT *
FROM VoteCounts;
USE WeVote;
SELECT *
FROM AgeGroup;
SELECT DISTINCT *
FROM AgeGroup;
BEGIN TRAN;
SELECT *
FROM AgeGroup

BEGIN TRAN;
--existing row
--delete
DELETE FROM AgeGroup
WHERE PK_AgeGroupIDs=2;
--insert row using existing FK FK4_CommunityIDs =1
--SET IDENTITY_INSERT AgeGroup OFF;
INSERT INTO AgeGroup (FK4_CommunityIDs)
VALUES (198);
--update row using existing FK FK4_CommunityIDs =1
UPDATE AgeGroup
SET FK4_CommunityIDs =1
WHERE FK4_CommunityIDs=4;
SELECT *
FROM AgeGroup
WHERE	PK_AgeGroupIDs=2 OR --deleted
		FK4_CommunityIDs=198 OR --inserted
		FK4_CommunityIDs=1 --updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
--delete
DELETE FROM AgeGroup
WHERE PK_AgeGroupIDs=199;
--insert row using non-existing FK FK4_CommunityIDs =199
--SET IDENTITY_INSERT AgeGroup OFF;
INSERT INTO AgeGroup (FK4_CommunityIDs)
VALUES (199);
--update row using existing FK FK4_CommunityIDs =1
UPDATE AgeGroup
SET FK4_CommunityIDs =199
WHERE FK4_CommunityIDs=4;
SELECT *
FROM AgeGroup
WHERE	PK_AgeGroupIDs=199 OR --no row deleted
		FK4_CommunityIDs=199 OR --no new row inserted (referential integrity)
		FK4_CommunityIDs=4 --no rows updated (referential integrity)
;
ROLLBACK;

--test Citizenship
SELECT *
FROM Citizenship
BEGIN TRAN;
--existing row
--delete
DELETE FROM Citizenship
WHERE PK_CitizenshipIDs=2;
--insert row using existing FK FK2_CommunityIDs =1
--SET IDENTITY_INSERT Citizenship OFF;
INSERT INTO Citizenship (FK2_CommunityIDs)
VALUES (198);
--update row using existing FK FK2_CommunityIDs =1
UPDATE Citizenship
SET FK2_CommunityIDs =1
WHERE FK2_CommunityIDs=4;
SELECT *
FROM Citizenship
WHERE	PK_CitizenshipIDs=2 OR --deleted
		FK2_CommunityIDs=198 OR --inserted
		FK2_CommunityIDs=1 --updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
--delete
DELETE FROM Citizenship
WHERE PK_CitizenshipIDs=199;
--insert row using non-existing FK FK2_CommunityIDs =199
--SET IDENTITY_INSERT Citizenship OFF;
INSERT INTO Citizenship (FK2_CommunityIDs)
VALUES (199);
--update row using existing FK FK2_CommunityIDs =1
UPDATE Citizenship
SET FK2_CommunityIDs =199
WHERE FK2_CommunityIDs=4;
SELECT *
FROM Citizenship
WHERE	PK_CitizenshipIDs=199 OR --no row deleted
		FK2_CommunityIDs=199 OR --no new row inserted (referential integrity)
		FK2_CommunityIDs=4 --no rows updated (referential integrity)
;
ROLLBACK;
BEGIN TRAN;
--explicit insert for identity column
--SET IDENTITY_INSERT MedianIncome OFF;
INSERT INTO MedianIncome (PK_MedianIncomeIDs)
VALUES (199);
ROLLBACK;

--update primary key
BEGIN TRAN;
UPDATE MedianIncome
SET PK_MedianIncomeIDs=199
WHERE PK_MedianIncomeIDs=198;
ROLLBACK;

BEGIN TRAN;
--explicit insert for identity column
--SET IDENTITY_INSERT VoterInformation OFF;
INSERT INTO VoterInformation (PK_VoterInformationIDs)
VALUES (235);
ROLLBACK;

--update primary key
BEGIN TRAN;
UPDATE VoterInformation
SET PK_VoterInformationIDs=235
WHERE PK_VoterInformationIDs=234;
ROLLBACK;

BEGIN TRAN;
--explicit insert for identity column
--SET IDENTITY_INSERT WardChange OFF;
INSERT INTO WardChange (PK_WardChangeIDs)
VALUES (23);
ROLLBACK;

--update primary key
BEGIN TRAN;
UPDATE WardChange
SET PK_WardChangeIDs=23
WHERE PK_WardChangeIDs=22;
ROLLBACK;

BEGIN TRAN;
--explicit insert for identity column
--SET IDENTITY_INSERT WardChange OFF;
INSERT INTO WardChange(PK_WardChangeIDs)
VALUES (23);
ROLLBACK;

--update primary key
BEGIN TRAN;
UPDATE WardChange
SET PK_WardChangeIDs=23
WHERE PK_WardChangeIDs=22;
ROLLBACK;

--test CandidateName
SELECT *
FROM CandidateName;
SELECT DISTINCT *
FROM CandidateName;

BEGIN TRAN;
--existing row
DELETE FROM CandidateName
WHERE PK_CandidateIDs=131;
--insert row using existing FK FK_CandidateTypeIDs =2
--SET IDENTITY_INSERT CandidateName OFF;
INSERT INTO CandidateName (PK_CandidateIDs,CandidateNames)
VALUES (131,'Test Candidate Name 1');
INSERT INTO CandidateName (PK_CandidateIDs,CandidateNames,FK_CandidateTypeIDs)
VALUES (132,'Test Candidate Name 2',2);
--update row using existing FK FK_CandidateTypeIDs =3
UPDATE CandidateName
SET FK_CandidateTypeIDs =3
WHERE FK_CandidateTypeIDs=2;
SELECT *
FROM CandidateName
WHERE	PK_CandidateIDs=131 OR --not deleted (referential integrity)
		CandidateNames='Test Candidate Name 1' OR --not inserted (duplicate key)
		CandidateNames='Test Candidate Name 2' OR --inserted
		FK_CandidateTypeIDs=2 -- updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
DELETE FROM CandidateName
WHERE PK_CandidateIDs=132;
--insert row using non-existing FK FK_CandidateTypeIDs =15
--SET IDENTITY_INSERT CandidateName OFF;
INSERT INTO CandidateName (PK_CandidateIDs,CandidateNames,FK_CandidateTypeIDs)
VALUES (133,'Test Candidate Name 2',5);
--update row using non-existing FK FK_CandidateTypeIDs =2000
UPDATE CandidateName
SET FK_CandidateTypeIDs =5
WHERE FK_CandidateTypeIDs=3;
SELECT *
FROM CandidateName
WHERE	PK_CandidateIDs=132 OR --no row deleted
		CandidateNames='Test Candidate Name 2' OR --no row inserted (referential integrity)
		FK_CandidateTypeIDs=3 --no rows updated (referential integrity)
;
ROLLBACK;

--test CandidateType
SELECT *
FROM CandidateType;
SELECT DISTINCT *
FROM CandidateType;

BEGIN TRAN;
--explicit insert for identity column
--SET IDENTITY_INSERT CandidateType OFF;
INSERT INTO CandidateType (PK_CandidateTypeIDs)
VALUES (5);
ROLLBACK;

BEGIN TRAN;
UPDATE CandidateType
SET PK_CandidateTypeIDs=5
WHERE PK_CandidateTypeIDs=4;
ROLLBACK;

BEGIN TRAN;
--existing row
DELETE FROM CandidateType
WHERE PK_CandidateTypeIDs=4;
--insert row using existing PK PK_CandidateTypeIDs =2
SET IDENTITY_INSERT CandidateType ON;
INSERT INTO CandidateType (PK_CandidateTypeIDs,CandidateTypes)
VALUES (4,'Test Candidate Type 1');
INSERT INTO CandidateType (PK_CandidateTypeIDs,CandidateTypes)
VALUES (5,'Test Candidate Type 2');
--update row using existing PK PK_CandidateTypeIDs =3
--UPDATE CandidateType
--SET PK_CandidateTypeIDs =3
--WHERE PK_CandidateTypeIDs=2;
SELECT *
FROM CandidateType
WHERE	PK_CandidateTypeIDs=4 OR --not deleted (referential integrity)
		CandidateTypes='Test Candidate Type 1' OR --not inserted (duplicate key)
		CandidateTypes='Test Candidate Type 2' --inserted
--		PK_CandidateTypeIDs=2 --not updated (duplicate key)
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
DELETE FROM CandidateType
WHERE PK_CandidateTypeIDs=5;
--insert row using non-existing PK PK_CandidateTypeIDs =5
SET IDENTITY_INSERT CandidateType OFF;
INSERT INTO CandidateType (PK_CandidateTypeIDs,CandidateTypes)
VALUES (5,'Test Candidate Type 2');
--update row using non-existing PK PK_CandidateTypeIDs =2000
SELECT *
FROM CandidateType
WHERE	PK_CandidateTypeIDs=132 OR --no row deleted
		CandidateTypes='Test Candidate Type 2' --no row inserted, IDENTITY_INSERT OFF
;
ROLLBACK;

--test NewWard
SELECT *
FROM NewWard;
SELECT DISTINCT *
FROM NewWard;

BEGIN TRAN;
--existing row
DELETE FROM NewWard
WHERE PK_NewWardIDs=14;
--insert row using existing PK PK_NewWardIDs =14
--SET IDENTITY_INSERT NewWard ON;
INSERT INTO NewWard
VALUES (4);
--update row using existing PK PK_NewWardIDs =3
UPDATE NewWard
SET PK_NewWardIDs =3
WHERE PK_NewWardIDs=2;
SELECT *
FROM NewWard
WHERE	PK_NewWardIDs=14 OR --not deleted (referential integrity)
		PK_NewWardIDs=4 OR --not inserted (duplicate key)
		PK_NewWardIDs=2 --not updated (duplicate key)
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
DELETE FROM NewWard
WHERE PK_NewWardIDs=16;
--insert row using non-existing PK PK_NewWardIDs =5
--SET IDENTITY_INSERT NewWard OFF;
INSERT INTO NewWard
VALUES (15);
--update row using non-existing PK PK_NewWardIDs =16
UPDATE NewWard
SET PK_NewWardIDs=16
WHERE PK_NewWardIDs=2;
SELECT *
FROM NewWard
WHERE	PK_NewWardIDs=16 OR -- no row deleted
		PK_NewWardIDs=15 OR --new row will be inserted
		PK_NewWardIDs=2 --no row will be updated (referential integrity)
;
ROLLBACK;

--test Candidate_Result
SELECT *
FROM Candidate_Result;
SELECT DISTINCT CandidateIDs, CandidateNames, CandidateTypes, FK_OfficeTypeIDs
FROM Candidate_Result;
SELECT DISTINCT FK3_NewWardIDs
FROM Candidate_Result;

BEGIN TRAN;
--explicit insert for identity column
--SET IDENTITY_INSERT Candidate_Result OFF;
INSERT INTO Candidate_Result (PK_CandidateResultIDs)
VALUES (370);
ROLLBACK;

BEGIN TRAN;
--existing row
DELETE FROM Candidate_Result
WHERE PK_CandidateResultIDs=369;
--insert row using existing FK FK3_NewWardIDs =14
--SET IDENTITY_INSERT Candidate_Result OFF;
INSERT INTO Candidate_Result (CandidateIDs,CandidateNames,CandidateTypes,FK3_NewWardIDs)
VALUES (130,'Test CandidateResult 1','Incumbent',14)
--update row using existing FK FK3_NewWardIDs =14
UPDATE Candidate_Result
SET FK3_NewWardIDs =14
WHERE FK3_NewWardIDs=2;
SELECT *
FROM Candidate_Result
WHERE	PK_CandidateResultIDs=369 OR --row deleted
		CandidateNames='Test CandidateResult 1' OR --new row inserted
		CandidateNames='Test CandidateResult 2' OR --new row inserted
		FK3_NewWardIDs=2 --row updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
DELETE FROM Candidate_Result
WHERE PK_CandidateResultIDs=370;
--insert row using non-existing FK FK3_NewWardIDs =15
--SET IDENTITY_INSERT Candidate_Result OFF;
INSERT INTO Candidate_Result (CandidateIDs,CandidateNames,CandidateTypes,FK3_NewWardIDs)
VALUES (130,'Test CandidateResult 1','Incumbent',15)
--update row using non-existing FK FK3_NewWardIDs =15
UPDATE Candidate_Result
SET FK3_NewWardIDs =15
WHERE FK3_NewWardIDs=2;
SELECT *
FROM Candidate_Result
WHERE	PK_CandidateResultIDs=370 OR --no row deleted
		CandidateNames='Test CandidateResult 1' OR --no new row inserted (referential integrity)
		FK3_NewWardIDs=2 --no row updated (referential integrity)
;
ROLLBACK;

--testCase for PoliticalScale
--b
SELECT *
FROM PoliticalScale;
--validate distinct values from csv file
SELECT DISTINCT PK_PoliticalIDs
FROM PoliticalScale
ORDER BY PK_PoliticalIDs ASC;
--1c
BEGIN TRAN;
--existing row
--delete
DELETE FROM PoliticalScale
WHERE PK_PoliticalIDs=1;
--insert row using existing PK PK_NewWardIDs=11
INSERT INTO PoliticalScale
VALUES (2,'Test');
--update row using existing PK PK_NewWardIDs=11
UPDATE PoliticalScale
SET PK_PoliticalIDs=1
WHERE PK_PoliticalIDs=3;
SELECT *
FROM PoliticalScale
WHERE	PK_PoliticalIDs=1 OR --row not deleted PRIMARY KEY constraint
		PK_PoliticalIDs=2 OR --no new row inserted due to duplicate key, old row retrieved
		PK_PoliticalIDs=3 --no row updated due to duplicate key, old row retrieved
;
ROLLBACK;
--d
BEGIN TRAN;
--non-existing row
--delete
DELETE FROM PoliticalScale
WHERE PK_PoliticalIDs=4;
--insert row using existing PK PK_NewWardIDs=11
INSERT INTO PoliticalScale
VALUES (4,'Test');
--update row using existing PK PK_NewWardIDs=11
UPDATE PoliticalScale
SET PK_PoliticalIDs=5
WHERE PK_PoliticalIDs=3;
SELECT *
FROM PoliticalScale
WHERE	PK_PoliticalIDs=4 OR --no row deleted
		PK_PoliticalIDs=4 OR --new row
		PK_PoliticalIDs=3 --row updated 
;
ROLLBACK;


