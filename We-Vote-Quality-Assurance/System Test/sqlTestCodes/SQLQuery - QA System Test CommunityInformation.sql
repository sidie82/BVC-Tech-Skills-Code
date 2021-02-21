--testCase for CommunityInformation
--test query voting station 101
SELECT *
FROM RegularSpecialVotingStation_Result
WHERE VotingStationIDs=101;
--thru NewWard
SELECT	a.VotingStationIDs,
		a.VotingStationNames,
		b.PK_NewWardIDs,
		c.FK1_NewWardIDs,
		c.PK_CommunityIDs,
		c.CommunityNames,
		c.CommunityPopulations
FROM RegularSpecialVotingStation_Result a
LEFT JOIN NewWard b
ON a.FK2_NewWardIDs=b.PK_NewWardIDs
LEFT JOIN CommunityInformation c
ON c.FK1_NewWardIDs=b.PK_NewWardIDs
WHERE a.VotingStationIDs=101;

--testCase for CommunityInformation
--test query voting station 101
SELECT *
FROM RegularSpecialVotingStation_Result
WHERE VotingStationIDs=101;
--direct to CommunityInfo
SELECT	a.VotingStationIDs,
		a.VotingStationNames,
--		b.PK_NewWardIDs,
		c.FK1_NewWardIDs,
		c.PK_CommunityIDs,
		c.CommunityNames,
		c.CommunityPopulations
FROM RegularSpecialVotingStation_Result a
--LEFT JOIN NewWard b
--ON a.FK2_NewWardIDs=b.PK_NewWardIDs
LEFT JOIN CommunityInformation c
ON c.PK_CommunityIDs=a.FK8_CommunityIDs
WHERE a.VotingStationIDs=101;

--test Family
SELECT *
FROM Family;
SELECT DISTINCT *
FROM Family;

BEGIN TRAN;
--existing row
--delete
DELETE FROM Family
WHERE PK_FamilyIDs=2;
--insert row using existing FK FK3_CommunityIDs =1
--SET IDENTITY_INSERT Family OFF;
INSERT INTO Family (FK3_CommunityIDs)
VALUES (198);
--update row using existing FK FK3_CommunityIDs =1
UPDATE Family
SET FK3_CommunityIDs =1
WHERE FK3_CommunityIDs=4;
SELECT *
FROM Family
WHERE	PK_FamilyIDs=2 OR --deleted
		FK3_CommunityIDs=198 OR --inserted
		FK3_CommunityIDs=1 --updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
--delete
DELETE FROM Family
WHERE PK_FamilyIDs=199;
--insert row using non-existing FK FK3_CommunityIDs =199
--SET IDENTITY_INSERT Family OFF;
INSERT INTO Family (FK3_CommunityIDs)
VALUES (199);
--update row using existing FK FK3_CommunityIDs =1
UPDATE Family
SET FK3_CommunityIDs =199
WHERE FK3_CommunityIDs=4;
SELECT *
FROM Family
WHERE	PK_FamilyIDs=199 OR --no row deleted
		FK3_CommunityIDs=199 OR --no new row inserted (referential integrity)
		FK3_CommunityIDs=4 --no rows updated (referential integrity)
;
ROLLBACK;

--test Gender
SELECT *
FROM Gender;
SELECT DISTINCT *
FROM Gender;
BEGIN TRAN;
--existing row
--delete
DELETE FROM Gender
WHERE PK_GenderIDs=2;
--insert row using existing FK FK6_CommunityIDs =1
--SET IDENTITY_INSERT Gender OFF;
INSERT INTO Gender (FK6_CommunityIDs)
VALUES (198);
--update row using existing FK FK6_CommunityIDs =1
UPDATE Gender
SET FK6_CommunityIDs =1
WHERE FK6_CommunityIDs=4;
SELECT *
FROM Gender
WHERE	PK_GenderIDs=2 OR --deleted
		FK6_CommunityIDs=198 OR --inserted
		FK6_CommunityIDs=1 --updated
;
ROLLBACK;
BEGIN TRAN;
--non-existing row
--delete
DELETE FROM Gender
WHERE PK_GenderIDs=199;
--insert row using non-existing FK FK6_CommunityIDs =199
--SET IDENTITY_INSERT Gender OFF;
INSERT INTO Gender (FK6_CommunityIDs)
VALUES (199);
--update row using existing FK FK6_CommunityIDs =1
UPDATE Gender
SET FK6_CommunityIDs =199
WHERE FK6_CommunityIDs=4;
SELECT *
FROM Gender
WHERE	PK_GenderIDs=199 OR --no row deleted
		FK6_CommunityIDs=199 OR --no new row inserted (referential integrity)
		FK6_CommunityIDs=4 --no rows updated (referential integrity)
;
ROLLBACK;

--test HomeOwnership
SELECT *
FROM HomeOwnership;
SELECT DISTINCT *
FROM HomeOwnership;

BEGIN TRAN;
--existing row
--delete
DELETE FROM HomeOwnership
WHERE PK_HomeOwnershipIDs=2;
--insert row using existing FK FK5_CommunityIDs =1
--SET IDENTITY_INSERT HomeOwnership OFF;
INSERT INTO HomeOwnership (FK5_CommunityIDs)
VALUES (198);
--update row using existing FK FK5_CommunityIDs =1
UPDATE HomeOwnership
SET FK5_CommunityIDs =1
WHERE FK5_CommunityIDs=4;
SELECT *
FROM HomeOwnership
WHERE	PK_HomeOwnershipIDs=2 OR --deleted
		FK5_CommunityIDs=198 OR --inserted
		FK5_CommunityIDs=1 --updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
--delete
DELETE FROM HomeOwnership
WHERE PK_HomeOwnershipIDs=199;
--insert row using non-existing FK FK5_CommunityIDs =199
--SET IDENTITY_INSERT HomeOwnership OFF;
INSERT INTO HomeOwnership (FK5_CommunityIDs)
VALUES (199);
--update row using existing FK FK5_CommunityIDs =1
UPDATE HomeOwnership
SET FK5_CommunityIDs =199
WHERE FK5_CommunityIDs=4;
SELECT *
FROM HomeOwnership
WHERE	PK_HomeOwnershipIDs=199 OR --no row deleted
		FK5_CommunityIDs=199 OR --no new row inserted (referential integrity)
		FK5_CommunityIDs=4 --no rows updated (referential integrity)
;
ROLLBACK;

--test MedianIncome
SELECT *
FROM MedianIncome;
SELECT DISTINCT *
FROM MedianIncome;

select * from MedianIncome m
Join CommunityInformation c
on m.FK1_CommunityIDs =c.PK_CommunityIDs

BEGIN TRAN;
--existing row
--delete
DELETE FROM MedianIncome
WHERE PK_MedianIncomeIDs=2;
--insert row using existing FK FK1_CommunityIDs =1
--SET IDENTITY_INSERT MedianIncome OFF;
INSERT INTO MedianIncome (FK1_CommunityIDs)
VALUES (198);
--update row using existing FK FK1_CommunityIDs =1
UPDATE MedianIncome
SET FK1_CommunityIDs =1
WHERE FK1_CommunityIDs=4;
SELECT *
FROM MedianIncome
WHERE	PK_MedianIncomeIDs=2 OR --deleted
		FK1_CommunityIDs=198 OR --inserted
		FK1_CommunityIDs=1 --updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
--delete
DELETE FROM MedianIncome
WHERE PK_MedianIncomeIDs=199;
--insert row using non-existing FK FK1_CommunityIDs =199
--SET IDENTITY_INSERT MedianIncome OFF;
INSERT INTO MedianIncome (FK1_CommunityIDs)
VALUES (199);
--update row using existing FK FK1_CommunityIDs =1
UPDATE MedianIncome
SET FK1_CommunityIDs =199
WHERE FK1_CommunityIDs=4;
SELECT *
FROM MedianIncome
WHERE	PK_MedianIncomeIDs=199 OR --no row deleted
		FK1_CommunityIDs=199 OR --no new row inserted (referential integrity)
		FK1_CommunityIDs=4 --no rows updated (referential integrity)
;
ROLLBACK;

--test RegularSpecialVotingStation_Result
SELECT *
FROM RegularSpecialVotingStation_Result;
SELECT DISTINCT *
FROM RegularSpecialVotingStation_Result;
BEGIN TRAN;
--existing row
--delete
DELETE FROM RegularSpecialVotingStation_Result
WHERE PK_RegularSpecialVotingStation_ResultIDs=2;
--insert row using existing FK FK1_CommunityIDs =1
--SET IDENTITY_INSERT RegularSpecialVotingStation_Result OFF;
INSERT INTO RegularSpecialVotingStation_Result (FK1_CommunityIDs)
VALUES (198);
--update row using existing FK FK1_CommunityIDs =1
UPDATE RegularSpecialVotingStation_Result
SET FK1_CommunityIDs =1
WHERE FK1_CommunityIDs=4;
SELECT *
FROM RegularSpecialVotingStation_Result
WHERE	PK_RegularSpecialVotingStation_ResultIDs=2 OR --deleted
		FK1_CommunityIDs=198 OR --inserted
		FK1_CommunityIDs=1 --updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
--delete
DELETE FROM RegularSpecialVotingStation_Result
WHERE PK_RegularSpecialVotingStation_ResultIDs=199;
--insert row using non-existing FK FK1_CommunityIDs =199
--SET IDENTITY_INSERT RegularSpecialVotingStation_Result OFF;
INSERT INTO RegularSpecialVotingStation_Result (FK1_CommunityIDs)
VALUES (199);
--update row using existing FK FK1_CommunityIDs =1
UPDATE RegularSpecialVotingStation_Result
SET FK1_CommunityIDs =199
WHERE FK1_CommunityIDs=4;
SELECT *
FROM RegularSpecialVotingStation_Result
WHERE	PK_RegularSpecialVotingStation_ResultIDs=199 OR --no row deleted
		FK1_CommunityIDs=199 OR --no new row inserted (referential integrity)
		FK1_CommunityIDs=4 --no rows updated (referential integrity)
;
ROLLBACK;

--test VoteCounts
SELECT *
FROM VoteCounts;
SELECT DISTINCT *
FROM VoteCounts;

BEGIN TRAN;
--existing row
--delete
DELETE FROM VoteCounts
WHERE PK_VotingStationCandidateIDs=1435103;
--insert row using existing FK FK2_VotingStationIDs =130
--SET IDENTITY_INSERT VoteCounts OFF;
INSERT INTO VoteCounts (FK2_VotingStationIDs,FK2_CandidateIDs,PK_VotingStationCandidateIDs)
VALUES (130,79,130079);
--update row using existing FK FK2_VotingStationIDs =1
UPDATE VoteCounts
SET FK2_VotingStationIDs =131
WHERE FK2_VotingStationIDs=130;
SELECT *
FROM VoteCounts
WHERE	PK_VotingStationCandidateIDs=1435103 OR --deleted
		FK2_VotingStationIDs=130 OR --inserted
		FK2_VotingStationIDs=131 --updated
;
ROLLBACK;
BEGIN TRAN;
--non-existing row
--delete
DELETE FROM VoteCounts
WHERE PK_VotingStationCandidateIDs=2000100;
--insert row using non-existing FK FK2_VotingStationIDs =2000
--SET IDENTITY_INSERT VoteCounts OFF;
INSERT INTO VoteCounts (FK2_VotingStationIDs,FK2_CandidateIDs,PK_VotingStationCandidateIDs)
VALUES (2000,79,2000079);
--update row using non-existing FK FK2_VotingStationIDs =2000
UPDATE VoteCounts
SET FK2_VotingStationIDs =2000
WHERE FK2_VotingStationIDs=130;
SELECT *
FROM VoteCounts
WHERE	PK_VotingStationCandidateIDs=2000100 OR --no row deleted
		FK2_VotingStationIDs=2000 OR --no new row inserted (referential integrity)
		FK2_VotingStationIDs=4 --no rows updated (referential integrity)
;
ROLLBACK;
BEGIN TRAN;
--insert row using existing FK FK2_VotingStationIDs =130
--SET IDENTITY_INSERT VoteCounts OFF;
INSERT INTO VoteCounts (FK2_VotingStationIDs)
VALUES (130);
--insert row using existing FK FK2_VotingStationIDs =130
--SET IDENTITY_INSERT VoteCounts OFF;
INSERT INTO VoteCounts (FK2_VotingStationIDs,FK2_CandidateIDs,PK_VotingStationCandidateIDs)
VALUES (130,999,130999);

--test VoterInformation
SELECT *
FROM VoterInformation;
SELECT DISTINCT *
FROM VoterInformation;
BEGIN TRAN;
--existing row
--delete
DELETE FROM VoterInformation
WHERE PK_VoterInformationIDs=234;
--insert row using existing FK FK3_VotingStationIDs =130
--SET IDENTITY_INSERT VoterInformation OFF;
INSERT INTO VoterInformation (FK3_VotingStationIDs)
VALUES (130);
--update row using existing FK FK3_VotingStationIDs =130
UPDATE VoterInformation
SET FK3_VotingStationIDs =131
WHERE FK3_VotingStationIDs=130;
SELECT *
FROM VoterInformation
WHERE	PK_VoterInformationIDs=234 OR --deleted
	FK3_VotingStationIDs=130 OR --inserted
	FK3_VotingStationIDs=131 --updated
;
ROLLBACK;
BEGIN TRAN;
--non-existing row
--delete
DELETE FROM VoterInformation
WHERE PK_VoterInformationIDs=235;
--insert row using non-existing FK FK3_VotingStationIDs =2000
--SET IDENTITY_INSERT VoterInformation OFF;
INSERT INTO VoterInformation (FK3_VotingStationIDs)
VALUES (2000);
--update row using non-existing FK FK3_VotingStationIDs =2000
UPDATE VoterInformation
SET FK3_VotingStationIDs =2000
WHERE FK3_VotingStationIDs=234;
SELECT *
FROM VoterInformation
WHERE	PK_VoterInformationIDs=235 OR --no row deleted
		FK3_VotingStationIDs=2000 OR --no new row inserted (referential integrity)
		FK3_VotingStationIDs=234 --no rows updated (referential integrity)
;
ROLLBACK;
BEGIN TRAN;
--explicit insert for identity column
--SET IDENTITY_INSERT VoterInformation OFF;
INSERT INTO VoterInformation (PK_VoterInformationIDs)
VALUES (235);
UPDATE VoterInformation
SET PK_VoterInformationIDs=235
WHERE PK_VoterInformationIDs=234;
ROLLBACK;
--test VotingStationName
SELECT *
FROM VotingStationName;
SELECT DISTINCT *
FROM VotingStationName;

BEGIN TRAN;
--existing row
--delete
DELETE FROM VotingStationName
WHERE PK_VotingStationIDs=234;
--insert row using existing FK FK1_VotingStationTypeIDs =22
--SET IDENTITY_INSERT VotingStationName OFF;
INSERT INTO VotingStationName (PK_VotingStationIDs,VotingStationNames,FK1_VotingStationTypeIDs)
VALUES (1435,'Test Voting Station Name 1',22);
INSERT INTO VotingStationName (PK_VotingStationIDs,VotingStationNames,FK1_VotingStationTypeIDs)
VALUES (1436,'Test Voting Station Name 2',22);
--update row using existing FK FK1_VotingStationTypeIDs =22
UPDATE VotingStationName
SET FK1_VotingStationTypeIDs =11
WHERE FK1_VotingStationTypeIDs=22;
SELECT *
FROM VotingStationName
WHERE	PK_VotingStationIDs=234 OR --not deleted (referential integrity)
		VotingStationNames='Test Voting Station Name 1' OR --not inserted (duplicate key)
		VotingStationNames='Test Voting Station Name 2' OR --inserted
		FK1_VotingStationTypeIDs=22 --updated
;
ROLLBACK;
BEGIN TRAN;
--non-existing row
--delete
DELETE FROM VotingStationName
WHERE PK_VotingStationIDs=1437;
--insert row using non-existing FK FK1_VotingStationTypeIDs =33
--SET IDENTITY_INSERT VotingStationName OFF;
INSERT INTO VotingStationName (PK_VotingStationIDs,VotingStationNames,FK1_VotingStationTypeIDs)
VALUES (1436,'Test Voting Station Name 2',33);
--update row using non-existing FK FK1_VotingStationTypeIDs =2000
UPDATE VotingStationName
SET FK1_VotingStationTypeIDs =33
WHERE FK1_VotingStationTypeIDs=22;
SELECT *
FROM VotingStationName
WHERE	PK_VotingStationIDs=1437 OR --no row deleted
		VotingStationNames='Test Voting Station Name 2' OR --no row inserted (referential integrity)
		FK1_VotingStationTypeIDs=22 --no rows updated (referential integrity)
;
ROLLBACK;
--test VotingStationType
SELECT *
FROM VotingStationType;
SELECT DISTINCT *
FROM VotingStationType;
BEGIN TRAN;
--existing row
--delete
DELETE FROM VotingStationType
WHERE PK_VotingStationTypeIDs=11;
--insert row using existing FK PK_VotingStationTypeIDs=22
--SET IDENTITY_INSERT VotingStationType OFF;
INSERT INTO VotingStationType (PK_VotingStationTypeIDs)
VALUES (22);
INSERT INTO VotingStationType (PK_VotingStationTypeIDs,VotingStationTypes)
VALUES (22,'Test');
--update row using existing FK PK_VotingStationTypeIDs=22
UPDATE VotingStationType
SET PK_VotingStationTypeIDs =11
WHERE PK_VotingStationTypeIDs=22;
SELECT *
FROM VotingStationType
WHERE	PK_VotingStationTypeIDs=11 OR --no row deleted (referential integrity)
	PK_VotingStationTypeIDs=22 OR --no new row inserted (duplicate key)
	PK_VotingStationTypeIDs=22 --no row updated (duplicate key)
;
ROLLBACK;
BEGIN TRAN;
--non-existing row
--delete
DELETE FROM VotingStationType
WHERE PK_VotingStationTypeIDs=44;
--insert row using non-existing FK PK_VotingStationTypeIDs=33
--SET IDENTITY_INSERT VotingStationType OFF;
INSERT INTO VotingStationType (PK_VotingStationTypeIDs,VotingStationTypes)
VALUES (33,'Test');
--update row using non-existing FK PK_VotingStationTypeIDs=33
UPDATE VotingStationType
SET PK_VotingStationTypeIDs =55
WHERE PK_VotingStationTypeIDs=22;
SELECT *
FROM VotingStationType
WHERE	PK_VotingStationTypeIDs=44 OR --no row deleted
		PK_VotingStationTypeIDs=33 OR --new row inserted
		PK_VotingStationTypeIDs=55 --no rows updated (referential integrity)
;
ROLLBACK;











--test CommunityInformation
SELECT *
FROM CommunityInformation;
SELECT DISTINCT *
FROM CommunityInformation;

BEGIN TRAN;
--explicit insert for identity column
--SET IDENTITY_INSERT CommunityInformation OFF;
INSERT INTO CommunityInformation (PK_CommunityIDs)
VALUES (199);
ROLLBACK;

BEGIN TRAN;
UPDATE CommunityInformation
SET PK_CommunityIDs=199
WHERE PK_CommunityIDs=198;
ROLLBACK;

BEGIN TRAN;
--existing row
DELETE FROM CommunityInformation
WHERE PK_CommunityIDs=197;
--insert row using existing FK FK1_NewWardIDs =2
--SET IDENTITY_INSERT CommunityInformation OFF;
INSERT INTO CommunityInformation (PK_CommunityIDs,CommunityNames)
VALUES (198,'Test Community 1');
INSERT INTO CommunityInformation (PK_CommunityIDs,CommunityNames,CommunityPopulations,FK1_NewWardIDs)
VALUES (199,'Test Community 2',999,2);
--update row using existing FK FK1_NewWardIDs =3
UPDATE CommunityInformation
SET FK1_NewWardIDs =3
WHERE FK1_NewWardIDs=2;
SELECT *
FROM CommunityInformation
WHERE	PK_CommunityIDs=197 OR --not deleted (referential integrity)
		CommunityNames='Test Community 1' OR --not inserted (duplicate key)
		CommunityNames='Test Community 2' OR --inserted
		FK1_NewWardIDs=2 -- updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
DELETE FROM CommunityInformation
WHERE PK_CommunityIDs=200;
--insert row using non-existing FK FK1_NewWardIDs =15
--SET IDENTITY_INSERT CommunityInformation OFF;
INSERT INTO CommunityInformation (PK_CommunityIDs,CommunityNames,CommunityPopulations,FK1_NewWardIDs)
VALUES (199,'Test Community 2',999,15);
--update row using non-existing FK FK1_NewWardIDs =2000
UPDATE CommunityInformation
SET FK1_NewWardIDs =15
WHERE FK1_NewWardIDs=3;
SELECT *
FROM CommunityInformation
WHERE	PK_CommunityIDs=200 OR --no row deleted
		CommunityNames='Test Community 2' OR --no row inserted (referential integrity)
		FK1_NewWardIDs=3 --no rows updated (referential integrity)
;
ROLLBACK;

--test RegularSpecialVotingStation_Result
SELECT *
FROM RegularSpecialVotingStation_Result;
SELECT DISTINCT *
FROM RegularSpecialVotingStation_Result;

BEGIN TRAN;
--explicit insert for identity column
--SET IDENTITY_INSERT RegularSpecialVotingStation_Result OFF;
INSERT INTO RegularSpecialVotingStation_Result (PK_VotingStationResultIDs)
VALUES (199);
ROLLBACK;

BEGIN TRAN;
UPDATE RegularSpecialVotingStation_Result
SET PK_VotingStationResultIDs=199
WHERE PK_VotingStationResultIDs=198;
ROLLBACK;

BEGIN TRAN;
UPDATE RegularSpecialVotingStation_Result
SET PK_VotingStationResultIDs=199
WHERE PK_VotingStationResultIDs=198;
ROLLBACK;

BEGIN TRAN;
--existing row
DELETE FROM RegularSpecialVotingStation_Result
WHERE PK_VotingStationResultIDs=292;
--insert row using existing FK FK7_CommunityIDs =2
--SET IDENTITY_INSERT RegularSpecialVotingStation_Result OFF;
INSERT INTO RegularSpecialVotingStation_Result (VotingStationNames, VotingStationIDs,VotingStationTypes,FK7_CommunityIDs)
VALUES ('Test Voting Station 1',292,'Regular',2);
INSERT INTO RegularSpecialVotingStation_Result (VotingStationNames, VotingStationIDs,VotingStationTypes,FK7_CommunityIDs)
VALUES ('Test Voting Station 2',293,'Regular',2);
--update row using existing FK FK7_CommunityIDs =3
UPDATE RegularSpecialVotingStation_Result
SET FK7_CommunityIDs =3
WHERE FK7_CommunityIDs=2;
SELECT *
FROM RegularSpecialVotingStation_Result
WHERE	PK_VotingStationResultIDs=292 OR --row deleted
		VotingStationNames='Test Voting Station 1' OR --new row inserted
		VotingStationNames='Test Voting Station 2' OR --new row inserted
		FK7_CommunityIDs=2 --row updated
;
ROLLBACK;

BEGIN TRAN;
--non-existing row
DELETE FROM RegularSpecialVotingStation_Result
WHERE PK_VotingStationResultIDs=293;
--insert row using non-existing FK FK7_CommunityIDs =199
--SET IDENTITY_INSERT RegularSpecialVotingStation_Result OFF;
INSERT INTO RegularSpecialVotingStation_Result (VotingStationNames, VotingStationIDs,VotingStationTypes,FK7_CommunityIDs)
VALUES ('Test Voting Station 1',292,'Regular',199);
INSERT INTO RegularSpecialVotingStation_Result (VotingStationNames, VotingStationIDs,VotingStationTypes,FK7_CommunityIDs)
VALUES ('Test Voting Station 2',293,'Regular',199);
--update row using non-existing FK FK7_CommunityIDs =199
UPDATE RegularSpecialVotingStation_Result
SET FK7_CommunityIDs =199
WHERE FK7_CommunityIDs=2;
SELECT *
FROM RegularSpecialVotingStation_Result
WHERE	PK_VotingStationResultIDs=293 OR --no row deleted
		VotingStationNames='Test Voting Station 1' OR --no new row inserted (referential integrity)
		VotingStationNames='Test Voting Station 2' OR --no new row inserted (referential integrity)
		FK7_CommunityIDs=2 --no row updated (referential integrity)
;
ROLLBACK;




