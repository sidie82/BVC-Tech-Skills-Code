--CandidateType--

SELECT * FROM CandidateType


--Validate if records can be inserted into current PK---

BEGIN TRAN;
INSERT INTO CandidateType (PK_CandidateTypeIDs)
VALUES (1);
ROLLBACK;

--Validate if records can be updated using current PK--

BEGIN TRAN;
UPDATE CandidateType
SET PK_CandidateTypeIDs = 2
WHERE PK_CandidateTypeIDs = 1;
ROLLBACK;

--Validate if non-existent record can be retrieved--

SELECT * FROM CandidateType
WHERE PK_CandidateTypeIDs = 5;


--Validate if Primary Key not related to other --

SET IDENTITY_INSERT CandidateType ON;
SET IDENTITY_INSERT CandidateType OFF;

BEGIN TRAN;
DELETE FROM CandidateType
WHERE PK_CandidateTypeIDs = 1;
ROLLBACK;

--Validate PK not null constraint--

BEGIN TRAN;
INSERT INTO CandidateType (PK_CandidateTypeIDs)
VALUES (1)
ROLLBACK;

 --Validate if a null PK can be updated --

BEGIN TRAN;
UPDATE CandidateType
SET PK_CandidateTypeIDs = NULL
WHERE PK_CandidateTypeIDs = 1;
ROLLBACK;

--Validate: CandidateName >	CHECK constraint> When: Negative value is entereD in number and percent>	Then:Insert nor update is not allowed
--NOTE: Just to double check PK--

BEGIN TRAN;
UPDATE CandidateType
SET PK_CandidateTypeIDs = -1
WHERE PK_CandidateTypeIDs = 1;
ROLLBACK;