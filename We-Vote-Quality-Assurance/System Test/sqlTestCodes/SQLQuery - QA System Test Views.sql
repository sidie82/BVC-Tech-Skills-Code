USE WeVotePhase2;
SELECT a.*, b.PoliticalLevels
FROM PublicSchoolTrusteeResult2017_vw a
CROSS JOIN PoliticalScale b 
WHERE CandidateNames='Althea Adams' AND PoliticalLevels='Center' ;
SELECT *
FROM VotingCandidateDataMaster
WHERE CandidateNames='Althea Adams';


Create View TestPSTR2017_vw AS (
	SELECT DISTINCT CR.CandidateNames,
			OT.OfficeTypes,
			CR.CandidateTypes,
--			WC.OldWardIDs,
--			NW.PK_NewWardIDs AS NewWardIDs,
			CI.FK1_NewWardIDs,
			RSVSR.VotingStationIDs,
			RSVSR.VotingStationNames,
			RSVSR.VotingStationTypes,
			CI.CommunityNames,
			VC.VoteCounts,
			VI.EnumeratedElectorsNumbers,
			VI.VoterTurnouts
	FROM Candidate_Result AS CR
	INNER JOIN OfficeType AS OT
		ON CR.FK_OfficeTypeIDs = OT.PK_OfficeTypeIDs
	INNER JOIN VoteCount AS VC
		ON VC.FK_CandidateIDs = CR.CandidateIDs
	INNER JOIN RegularSpecialVotingStation_Result AS RSVSR
		ON RSVSR.VotingStationIDs = VC.FK2_VotingStationIDs
	INNER JOIN VoterInformation AS VI
		ON VI.FK1_VotingStationIDs = RSVSR.VotingStationIDs
	INNER JOIN CommunityInformation AS CI
		ON CI.PK_CommunityIDs = RSVSR.FK7_CommunityIDs
--	INNER JOIN NewWard AS NW
--		ON NW.PK_NewWardIDs = CI.FK1_NewWardIDs
--	INNER JOIN WardChange AS WC
--		ON WC.FK2_NewWardIDs = NW.PK_NewWardIDs
	WHERE OfficeTypes='Public School Trustee');
DROP VIEW TestPSTR2017_vw;

SELECT *
FROM TestPSTR2017_vw
WHERE CandidateNames='Althea Adams';
SELECT *
FROM TestVotingStationInCommunity
WHERE VotingStationIDs=408;


