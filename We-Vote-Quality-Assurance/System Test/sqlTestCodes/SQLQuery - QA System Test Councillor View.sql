USE WeVotePhase2
--Test Councillor view 
SELECT DISTINCT CandidateIDs -- 76 rows
FROM Candidate_Result
WHERE FK_OfficeTypeIDs=20;
--Expected Result: Calculation 76 councillor * number of voting stations where councillors are voted
--Actual Result
SELECT * -- 2646 rows
FROM CouncillorResult2017_vw;


SELECT * FROM TestCandidate_Result_vw;

SELECT DISTINCT a.CandidateNames,
		a.OfficeTypes,
		a.CandidateTypes,
		e.FK1_NewWardIDs,	
		f.OldWardIDs,
		c.VotingStationIDs,
		c.VotingStationNames,
		c.VotingStationTypes,
		e.CommunityNames,
		b.VoteCounts,
		d.EnumeratedElectorsNumbers,
		d.VoterTurnouts
FROM TestCandidate_Result_vw a 
INNER JOIN VoteCount b ON a.CandidateIDs=b.FK_CandidateIDs 
INNER JOIN RegularSpecialVotingStation_Result_vw c ON b.FK2_VotingStationIDs=c.VotingStationIDs 
INNER JOIN VoterInformation d ON c.VotingStationIDs=d.FK1_VotingStationIDs 
INNER JOIN CommunityInformation e ON c.CommunityIDs=e.PK_CommunityIDs
INNER JOIN Ward f ON e.FK1_NewWardIDs=f.NewWardIDs
WHERE a.OfficeTypes='Mayor';


SELECT *
FROM Ward;

CREATE VIEW TestCandidate_Result_vw AS (
SELECT	a.CandidateIDs,
		a.CandidateNames,
		a.FK_OfficeTypeIDs,
		c.OfficeTypes,
		d.PK_CandidateTypeIDs,
		a.CandidateTypes,
		a.FK3_NewWardIDs AS NewWardIDs
FROM Candidate_Result a
INNER JOIN CandidateName b ON a.CandidateIDs=b.PK_CandidateIDs
INNER JOIN OfficeType c ON a.FK_OfficeTypeIDs=c.PK_OfficeTypeIDs
INNER JOIN CandidateType d ON a.CandidateTypes=d.CandidateTypes);
DROP VIEW TestCandidate_Result_vw;