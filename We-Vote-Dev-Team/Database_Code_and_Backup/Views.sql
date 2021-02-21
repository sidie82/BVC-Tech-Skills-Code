USE WeVote


-- View for Candidate_Result join table --

CREATE VIEW Candidate_Result_vw AS (
	SELECT CR.CandidateIDs,
			CN.CandidateNames,
			CT.PK_CandidateTypeIDs AS CandidateTypeIDs,
			CT.CandidateTypes,
			CR.FK_OfficeTypeIDs AS OfficeTypeIDs,
			OT.OfficeTypes,
			CR.FK3_NewWardIDs AS NewWardIDs
	FROM Candidate_Result AS CR
	INNER JOIN CandidateName AS CN
		ON CR.CandidateIDs = CN.PK_CandidateIDs
	INNER JOIN CandidateType AS CT
		ON CT.PK_CandidateTypeIDs = CN.FK_CandidateTypeIDs
	INNER JOIN OfficeType AS OT
		ON CR.FK_OfficeTypeIDs = OT.PK_OfficeTypeIDs);


-- View for Regular/Special Voting Station Results join Table--

CREATE VIEW RegularSpecialVotingStation_Result_vw AS (
	SELECT  RSVSR.VotingStationIDs, 
		VSN.VotingStationNames,
		VST.PK_VotingStationTypeIDs AS VotingStationTypeIDs,
		VST.VotingStationTypes,
		RSVSR.FK7_CommunityIDs AS CommunityIDs
	FROM RegularSpecialVotingStation_Result AS RSVSR
	INNER JOIN VotingStationName AS VSN
		ON VSN.PK_VotingStationIDs = RSVSR.VotingStationIDs
	INNER JOIN VotingStationType AS VST
		ON VST.PK_VotingStationTypeIDs = VSN.FK_VotingStationTypeIDs);


-- View for Mayor --

CREATE VIEW MayorResult2017_vw AS (
	SELECT DISTINCT CRV.CandidateNames,
			CRV.OfficeTypes,
			CRV.CandidateTypes,
			WC.OldWardIDs,
			CI.FK1_NewWardIDs,
			RSVSRV.VotingStationIDs,
			RSVSRV.VotingStationNames,
			RSVSRV.VotingStationTypes,
			CI.CommunityNames,
			VC.VoteCounts,
			VI.EnumeratedElectorsNumbers,
			VI.VoterTurnouts
	FROM Candidate_Result_vw AS CRV
	INNER JOIN VoteCount AS VC
		ON CRV.CandidateIDs = VC.FK_CandidateIDs
	INNER JOIN RegularSpecialVotingStation_Result_vw AS RSVSRV
		ON RSVSRV.VotingStationIDs = VC.FK2_VotingStationIDs
	INNER JOIN VoterInformation AS VI
		ON VI.FK1_VotingStationIDs = RSVSRV.VotingStationIDs
	INNER JOIN CommunityInformation AS CI
		ON CI.PK_CommunityIDs = RSVSRV.CommunityIDs
	INNER JOIN WardChange AS WC
		ON WC.FK2_NewWardIDs = CI.FK1_NewWardIDs
	WHERE OfficeTypes = 'Mayor');


-- View for Councillor --

CREATE VIEW CouncillorResult2017_vw AS (
	SELECT DISTINCT CRV.CandidateNames,
			CRV.OfficeTypes,
			CRV.CandidateTypes,
			WC.OldWardIDs,
			CI.FK1_NewWardIDs,
			RSVSRV.VotingStationIDs,
			RSVSRV.VotingStationNames,
			RSVSRV.VotingStationTypes,
			CI.CommunityNames,
			VC.VoteCounts,
			VI.EnumeratedElectorsNumbers,
			VI.VoterTurnouts
	FROM Candidate_Result_vw AS CRV
	INNER JOIN VoteCount AS VC
		ON CRV.CandidateIDs = VC.FK_CandidateIDs
	INNER JOIN RegularSpecialVotingStation_Result_vw AS RSVSRV
		ON RSVSRV.VotingStationIDs = VC.FK2_VotingStationIDs
	INNER JOIN VoterInformation AS VI
		ON VI.FK1_VotingStationIDs = RSVSRV.VotingStationIDs
	INNER JOIN CommunityInformation AS CI
		ON CI.PK_CommunityIDs = RSVSRV.CommunityIDs
	INNER JOIN WardChange AS WC
		ON WC.FK2_NewWardIDs = CI.FK1_NewWardIDs
	WHERE OfficeTypes = 'Councillor');

-- View for PublicSchoolTrusteeResult2017 --

CREATE VIEW PublicSchoolTrusteeResult2017_vw AS (
	SELECT DISTINCT CRV.CandidateNames,
			CRV.OfficeTypes,
			CRV.CandidateTypes,
			WC.OldWardIDs,
			CI.FK1_NewWardIDs,
			RSVSRV.VotingStationIDs,
			RSVSRV.VotingStationNames,
			RSVSRV.VotingStationTypes,
			CI.CommunityNames,
			VC.VoteCounts,
			VI.EnumeratedElectorsNumbers,
			VI.VoterTurnouts
	FROM Candidate_Result_vw AS CRV
	INNER JOIN VoteCount AS VC
		ON CRV.CandidateIDs = VC.FK_CandidateIDs
	INNER JOIN RegularSpecialVotingStation_Result_vw AS RSVSRV
		ON RSVSRV.VotingStationIDs = VC.FK2_VotingStationIDs
	INNER JOIN VoterInformation AS VI
		ON VI.FK1_VotingStationIDs = RSVSRV.VotingStationIDs
	INNER JOIN CommunityInformation AS CI
		ON CI.PK_CommunityIDs = RSVSRV.CommunityIDs
	INNER JOIN WardChange AS WC
		ON WC.FK2_NewWardIDs = CI.FK1_NewWardIDs
	WHERE OfficeTypes = 'Public School Trustee');

-- View for Separate School Trustee 2017 --

CREATE VIEW SeparateSchoolTrusteeResult2017_vw AS (
	SELECT DISTINCT CRV.CandidateNames,
			CRV.OfficeTypes,
			CRV.CandidateTypes,
			WC.OldWardIDs,
			CI.FK1_NewWardIDs,
			RSVSRV.VotingStationIDs,
			RSVSRV.VotingStationNames,
			RSVSRV.VotingStationTypes,
			CI.CommunityNames,
			VC.VoteCounts,
			VI.EnumeratedElectorsNumbers,
			VI.VoterTurnouts
	FROM Candidate_Result_vw AS CRV
	INNER JOIN VoteCount AS VC
		ON CRV.CandidateIDs = VC.FK_CandidateIDs
	INNER JOIN RegularSpecialVotingStation_Result_vw AS RSVSRV
		ON RSVSRV.VotingStationIDs = VC.FK2_VotingStationIDs
	INNER JOIN VoterInformation AS VI
		ON VI.FK1_VotingStationIDs = RSVSRV.VotingStationIDs
	INNER JOIN CommunityInformation AS CI
		ON CI.PK_CommunityIDs = RSVSRV.CommunityIDs
	INNER JOIN WardChange AS WC
		ON WC.FK2_NewWardIDs = CI.FK1_NewWardIDs
	WHERE OfficeTypes = 'Separate School Trustee');

-- View for Community Demographics with Number Values --

CREATE VIEW CommunityDemographics2017Number_vw AS (
	SELECT DISTINCT CI.PK_CommunityIDs AS CommunityIDs,
			CI.CommunityNames,
			CI.CommunityPopulations,
			C.CitizenNumbers,
			C.NonCitizenNumbers,
			G.FemaleNumbers,
			G.MaleNumbers,
			AG.Age20_29Numbers,
			AG.Age30_39Numbers,
			AG.Age40_49Numbers,
			AG.Age50_59Numbers,
			AG.Age60_69Numbers,
			AG.Age70_79Numbers,
			AG.AgeMoreThan80Numbers,
			MI.IncomeLessThan59kNumbers,
			MI.Income60K_99999Numbers,
			MI.Income100K_149999Numbers,
			MI.Income150K_199999Numbers,
			MI.IncomeMoreThan200KNumbers,
			F.FamiliesWChildrenNumbers,
			F.FamiliesWOChildrenNUmbers,
			HO.HomeOwnersNumbers,
			HO.RentersNumbers
	FROM CommunityInformation AS CI
	INNER JOIN Citizenship AS C
		ON CI.PK_CommunityIDs = C.FK2_CommunityIDs
	INNER JOIN Gender AS G
		ON CI.PK_CommunityIDs = G.FK6_CommunityIDs
	INNER JOIN AgeGroup AS AG
		ON CI.PK_CommunityIDS = AG.FK4_CommunityIDs
	INNER JOIN MedianIncome AS MI
		ON CI.PK_CommunityIDs = MI.FK1_CommunityIDs
	INNER JOIN Family AS F
		ON CI.PK_CommunityIDs = F.FK3_CommunityIDs
	INNER JOIN HomeOwnership AS HO
		ON CI.PK_CommunityIDs = HO.FK5_CommunityIDs);

-- View of Community Demographics Percentage Values --

CREATE VIEW CommunityDemographics2017Percent_vw AS (
	SELECT DISTINCT CI.PK_CommunityIDs AS CommunityIDs,
			CI.CommunityNames,
			CI.CommunityPopulations,
			C.CitizenPercents,
			C.NonCitizenPercents,
			G.FemalePercents,
			G.MalePercents,
			AG.Age20_29Percents,
			AG.Age30_39Percents,
			AG.Age40_49Percents,
			AG.Age50_59Percents,
			AG.Age60_69Percents,
			AG.Age70_79Percents,
			AG.AgeMoreThan80Percents,
			MI.IncomeLessThan59KPercents,
			MI.Income60K_99999Percents,
			MI.Income100K_149999Percents,
			MI.Income150K_199999Percents,
			MI.IncomeMoreThan200KPercents,
			F.FamiliesWChildrenPercents,
			F.FamiliesWOChildrenPercents,
			HO.HomeOwnersPercents,
			HO.RentersPercents
	FROM CommunityInformation AS CI
	INNER JOIN Citizenship AS C
		ON CI.PK_CommunityIDs = C.FK2_CommunityIDs
	INNER JOIN Gender AS G
		ON CI.PK_CommunityIDs = G.FK6_CommunityIDs
	INNER JOIN AgeGroup AS AG
		ON CI.PK_CommunityIDS = AG.FK4_CommunityIDs
	INNER JOIN MedianIncome AS MI
		ON CI.PK_CommunityIDs = MI.FK1_CommunityIDs
	INNER JOIN Family AS F
		ON CI.PK_CommunityIDs = F.FK3_CommunityIDs
	INNER JOIN HomeOwnership AS HO
		ON CI.PK_CommunityIDs = HO.FK5_CommunityIDs);
