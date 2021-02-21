


USE WeVotePhase2
SELECT * --292 rows
FROM RegularSpecialVotingStation_Result;
SELECT *
FROM RegularSpecialVotingStation_Result_vw;

--Test Mayor view
--Actual Result 
SELECT * -- 5240 rows
FROM MayorResult2017_vw;

SELECT DISTINCT CR.CandidateNames,
				CR.CandidateTypes,
				OT.OfficeTypes,
				VC.VoteCounts,
				RSVSR.VotingStationIDs, RSVSR.VotingStationNames, RSVSR.VotingStationTypes,
				VI.EnumeratedElectorsNumbers, VI.VoterTurnouts,
				CI.CommunityNames 
-- WC.OldWardIDs, NW.PK_NewWardIDs AS NewWardIDs, 
FROM  dbo.Candidate_Result AS CR INNER JOIN
         dbo.OfficeType AS OT ON CR.FK_OfficeTypeIDs = OT.PK_OfficeTypeIDs INNER JOIN -- 10 rows
         dbo.VoteCount AS VC ON VC.FK_CandidateIDs = CR.CandidateIDs INNER JOIN -- 554 rows
         dbo.RegularSpecialVotingStation_Result AS RSVSR ON RSVSR.VotingStationIDs = VC.FK2_VotingStationIDs INNER JOIN --2340 rows
         dbo.VoterInformation AS VI ON VI.FK1_VotingStationIDs = RSVSR.VotingStationIDs INNER JOIN --2340 rows
         dbo.CommunityInformation AS CI ON CI.PK_CommunityIDs = RSVSR.FK7_CommunityIDs INNER JOIN --2920 rows
         dbo.NewWard AS NW ON NW.PK_NewWardIDs = CI.FK1_NewWardIDs --INNER JOIN
--         dbo.WardChange AS WC ON WC.FK2_NewWardIDs = NW.PK_NewWardIDs
WHERE (OT.OfficeTypes = 'Mayor')
USE WeVotePhase2;
--Expected Result 10*234++
SELECT DISTINCT CandidateIDs, 
				CandidateNames, 
				CandidateTypes, 
				OfficeTypeIDs,
				b.VoteCounts,
				e.FK1_NewWardIDs,
				g.OldWardIDs,
				c.CommunityIDs,
				b.FK2_VotingStationIDs,
				c.VotingStationNames,
				c.VotingStationTypes,
				d.EnumeratedElectorsNumbers,
				d.VoterTurnouts,
				e.CommunityNames			
FROM Candidate_Result_vw 
INNER JOIN VoteCount b ON CandidateIDs=b.FK_CandidateIDs
INNER JOIN RegularSpecialVotingStation_Result_vw c ON b.FK2_VotingStationIDs=c.VotingStationIDs
INNER JOIN VoterInformation d ON b.FK2_VotingStationIDs=d.FK1_VotingStationIDs
INNER JOIN CommunityInformation e ON c.CommunityIDs=e.PK_CommunityIDs --WHERE OfficeTypeIDs=10
--ORDER BY CandidateIDs, FK2_VotingStationIDs ASC;
INNER JOIN NewWard f ON e.FK1_NewWardIDs=f.PK_NewWardIDs
LEFT JOIN WardChange g ON e.FK1_NewWardIDs=g.FK2_NewWardIDs
WHERE OfficeTypeIDs=10 AND f.PK_NewWardIDs=2;

SELECT DISTINCT *
FROM NewWard
LEFT JOIN WardChange ON PK_NewWardIDs=FK2_NewWardIDs;