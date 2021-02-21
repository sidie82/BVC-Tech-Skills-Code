USE WeVotePhase2;
BEGIN TRAN;
UPDATE NewWard SET PK_NewWardIDs=-1
WHERE PK_NewWardIDs=1;
ROLLBACK;

BEGIN TRAN;
UPDATE WardChange SET OldWardIDs=-1,FK2_NewWardIDs=-1
WHERE PK_WardChangeIDs=1;
ROLLBACK;

BEGIN TRAN;
UPDATE OfficeType SET PK_OfficeTypeIDs=-1
WHERE PK_OfficeTypeIDs=10;
ROLLBACK;

BEGIN TRAN;
UPDATE CommunityInformation SET CommunityPopulations=-1
WHERE PK_CommunityIDs=1;
ROLLBACK;

BEGIN TRAN;
UPDATE RegularSpecialVotingStation_Result SET VotingStationIDs=-1,VotingStationTypes=-1
WHERE PK_VotingStationResultIDs=1;
SELECT *
FROM RegularSpecialVotingStation_Result
WHERE PK_VotingStationResultIDs=1;
ROLLBACK;

BEGIN TRAN;
UPDATE Candidate_Result SET CandidateIDs=-1,FK3_NewWardIDs=-1,FK_OfficeTypeIDs=-1
WHERE PK_CandidateResultIDs=1;
SELECT *
FROM Candidate_Result
WHERE PK_CandidateResultIDs=1;
ROLLBACK;

