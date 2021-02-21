--CandidateName--

SELECT * FROM CandidateName
--Validate if records can be inserted into current PK---

BEGIN TRAN;
INSERT INTO CandidateName (PK_CandidateIDs, FK_CandidateTypeIDs)
VALUES (1, 1);
ROLLBACK;

--Validate if records can be updated using current PK--

BEGIN TRAN;
UPDATE CandidateName
SET PK_CandidateIDs = 2
WHERE PK_CandidateIDs = 1;
ROLLBACK;

--Validate if non-existent record can be retrieved--

SELECT * FROM CandidateName
WHERE PK_CandidateIDs = 132;


--Validate if Primary Key not related to other and with Foreign Key--

BEGIN TRAN;
DELETE FROM CandidateName
WHERE PK_CandidateIDs = 1;

--Insert row using current FK = 1
--Set Identity Insert CandidateName off--
INSERT INTO CandidateName (FK_CandidateTypeIDs)
VALUES (1);

--Update row using current FK = 1
UPDATE CandidateName
SET FK_CandidateTypeIDs = 1
WHERE FK_CandidateTypeIDs = 2
SELECT * FROM CandidateName
WHERE PK_CandidateIDs = 3 OR FK_CandidateTypeIDs = 188 OR FK_CandidateTypeIDs = 1
ROLLBACK;

SET IDENTITY_INSERT CandidateName ON;
SET IDENTITY_INSERT CandidateName OFF;

--Validate PK not null constraint--

BEGIN TRAN;
INSERT INTO CandidateName (FK_CandidateTypeIDs, PK_CandidateIDs)
VALUES (1, 1)
ROLLBACK;

 --Validate if a null PK can be updated --

BEGIN TRAN;
UPDATE CandidateName
SET PK_CandidateIDs = NULL
WHERE PK_CandidateIDs = 1;
ROLLBACK;

--Validate: CandidateName >	CHECK constraint> When: Negative value is entereD in number and percent>	Then:Insert nor update is not allowed
--NOTE: Just to double check PK and FK--

BEGIN TRAN;
UPDATE CandidateName
SET PK_CandidateIDs = -1
WHERE PK_CandidateIDs = 1;
UPDATE CandidateName
SET FK_CandidateTypeIDs = -1
WHERE PK_CandidateIDs = 1;
ROLLBACK;