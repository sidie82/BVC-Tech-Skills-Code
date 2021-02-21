--Citizenship--

SELECT * FROM Citizenship

--Validate if records can be inserted into current PK---

BEGIN TRAN;
INSERT INTO Citizenship (PK_CitizenshipIDs, FK2_CommunityIDs)
VALUES (1, 1);
ROLLBACK;

--Validate if records can be updated using current PK--

BEGIN TRAN;
UPDATE Citizenship
SET PK_CitizenshipIDs = 2
WHERE PK_CitizenshipIDs = 1;
ROLLBACK;


--Validate if non-existent record can be retrieved--

SELECT * FROM Citizenship
WHERE PK_CitizenshipIDs = 199;


--Validate if Primary Key not related to other and with Foreign Key--

BEGIN TRAN;
DELETE FROM Citizenship
WHERE PK_CitizenshipIDs = 1;

--Insert row using current FK = 1
INSERT INTO Citizenship(FK2_CommunityIDs)
VALUES (199);

--Update row using current FK = 1
UPDATE Citizenship
SET FK2_CommunityIDs = 1
WHERE FK2_CommunityIDs = 2
SELECT * FROM Citizenship
WHERE PK_CitizenshipIDs = 2 OR FK2_CommunityIDs = 199 OR FK2_CommunityIDs = 1
ROLLBACK;


SET IDENTITY_INSERT CandidateName ON;
SET IDENTITY_INSERT CandidateName OFF;


--Validate PK not null constraint--

BEGIN TRAN;
INSERT INTO Citizenship(FK2_CommunityIDs, PK_CitizenshipIDs)
VALUES (1, 1)
ROLLBACK;

 --Validate if a null PK can be updated --

BEGIN TRAN;
UPDATE Citizenship
SET PK_CitizenshipIDs = NULL
WHERE PK_CitizenshipIDs = 1;
ROLLBACK;

--Validate: CandidateName >	CHECK constraint> When: Negative value is entereD in number and percent>	Then:Insert nor update is not allowed

BEGIN TRAN;
UPDATE Citizenship
SET CitizenNumbers = -1
WHERE PK_CitizenshipIDs = 1;
UPDATE Citizenship
SET CitizenPercents = -2
WHERE PK_CitizenshipIDs = 1;
UPDATE Citizenship
SET NonCitizenNumbers =-3
WHERE PK_CitizenshipIDs = 1;
UPDATE Citizenship
SET NonCitizenPercents = -4
WHERE PK_CitizenshipIDs = 1;
ROLLBACK;