USE WeVote;

-- Determine if columns have correct number of distinct entities --

SELECT
COUNT (DISTINCT CandidateIDs) AS "Number of Candidate IDs",
COUNT (DISTINCT FK3_NewWardIDs) AS "Number of New Ward IDs",
COUNT (DISTINCT FK_OfficeTypeIDs) AS "Number of Office Type IDs",
COUNT (DISTINCT PK_CandidateResultIDs) AS "Number of Primary Keys"
FROM Candidate_Result;

-- Determine if entire table can be deleted --

BEGIN TRAN;

DROP TABLE Candidate_Result;

ROLLBACK;

-- Determine if possible to select field when invalid CandidateID in condition --

SELECT * FROM Candidate_Result
WHERE CandidateIDs = 1311;

-- Determine if possible to insert a value into to an existing PK field --

BEGIN TRAN;

INSERT INTO Candidate_Result (PK_CandidateResultIDs)
VALUES (2);

ROLLBACK;


BEGIN TRAN;

DELETE TOP(1) FROM CommunityInformation;

ROLLBACK;




