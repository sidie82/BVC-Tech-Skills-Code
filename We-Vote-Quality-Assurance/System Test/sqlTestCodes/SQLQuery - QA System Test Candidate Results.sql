USE WeVotePhase2;
--Test Case: List of all candidates
SELECT * --131 rows
FROM CandidateName;
SELECT *
FROM TestCandidateName;
SELECT *
FROM CandidateType;
SELECT *
FROM OfficeType;
SELECT * -- 369 rows
FROM Candidate_Result;

USE WeVotePhase2;
SELECT *
FROM Candidate_Result;
SELECT * --369 rows
FROM Candidate_Result_vw;

USE WeVotePhase1;
SELECT *
FROM Candidate_Result;
SELECT * --369 rows
FROM TestCandidateResult_vw;

CREATE VIEW TestCandidateResult_vw AS(
SELECT	a.CandidateIDs,
		b.CandidateNames,
		a.FK_OfficeTypeIDs,
		c.OfficeTypes,
		d.CandidateTypeIDs,
		d.CandidateType,
		a.FK3_NewWardIDs AS WardIDs
FROM Candidate_Result a
INNER JOIN CandidateName b ON a.CandidateIDs=b.PK_CandidateIDs
INNER JOIN OfficeType AS c ON a.FK_OfficeTypeIDs=c.PK_OfficeTypeIDs
INNER JOIN TestCandidateType AS d ON (a.Incumbent=d.Incumbent AND a.Acclaimed=d.Acclaimed));
DROP VIEW TestCandidateResult_vw;

CREATE FUNCTION AssignCandidate (	@cName1 varchar(30),@pLevel1 varchar(7),
									@cName2 varchar(30),@pLevel2 varchar(7),
									@cName3 varchar(30),@pLevel3 varchar(7))
RETURNS TABLE
AS
RETURN
   SELECT	b.PoliticalLevels, a.*			
	FROM TestCandidateResult_vw a
	CROSS JOIN PoliticalScale b WHERE	(a.CandidateNames=@cName1 AND b.PoliticalLevels=@pLevel1) OR
										(a.CandidateNames=@cName2 AND b.PoliticalLevels=@pLevel2) OR
										(a.CandidateNames=@cName3 AND b.PoliticalLevels=@pLevel3);
DROP FUNCTION AssignCandidate;

SELECT * FROM AssignCandidate('Andre Chabot','Left',
								'Bill Smith','Center',
								'Brent Chisholm','Right')