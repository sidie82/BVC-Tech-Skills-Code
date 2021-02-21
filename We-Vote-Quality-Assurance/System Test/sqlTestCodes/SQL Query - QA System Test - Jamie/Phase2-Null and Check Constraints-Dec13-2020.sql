USE WeVote

--Create NOT NULL Constraint--

-- NOT NULL Constraint for OfficeType -- 

ALTER TABLE OfficeType
ALTER COLUMN OfficeTypes VARCHAR (25) NOT NULL;


-- NOT NULL Constraint for CandidateName--

ALTER TABLE CandidateName
ALTER COLUMN CandidateNames VARCHAR(30) NOT NULL;

-- NOT NULL Constraint for CommunityInformation --

ALTER TABLE CommunityInformation
ALTER COLUMN PK_CommunityIDs TINYINT NOT NULL;

ALTER TABLE CommunityInformation
ALTER COLUMN CommunityNames VARCHAR(30) NOT NULL;

--Add Check constraint to numeric columns to prohibit negative values--

--AgeGroup Table

ALTER TABLE AgeGroup
ADD CONSTRAINT Age20_29Numbers CHECK (Age20_29Numbers >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age20_29Percents CHECK (Age20_29Percents >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age30_39Numbers CHECK (Age30_39Numbers >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age30_39Percents CHECK (Age30_39Percents >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age40_49Numbers CHECK (Age40_49Numbers >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age40_49Percents CHECK (Age40_49Percents >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age50_59Numbers CHECK (Age50_59Numbers >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age50_59Percents CHECK (Age50_59Percents >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age60_69Numbers CHECK (Age60_69Numbers >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age60_69Percents CHECK (Age60_69Percents >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age70_79Numbers CHECK (Age70_79Numbers >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT Age70_79Percents CHECK (Age70_79Percents >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT AgeMoreThan80Numbers CHECK (AgeMoreThan80Numbers >= 0);

ALTER TABLE AgeGroup
ADD CONSTRAINT AgeMoreThan80Percents CHECK (AgeMoreThan80Percents >= 0);

-- CommunityInformation Table --

ALTER TABLE CommunityInformation
ADD CONSTRAINT CommunityPopulations CHECK (CommunityPopulations >= 0);


-- VoterInformation Table --

ALTER TABLE VoterInformation
ADD CONSTRAINT EnumeratedElectorsNumbers CHECK (EnumeratedElectorsNumbers >= 0);

ALTER TABLE VoterInformation
ADD CONSTRAINT VoterTurnouts CHECK (VoterTurnouts >= 0);

-- Gender Table --

ALTER TABLE Gender
ADD CONSTRAINT FemaleNumbers CHECK (FemaleNumbers >= 0);

ALTER TABLE Gender
ADD CONSTRAINT FemalePercents CHECK (FemalePercents >= 0);

ALTER TABLE Gender
ADD CONSTRAINT MaleNumbers CHECK (MaleNumbers >= 0);

ALTER TABLE Gender
ADD CONSTRAINT MalePercents CHECK (MalePercents >= 0);

-- MedianIncome Table --

ALTER TABLE MedianIncome
ADD CONSTRAINT IncomeLessThan59KNumbers CHECK (IncomeLessThan59KNumbers >= 0);

ALTER TABLE MedianIncome
ADD CONSTRAINT IncomeLessThan59KPercents CHECK (IncomeLessThan59KPercents >= 0);

ALTER TABLE MedianIncome
ADD CONSTRAINT Income60K_999999Numbers CHECK (Income60K_99999Numbers >= 0);

ALTER TABLE MedianIncome
ADD CONSTRAINT Income60K_999999Percents CHECK (Income60K_99999Percents >= 0);

ALTER TABLE MedianIncome
ADD CONSTRAINT Income100K_149999Numbers CHECK (Income100K_149999Numbers >= 0);

ALTER TABLE MedianIncome
ADD CONSTRAINT Income100K_149999Percents CHECK (Income100K_149999Percents >= 0);

ALTER TABLE MedianIncome
ADD CONSTRAINT Income150K_199999Numbers CHECK (Income150K_199999Numbers >= 0);

ALTER TABLE MedianIncome
ADD CONSTRAINT Income150K_199999Percents CHECK (Income150K_199999Percents >= 0);

ALTER TABLE MedianIncome
ADD CONSTRAINT IncomeMoreThan200KNumbers CHECK (IncomeMoreThan200KNumbers >= 0);

ALTER TABLE MedianIncome
ADD CONSTRAINT IncomeMoreThan200KPercents CHECK (IncomeMoreThan200KPercents >= 0);

-- Citizenship Table --

ALTER TABLE Citizenship
ADD CONSTRAINT CitizenNumbers CHECK (CitizenNumbers >= 0);

ALTER TABLE Citizenship
ADD CONSTRAINT CitizenPercents CHECK (CitizenPercents >= 0);

ALTER TABLE Citizenship
ADD CONSTRAINT NonCitizenNumbers CHECK (NonCitizenNumbers >= 0);

ALTER TABLE Citizenship
ADD CONSTRAINT NonCitizenPercents CHECK (NonCitizenPercents >= 0);

-- Family Table --

ALTER TABLE Family
ADD CONSTRAINT FamiliesWChildrenNumbers CHECK (FamiliesWChildrenNumbers >= 0);

ALTER TABLE Family
ADD CONSTRAINT FamiliesWChildrenPercents CHECK (FamiliesWChildrenPercents >= 0);

ALTER TABLE Family
ADD CONSTRAINT FamiliesWOChildrenNumbers CHECK (FamiliesWOChildrenNumbers >= 0);

ALTER TABLE Family
ADD CONSTRAINT FamiliesWOChildrenPercents CHECK (FamiliesWOChildrenPercents >= 0);

-- HomeOwnership Table --

ALTER TABLE HomeOwnership
ADD CONSTRAINT HomeOwnersNumbers CHECK (HomeOwnersNumbers >= 0);

ALTER TABLE HomeOwnership
ADD CONSTRAINT HomeOwnersPercents CHECK (HomeOwnersPercents >= 0);

ALTER TABLE HomeOwnership
ADD CONSTRAINT RentersNumbers CHECK (RentersNumbers >= 0);

ALTER TABLE HomeOwnership
ADD CONSTRAINT RentersPercents CHECK (RentersPercents >= 0);

-- VoteCount Table --

ALTER TABLE VoteCount
ADD CONSTRAINT VoteCounts CHECK (VoteCounts >= 0);