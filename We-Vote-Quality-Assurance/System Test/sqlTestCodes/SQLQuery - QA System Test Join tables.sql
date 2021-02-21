
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

BEGIN TRAN;
--test insert new councillor candidate in an existing ward
INSERT INTO CandidateName
VALUES (200,'New Candidate 1',2)
--test update candidate name
UPDATE CandidateName
SET CandidateNames='Renamed Candidate'
WHERE PK_CandidateIDs=131;
--retrieve data from CandidateName
SELECT *
FROM CandidateName
WHERE	PK_CandidateIDs=200 OR
		PK_CandidateIDs=131;
--retrieve data from Candidate_Result
SELECT *
FROM Candidate_Result
WHERE	CandidateIDs=200 OR --no row retrieved
		CandidateIDs=131; --retrieved data is old
ROLLBACK;


DROP TABLE TestVotingStationName;

SELECT DISTINCT VSN.PK_VotingStationIDs AS VotingStationIDs, 
				CDM.CommunityIDs AS FK7_CommunityIDs
		INTO TestVotingStationInCommunity
		FROM VotingStationName AS VSN 
FULL OUTER JOIN CommunityDataMaster AS CDM
		ON CDM.VotingStationIDs = VSN.PK_VotingStationIDs;

ALTER TABLE TestVotingStationInCommunity
ADD PK_VotingStationInCommunityIDs SMALLINT IDENTITY (1,1);
DROP TABLE TestVotingStationInCommunity;
CREATE VIEW TestVSResult_vw AS (
SELECT	a.PK_VotingStationIDs AS VotingStationIDs,
		a.VotingStationNames,
		b.VotingStationTypes,
		c.FK7_CommunityIDs
FROM VotingStationName a
INNER JOIN TestVotingStationInCommunity c ON c.VotingStationIDs=PK_VotingStationIDs
INNER JOIN VotingStationType b ON b.PK_VotingStationTypeIDs=a.FK_VotingStationTypeIDs);
SELECT *
FROM TestVSResult_vw;

DROP VIEW TestVSResult_vw;

SELECT *
FROM TestCommunityVotingStation;
DROP TABLE TestCommunityVotingStation;

BEGIN TRAN;
--test for a new voting station in a Community
INSERT INTO VotingStationName VALUES (1436,'New Voting Station',11); --a regular voting station
INSERT INTO RegularSpecialVotingStation_Result VALUES (1436,'New Voting Station','Regular',155) --new voting station in community 155
INSERT INTO TestVotingStationInCommunity VALUES (1436,155); --new voting station in community 155
--test update voting station name
UPDATE VotingStationName
SET VotingStationNames='Renamed VotingStation'
WHERE PK_VotingStationIDs=1435;
SELECT * --retrieve data from Voting Station
FROM VotingStationName
WHERE	PK_VotingStationIDs=1435 OR
		PK_VotingStationIDs=1436;
SELECT * --retrieve data from Voting Station Result
FROM RegularSpecialVotingStation_Result_vw
WHERE	VotingStationIDs=1435 OR --updated data not retrieved
		VotingStationIDs=1436; --new row retrieved 
SELECT * --expected retrieved data 
FROM TestVSResult_vw
WHERE	VotingStationIDs=1435 OR --updated data retrieved
		VotingStationIDs=1436; --new row retrieved
ROLLBACK;