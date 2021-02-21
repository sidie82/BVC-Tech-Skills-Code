--Gnder--

SELECT * FROM Gender

--Validate if records can be inserted into current PK---

BEGIN TRAN;
INSERT INTO Gender(PK_GenderIDs, FK6_CommunityIDs)
VALUES (1, 1);
ROLLBACK;

--Validate if records can be updated using current PK--

BEGIN TRAN;
UPDATE Gender
SET PK_GenderIDs = 2
WHERE PK_GenderIDs = 1;
ROLLBACK;

--Validate if non-existent record can be retrieved--

SELECT * FROM Gender
WHERE PK_GenderIDs = 199;


--Validate if Primary Key not related to other and with Foreign Key--

BEGIN TRAN;
DELETE FROM Gender
WHERE PK_GenderIDs = 1;

--Insert row using current FK = 1
INSERT INTO Gender(FK6_CommunityIDs)
VALUES (199);

--Update row using current FK = 1
UPDATE Gender
SET FK6_CommunityIDs = 1
WHERE FK6_CommunityIDs = 2
SELECT * FROM Gender
WHERE PK_GenderIDs = 2 OR FK6_CommunityIDs = 199 OR FK6_CommunityIDs = 1
ROLLBACK;


SET IDENTITY_INSERT CandidateName ON;
SET IDENTITY_INSERT CandidateName OFF;


--Validate PK not null constraint--

BEGIN TRAN;
INSERT INTO Gender(FK6_CommunityIDs, PK_GenderIDs)
VALUES (1, 1)
ROLLBACK;



 --Validate if a null PK can be updated --

BEGIN TRAN;
UPDATE Gender
SET PK_GenderIDs = NULL
WHERE PK_GenderIDs = 1;
ROLLBACK;

--Validate: CandidateName >	CHECK constraint> When: Negative value is entereD in number and percent>	Then:Insert nor update is not allowed

BEGIN TRAN;
UPDATE Gender
SET FemaleNumbers = -1
WHERE PK_GenderIDs = 1;
UPDATE Gender
SET FemalePercents = -2
WHERE PK_GenderIDs = 1;
UPDATE Gender
SET MaleNumbers =-3
WHERE PK_GenderIDs = 1;
UPDATE Gender
SET MalePercents = -4
WHERE PK_GenderIDs = 1;
ROLLBACK;