USE WeVote


--UPDATING MASTER TABLES TO CORRECT VALUES--

--Delete NULL records from CommunityDataMaster file--

DELETE FROM CommunityDataMaster
WHERE CommunityIDs IS NULL;

--Add candidate type and corresponding IDs to the master table--

ALTER TABLE VotingCandidateDataMaster
ADD CandidateTypes AS (CASE 
					WHEN Incumbent = 'T' AND Acclaimed = 'F' THEN 'Incumbent'
					WHEN Incumbent = 'F' AND Acclaimed = 'T' THEN 'Acclaimed'
					WHEN Incumbent = 'F' AND Acclaimed = 'F' THEN 'Unacclaimed'
					WHEN Incumbent = 'T' AND Acclaimed = 'T' THEN 'Incumbent and Acclaimed'
				End);

ALTER TABLE VotingCandidateDataMaster
ADD CandidateTypeIDs AS (CASE 
					WHEN Incumbent = 'T' AND Acclaimed = 'T' THEN 1
					WHEN Incumbent = 'F' AND Acclaimed = 'T' THEN 2
					WHEN Incumbent = 'T' AND Acclaimed = 'F' THEN 3
					WHEN Incumbent = 'F' AND Acclaimed = 'F' THEN 4
				End);

--Correct a demographic value for CommunityIDs=88 in CommunityDataMaster file--

BEGIN TRAN
UPDATE CommunityDataMaster
SET Age30_39Numbers = 270
WHERE CommunityIDs = 88 
AND VotingStationIDs = 1134
COMMIT;

--Update Community IDs in CommunityDataMaster table--

BEGIN TRAN
UPDATE CommunityDataMaster
SET CommunityIDs = CASE
		WHEN CommunityNames = 'Woodbine' THEN 196
		WHEN CommunityNames = 'Woodlands' THEN 197
		WHEN CommunityNames = 'Seton' THEN 198
		END
WHERE 
		CommunityNames = 'Woodbine' OR
		CommunityNames = 'Woodlands' OR
		CommunityNames = 'Seton';
COMMIT;

--CREATE NORMALIZED TABLES FROM MASTER TABLES--

--Create CommunityInformation Table--

SELECT DISTINCT CommunityIDs AS PK_CommunityIDs,
				CommunityNames,
				CommunityPopulations,
				NewWardIDs AS FK1_NewWardIDs
INTO CommunityInformation
FROM CommunityDataMaster;

--Create MedianIncome Table--

SELECT DISTINCT CommunityIDs AS FK1_CommunityIDs,
				IncomeLessThan59KNumbers,
				IncomeLessThan59KPercents,
				Income60K_99999Numbers,
				Income60K_99999Percents,
				Income100K_149999Numbers,
				Income100K_149999Percents,
				Income150K_199999Numbers,
				Income150K_199999Percents,
				IncomeMoreThan200KNumbers,
				IncomeMoreThan200KPercents
INTO MedianIncome
FROM CommunityDataMaster;

ALTER TABLE MedianIncome
ADD PK_MedianIncomeIDs TINYINT IDENTITY (1,1);

--Create Citizenship Table--

SELECT DISTINCT CommunityIDs AS FK2_CommunityIDs,
				CitizenNumbers, 
				CitizenPercents, 
				NonCitizenNumbers, 
				NonCitizenPercents
INTO Citizenship
FROM CommunityDataMaster;

ALTER TABLE Citizenship
ADD PK_CitizenshipIDs TINYINT IDENTITY (1,1);

--Create Family Table--

SELECT DISTINCT CommunityIDs AS FK3_CommunityIDs, 
				FamiliesWChildrenNumbers,
				FamiliesWChildrenPercents,
				FamiliesWOChildrenNumbers,
				FamiliesWOChildrenPercents	
INTO Family
FROM CommunityDataMaster;

ALTER TABLE Family 
ADD PK_FamilyIDs TINYINT IDENTITY (1,1);

--Create AgeGroup Table--

SELECT DISTINCT CommunityIDs AS FK4_CommunityIDs,
				Age20_29Numbers,
				Age20_29Percents,
				Age30_39Numbers,
				Age30_39Percents,
				Age40_49Numbers,
				Age40_49Percents,
				Age50_59Numbers,
				Age50_59Percents,
				Age60_69Numbers,
				Age60_69Percents,
				Age70_79Numbers,
				Age70_79Percents,
				AgeMoreThan80Numbers,
				AgeMoreThan80Percents
INTO AgeGroup
FROM CommunityDataMaster;

ALTER TABLE AgeGroup
ADD PK_AgeGroupIDs TINYINT IDENTITY (1,1);

-- Create HomeOwnership Table--

SELECT DISTINCT CommunityIDs AS FK5_CommunityIDs,
HomeOwnersNumbers,
HomeOwnersPercents,
RentersNumbers,
RentersPercent AS RentersPercents
INTO HomeOwnership
FROM CommunityDataMaster;

ALTER TABLE HomeOwnership
ADD PK_HomeOwnershipIDs TINYINT IDENTITY (1,1);

--Create Gender Table--

SELECT DISTINCT CommunityIDs AS FK6_CommunityIDs,
				FemaleNumbers,
				FemalePercents,
				MaleNumbers,
				MalePercents
INTO Gender
FROM CommunityDataMaster;

ALTER TABLE Gender
ADD PK_GenderIDs TINYINT IDENTITY (1,1);

--Create NewWard Table--

SELECT DISTINCT NewWardIDs AS PK_NewWardIDs
INTO NewWard
FROM VotingCandidateDataMaster;

--Create WardChange Table--

SELECT DISTINCT OldWardIDs,
				NewWardIDs AS FK2_NewWardIDs
INTO WardChange
FROM VotingCandidateDataMaster;

ALTER TABLE WardChange
ADD PK_WardChangeIDs TINYINT IDENTITY (1,1);

--Create VotingStationType Table--

SELECT DISTINCT VotingStationTypeIDs AS PK_VotingStationTypeIDs,
				VotingStationTypes
INTO VotingStationType
FROM VotingCandidateDataMaster;

--Create VotingStationName Table--

SELECT DISTINCT VotingStationIDs AS PK_VotingStationIDs,
				VotingStationNames,
				VotingStationTypeIDs AS FK_VotingStationTypeIDs
INTO VotingStationName
FROM VotingCandidateDataMaster;

--Create VoteCount Table--

SELECT DISTINCT VoteCounts,
				VotingStationIDs AS FK2_VotingStationIDs,
				CandidateIDs AS FK_CandidateIDs
INTO VoteCount 
FROM VotingCandidateDataMaster
ORDER BY FK2_VotingStationIDs, FK_CandidateIDs ASC;

ALTER TABLE VoteCount
ADD PK_VoteCountIDs SMALLINT IDENTITY(1,1);

--Create OfficeType Table--

SELECT DISTINCT OfficeTypeIDs AS PK_OfficeTypeIDs,
                OfficeTypes 
INTO OfficeType
FROM VotingCandidateDataMaster;

--Create CandidateType Table--

SELECT DISTINCT	CandidateTypes
INTO CandidateType
FROM VotingCandidateDataMaster;

ALTER TABLE CandidateType
ADD PK_CandidateTypeIDs TINYINT IDENTITY(1,1);

--Create CandidateName Table--

SELECT DISTINCT CandidateIDs AS PK_CandidateIDs ,
                CandidateNames,
				CAST(CandidateTypeIDs AS TINYINT) AS FK_CandidateTypeIDs
INTO CandidateName
FROM VotingCandidateDataMaster;

--Create PoliticalScale Table--

CREATE TABLE PoliticalScale(
			PK_PoliticalIDs TINYINT PRIMARY KEY,
			PoliticalLevels VARCHAR(7) NOT NULL);

--Create VoterInformation Table--

SELECT DISTINCT EnumeratedElectorsNumbers,
				VoterTurnouts,
				VotingStationIDs AS FK1_VotingStationIDs
INTO VoterInformation
FROM VotingCandidateDataMaster;
  
ALTER TABLE VoterInformation
ADD PK_VoterInformationIDs SMALLINT IDENTITY(1,1);

--Create Candidate_Result Table-- 
-- Join Table (CandidateName, CandidateType and VotingCandidateDataMaster)--

SELECT DISTINCT CN.PK_CandidateIDs AS CandidateIDs,
				CT.PK_CandidateTypeIDs AS CandidateTypeIDs,
				VCDM.NewWardIDs AS FK3_NewWardIDs,
				VCDM.OfficeTypeIDs AS FK_OfficeTypeIDs
		INTO Candidate_Result
FROM CandidateName AS CN
FULL OUTER JOIN CandidateType AS CT 
		ON CN.FK_CandidateTypeIDs = CT.PK_CandidateTypeIDs
FULL OUTER JOIN VotingCandidateDataMaster AS VCDM
		ON VCDM.CandidateIDs = CN.PK_CandidateIDs;

ALTER TABLE Candidate_Result
ADD PK_CandidateResultIDs SMALLINT IDENTITY (1,1);

--Create RegularSpecialVotingStation_Result Table--
--Join Table (VotingStationName, VotingStationType and VotingCandidateDataMaster)--

SELECT DISTINCT VSN.PK_VotingStationIDs AS VotingStationIDs, 
				VST.PK_VotingStationTypeIDs AS VotingStationTypeIDs,
				CDM.CommunityIDs AS FK7_CommunityIDs
		INTO RegularSpecialVotingStation_Result
		FROM VotingStationName AS VSN 
FULL OUTER JOIN VotingStationType AS VST
		ON VST.PK_VotingStationTypeIDs = VSN.FK_VotingStationTypeIDs
FULL OUTER JOIN CommunityDataMaster AS CDM
		ON CDM.VotingStationIDs = VSN.PK_VotingStationIDs;

ALTER TABLE RegularSpecialVotingStation_Result
ADD PK_VotingStationResultIDs SMALLINT IDENTITY (1,1);


--POPULATE TABLES--

--Input Values Into PoliticalScale table--

INSERT INTO PoliticalScale (PK_PoliticalIDs,
							PoliticalLevels)
VALUES (1, 'Left'),
       (2, 'Center'),
       (3, 'Right');

	   
--CONSTRAINTS--

--Add NOT NULL Constraint--
--This constraint is separated from those in "Constraints.sql" because this one is required to create PK on community ID--

ALTER TABLE CommunityInformation
ALTER COLUMN PK_CommunityIDs TINYINT NOT NULL;


--PRIMARY KEY--

--Create Primary Keys--

ALTER TABLE CommunityInformation
ADD CONSTRAINT PK_CommunityIDs PRIMARY KEY (PK_CommunityIDs);

ALTER TABLE AgeGroup
ADD CONSTRAINT PK_AgeGroupIDs PRIMARY KEY (PK_AgeGroupIDs);

ALTER TABLE MedianIncome
ADD CONSTRAINT PK_MedianIncomeIDs PRIMARY KEY (PK_MedianIncomeIDs);

ALTER TABLE Citizenship
ADD CONSTRAINT PK_CitizenshipIDs PRIMARY KEY (PK_CitizenshipIDs);

ALTER TABLE Family
ADD CONSTRAINT PK_FamilyIDs PRIMARY KEY (PK_FamilyIDs);

ALTER TABLE HomeOwnership
ADD CONSTRAINT PK_HomeOwnershipIDs PRIMARY KEY (PK_HomeOwnershipIDs);

ALTER TABLE Gender
ADD CONSTRAINT PK_GenderIDs PRIMARY KEY (PK_GenderIDs);

ALTER TABLE NewWard
ADD CONSTRAINT PK_NewWardIDs PRIMARY KEY (PK_NewWardIDs);

ALTER TABLE WardChange
ADD CONSTRAINT PK_WardChangeIDs PRIMARY KEY (PK_WardChangeIDs);

ALTER TABLE VotingStationType
ADD CONSTRAINT PK_VotingStationTypeIDs PRIMARY KEY (PK_VotingStationTypeIDs);

ALTER TABLE VotingStationName
ADD CONSTRAINT PK_VotingStationIDs PRIMARY KEY (PK_VotingStationIDs);

ALTER TABLE VoteCount
ADD CONSTRAINT PK_VoteCountIDs PRIMARY KEY (PK_VoteCountIDs);

ALTER TABLE OfficeType
ADD CONSTRAINT PK_OfficeTypeIDs PRIMARY KEY (PK_OfficeTypeIDs);

ALTER TABLE CandidateType
ADD CONSTRAINT PK_CandidateTypeIDs PRIMARY KEY (PK_CandidateTypeIDs);

ALTER TABLE CandidateName
ADD CONSTRAINT PK_CandidateIDs  PRIMARY KEY (PK_CandidateIDs);

ALTER TABLE VoterInformation
ADD CONSTRAINT PK_VoterInformationIDs PRIMARY KEY (PK_VoterInformationIDs);

ALTER TABLE Candidate_Result
ADD CONSTRAINT PK_CandidateResultIDs PRIMARY KEY (PK_CandidateResultIDs);

ALTER TABLE RegularSpecialVotingStation_Result
ADD CONSTRAINT PK_VotingStationResultIDs PRIMARY KEY (PK_VotingStationResultIDs);


--FOREIGN KEY--

--Create Foreign Keys--

ALTER TABLE CommunityInformation
ADD CONSTRAINT FK1_NewWardIDs FOREIGN KEY (FK1_NewWardIDs)
REFERENCES NewWard (PK_NewWardIDs);

ALTER TABLE MedianIncome
ADD CONSTRAINT FK1_CommunityIDs FOREIGN KEY (FK1_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE Citizenship
ADD CONSTRAINT FK2_CommunityIDs FOREIGN KEY (FK2_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE Family
ADD CONSTRAINT FK3_CommunityIDs FOREIGN KEY (FK3_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE AgeGroup
ADD CONSTRAINT FK4_CommunityIDs FOREIGN KEY (FK4_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE HomeOwnership
ADD CONSTRAINT FK5_CommunityIDs FOREIGN KEY (FK5_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE Gender
ADD CONSTRAINT FK6_CommunityIDs FOREIGN KEY (FK6_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE WardChange
ADD CONSTRAINT FK2_NewWardIDs FOREIGN KEY (FK2_NewWardIDs)
REFERENCES NewWard (PK_NewWardIDs);

ALTER TABLE VotingStationName
ADD CONSTRAINT FK_VotingStationTypeIDs FOREIGN KEY (FK_VotingStationTypeIDs)
REFERENCES VotingStationType (PK_VotingStationTypeIDs);

ALTER TABLE VoteCount 
ADD CONSTRAINT FK2_VotingStationIDs FOREIGN KEY (FK2_VotingStationIDs)
REFERENCES VotingStationName (PK_VotingStationIDs);

ALTER TABLE VoteCount 
ADD CONSTRAINT FK_CandidateIDs FOREIGN KEY (FK_CandidateIDs)
REFERENCES CandidateName (PK_CandidateIDs);

ALTER TABLE CandidateName
ADD CONSTRAINT FK_CandidateTypeIDs FOREIGN KEY (FK_CandidateTypeIDs)
REFERENCES CandidateType (PK_CandidateTypeIDs);

ALTER TABLE VoterInformation
ADD CONSTRAINT FK1_VotingStationIDs FOREIGN KEY (FK1_VotingStationIDs)
REFERENCES VotingStationName (PK_VotingStationIDs);

ALTER TABLE Candidate_Result
ADD CONSTRAINT FK3_NewWardIDs FOREIGN KEY (FK3_NewWardIDs)
REFERENCES NewWard (PK_NewWardIDs);

ALTER TABLE Candidate_Result
ADD CONSTRAINT FK_OfficeTypeIDs FOREIGN KEY (FK_OfficeTypeIDs)
REFERENCES OfficeType (PK_OfficeTypeIDs);

ALTER TABLE RegularSpecialVotingStation_Result
ADD CONSTRAINT FK7_CommunityIDs FOREIGN KEY (FK7_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);