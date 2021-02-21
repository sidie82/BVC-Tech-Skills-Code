USE WeVote


--UPDATING MASTER TABLES TO CORRECT VALUES--

--Delete NULL records from CommunityDataMaster file--

DELETE FROM CommunityDataMaster
WHERE CommunityIDs IS NULL;

--Correct a demographic value for CommunityIDs=88 in CommunityDataMaster file--

UPDATE CommunityDataMaster
SET Age30_39Numbers = 270
WHERE CommunityIDs = 88 
AND VotingStationIDs = 1134;

--Update VotingCandidateStationIDs in VotingCandidateDataMaster Table to ensure uniqueness--

UPDATE VotingCandidateDataMaster
SET VotingStationCandidateID = CASE 
		WHEN VotingStationIDs= 1302 AND CandidateIDs= 3 THEN 13023333
		WHEN VotingStationIDs= 130 AND CandidateIDs= 13 THEN 13013333
		WHEN VotingStationIDs= 130 AND CandidateIDs= 53 THEN 13053333
		WHEN VotingStationIDs= 130 AND CandidateIDs= 79 THEN 13079999
		WHEN VotingStationIDs= 1309 AND CandidateIDs= 9 THEN 13099999
		WHEN VotingStationIDs= 133 AND CandidateIDs= 13 THEN 13313999
		WHEN VotingStationIDs= 1011 AND CandidateIDs= 25 THEN 10112525
		WHEN VotingStationIDs= 103 AND CandidateIDs= 125 THEN 10312525
		END
WHERE
		(VotingStationIDs= 1302 AND CandidateIDs= 3) OR
		(VotingStationIDs= 130 AND CandidateIDs= 13) OR
		(VotingStationIDs= 130 AND CandidateIDs= 53) OR
		(VotingStationIDs= 130 AND CandidateIDs= 79) OR
		(VotingStationIDs= 1309 AND CandidateIDs= 9) OR
		(VotingStationIDs= 133 AND CandidateIDs= 13) OR
		(VotingStationIDs= 1011 AND CandidateIDs= 25) OR
		(VotingStationIDs= 103 AND CandidateIDs= 125);

--Update Community IDs in CommunityDataMaster table--

UPDATE CommunityDataMaster
SET CommunityIDs = CASE
		WHEN CommunityNames= 'Woodbine' THEN 196
		WHEN CommunityNames= 'Woodlands' THEN 197
		WHEN CommunityNames= 'Seton' THEN 198
		END
WHERE 
		CommunityNames= 'Woodbine' OR
		CommunityNames= 'Woodlands' OR
		CommunityNames= 'Seton';


--CREATE NORMALIZED TABLES FROM MASTER TABLES--

--Create CommunityInformation Table--

SELECT DISTINCT CommunityIDs as PK_CommunityIDs,
				CommunityNames,
				CommunityPopulations,
				NewWardIDs AS FK1_NewWardIDs
INTO CommunityInformation
FROM CommunityDataMaster;

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

--Create MedianIncome Table--

SELECT DISTINCT CommunityIDs AS FK1_CommunityIDs,
				IncomeLessThan59kNumbers,
				IncomeLessThan59kPercents,
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

-- Create HomeOwnership Table--

SELECT DISTINCT CommunityIDs AS FK5_CommunityIDs, 
				HomeOwnersNumbers,
				HomeOwnersPercents,
				RentersNumbers,
				RentersPercent
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
				NewWardIDs AS FK_NewWardIDs
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
				VotingStationTypeIDs AS FK1_VotingStationTypeIDs
INTO VotingStationName
FROM VotingCandidateDataMaster;

--Create VoteCount Table--

SELECT DISTINCT VotingStationCandidateID AS PK_VotingStationCandidateIDs,
				VoteCounts,
				VotingStationIDs AS FK2_VotingStationIDs,
				CandidateIDs AS FK2_CandidateIDs
INTO VoteCounts 
FROM VotingCandidateDataMaster
ORDER BY PK_VotingStationCandidateIDs;

--Create OfficeType Table--

SELECT DISTINCT OfficeTypeIDs AS PK_OfficeTypeIDs ,
                OfficeTypes 
INTO OfficeType
FROM VotingCandidateDataMaster;

--Create CandidateType Table--

SELECT DISTINCT CandidateIDs AS FK1_CandidateIDs,
	   			Incumbent, 
	   			Acclaimed	
INTO CandidateType
FROM VotingCandidateDataMaster;

ALTER TABLE CandidateType
ADD PK_CandidateTypeIDs TINYINT Identity (1,1);

--Create CandidateName Table--

SELECT DISTINCT CandidateIDs AS PK_CandidateIDs ,
                CandidateNames
INTO CandidateName
FROM VotingCandidateDataMaster;

--Create PoliticalScale Table--

CREATE TABLE PoliticalScale(
			PK_PoliticalIDs TINYINT PRIMARY KEY,
			PoliticalLevels VARCHAR(7) NOT NULL);

--Create VoterInformation Table--

SELECT DISTINCT EnumeratedElectorsNumbers,
				VoterTurnouts,
				VotingStationIDs AS FK3_VotingStationIDs
INTO VoterInformation
FROM VotingCandidateDataMaster;
  
ALTER TABLE VoterInformation
ADD PK_VoterInformationIDs SMALLINT IDENTITY(1,1);

--Create Candidate_Result Table-- 
-- Join Table (CandidateName, CandidateType and VotingCandidateDataMaster)--

SELECT DISTINCT CT.FK1_CandidateIDs AS CandidateIDs,
				CN.CandidateNames, 
				CT.Incumbent, 
				CT.Acclaimed, 
				VCDM.NewWardIDs AS FK3_NewWardIDs,
				VCDM.OfficeTypeIDs AS FK_OfficeTypeIDs
		INTO Candidate_Result
FROM CandidateName AS CN
FULL OUTER JOIN CandidateType AS CT 
		ON CN.PK_CandidateIDs = CT.FK1_CandidateIDs
FULL OUTER JOIN VotingCandidateDataMaster AS VCDM
		ON VCDM.CandidateIDs = CN.PK_CandidateIDs;

ALTER TABLE Candidate_Result
ADD PK_CandidateResultIDs SMALLINT Identity (1,1);

--Create RegularSpecialVotingStation_Result Table--
-- Join Table (VotingStationName, VotingStationType and VotingCandidateDataMaster)--

SELECT DISTINCT VSN.PK_VotingStationIDs AS VotingStationIDs, 
				VSN.VotingStationNames, VST.VotingStationTypes,
				CDM.NewWardIDs AS FK2_NewWardIDs,
				CDM.CommunityIDs AS FK8_CommunityIDs
		INTO RegularSpecialVotingStation_Result
		FROM VotingStationName AS VSN 
FULL OUTER JOIN VotingStationType AS VST
		ON VST.PK_VotingStationTypeIDs = VSN.FK1_VotingStationTypeIDs
FULL OUTER JOIN CommunityDataMaster AS CDM
		ON CDM.VotingStationIDs = VSN.PK_VotingStationIDs;

ALTER TABLE RegularSpecialVotingStation_Result
ADD PK_VotingStationResultIDs SMALLINT IDENTITY (1,1);


--POPULATE TABLES--

--Input Values Into PoliticalScale table--

INSERT INTO PoliticalScale
VALUES (1, 'Left'),
       (2, 'Center'),
       (3, 'Right');

	   
--CONSTRAINTS--

--Add NOT NULL Constraint--

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

ALTER TABLE VoteCounts
ADD CONSTRAINT PK_VotingStationCandidateIDs PRIMARY KEY (PK_VotingStationCandidateIDs);

ALTER TABLE OfficeType
ADD CONSTRAINT PK_OfficeTypeIDs PRIMARY KEY ( PK_OfficeTypeIDs);

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

ALTER TABLE AgeGroup
ADD CONSTRAINT FK4_CommunityIDs FOREIGN KEY (FK4_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE MedianIncome
ADD CONSTRAINT FK1_CommunityIDs FOREIGN KEY (FK1_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE Citizenship
ADD CONSTRAINT FK2_CommunityIDs FOREIGN KEY (FK2_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE Family
ADD CONSTRAINT FK3_CommunityIDs FOREIGN KEY (FK3_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE HomeOwnership
ADD CONSTRAINT FK5_CommunityIDs FOREIGN KEY (FK5_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE Gender
ADD CONSTRAINT FK6_CommunityIDs FOREIGN KEY (FK6_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);

ALTER TABLE WardChange
ADD CONSTRAINT FK_NewWardIDs FOREIGN KEY (FK_NewWardIDs)
REFERENCES NewWard (PK_NewWardIDs);

ALTER TABLE VotingStationName
ADD CONSTRAINT FK1_VotingStationTypeIDs FOREIGN KEY (FK1_VotingStationTypeIDs)
REFERENCES VotingStationType (PK_VotingStationTypeIDs);

ALTER TABLE VoteCounts 
ADD CONSTRAINT FK2_VotingStationIDs FOREIGN KEY (FK2_VotingStationIDs)
REFERENCES VotingStationName (PK_VotingStationIDs);

ALTER TABLE VoteCounts 
ADD CONSTRAINT FK2_CandidateIDs FOREIGN KEY (FK2_CandidateIDs)
REFERENCES CandidateName (PK_CandidateIDs);

ALTER TABLE CandidateType
ADD CONSTRAINT FK1_CandidateIDs FOREIGN KEY (FK1_CandidateIDs)
REFERENCES CandidateName (PK_CandidateIDs);

ALTER TABLE VoterInformation
ADD CONSTRAINT FK3_VotingStationIDs FOREIGN KEY (FK3_VotingStationIDs)
REFERENCES VotingStationName (PK_VotingStationIDs);

ALTER TABLE Candidate_Result
ADD CONSTRAINT FK3_NewWardIDs FOREIGN KEY (FK3_NewWardIDs)
REFERENCES NewWard (PK_NewWardIDs);

ALTER TABLE Candidate_Result
ADD CONSTRAINT FK_OfficeTypeIDs FOREIGN KEY (FK_OfficeTypeIDs)
REFERENCES OfficeType (PK_OfficeTypeIDs);

ALTER TABLE RegularSpecialVotingStation_Result
ADD CONSTRAINT FK2_NewWardIDs FOREIGN KEY (FK2_NewWardIDs)
REFERENCES NewWard (PK_NewWardIDs);

ALTER TABLE RegularSpecialVotingStation_Result
ADD CONSTRAINT FK8_CommunityIDs FOREIGN KEY (FK8_CommunityIDs)
REFERENCES CommunityInformation (PK_CommunityIDs);


--FOLLOWING CODES ARE NOT PART OF THE DATABASE DESIGN AND ARE WRITTEN TO REVIEW TABLES ONLY--

--SELECT Statements--

SELECT * FROM CommunityInformation;
SELECT * FROM AgeGroup;
SELECT * FROM MedianIncome;
SELECT * FROM Citizenship;
SELECT * FROM Family;
SELECT * FROM HomeOwnership;
SELECT * FROM Gender;
SELECT * FROM NewWard;
SELECT * FROM WardChange;
SELECT * FROM VotingStationType;
SELECT * FROM VotingStationName;
SELECT * FROM VoteCounts;
SELECT * FROM OfficeType;
SELECT * FROM CandidateType;
SELECT * FROM CandidateName;
SELECT * FROM PoliticalScale;
SELECT * FROM VoterInformation;
SELECT * FROM Candidate_Result;
SELECT * FROM RegularSpecialVotingStation_Result;
SELECT * FROM CommunityDataMaster;
SELECT * FROM VotingCandidateDataMaster;

--DROP tables--

DROP TABLE CommunityInformation;
DROP TABLE AgeGroup;
DROP TABLE MedianIncome;
DROP TABLE Citizenship;
DROP TABLE Family;
DROP TABLE HomeOwnership;
DROP TABLE Gender;
DROP TABLE NewWard;
DROP TABLE WardChange;
DROP TABLE VotingStationType;
DROP TABLE VotingStationName;
DROP TABLE VoteCounts;
DROP TABLE OfficeType;
DROP TABLE CandidateType;
DROP TABLE CandidateName;
DROP TABLE PoliticalScale;
DROP TABLE Candidate_Result;
DROP TABLE VoterInformation;
DROP TABLE RegularSpecialVotingStation_Result;
DROP TABLE CommunityDataMaster;
DROP TABLE VotingCandidateDataMaster;