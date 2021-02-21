USE WeVotePhase2;
--Test Case: List of all voting stations
SELECT * --234 rows
FROM VotingStationName;
SELECT * --2 rows
FROM VotingStationType;
SELECT * --292 rows
FROM RegularSpecialVotingStation_Result;
SELECT * 
FROM RegularSpecialVotingStation_Result_vw;

CREATE VIEW TestRegularSpecialVotingStation_Result_vw AS(
SELECT	a.VotingStationIDs,
		b.VotingStationNames,
		c.PK_VotingStationTypeIDs,
		c.VotingStationTypes,
		a.FK7_CommunityIDs
FROM RegularSpecialVotingStation_Result a
INNER JOIN VotingStationName b ON a.VotingStationIDs=b.PK_VotingStationIDs
INNER JOIN VotingStationType AS c ON a.VotingStationTypes=c.VotingStationTypes);
DROP VIEW TestRegularSpecialVotingStation_Result_vw;


SELECT * 
FROM RegularSpecialVotingStation_Result_vw;
SELECT *
FROM TestRegularSpecialVotingStation_Result_vw;
