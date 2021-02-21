USE WeVote;

SELECT * FROM Family;

-- determine if records can be inserted into existing PK --

BEGIN TRAN;

INSERT INTO Family (FK3_CommunityIDs, PK_FamilyIDs)
VALUES (5, 5);

ROLLBACK;

-- determine if record can be updated using an existing PK --

BEGIN TRAN;

UPDATE Family
SET PK_FamilyIDs = 5
WHERE PK_FamilyIDs = 4;

ROLLBACK;

-- determine if a non-existant record can be retrieved --

SELECT * FROM Family
WHERE PK_FamilyIDs = 4000;

-- determine if new record can be inserted into non-existent PK --

BEGIN TRAN;

INSERT INTO Family (FK3_CommunityIDs, PK_FamilyIDs)
VALUES (200, 200);

ROLLBACK;

-- determine if a null PK value can be inserted into table with Identity Insert on --

SET IDENTITY_INSERT Family ON;
SET IDENTITY_INSERT Family OFF;

BEGIN TRAN;

INSERT INTO Family (FK3_CommunityIDs, PK_FamilyIDs)
VALUES (100, NULL);

ROLLBACK;

-- determine if a null PK value can be update into existing record with Identity Insert on --

SET IDENTITY_INSERT Family ON;
SET IDENTITY_INSERT Family OFF;

BEGIN TRAN;

UPDATE Family
SET PK_FamilyIDs = NULL
WHERE PK_FamilyIDs = 4;

ROLLBACK;

-- determine if negative values can be inserted into any non-key field --

BEGIN TRAN;

UPDATE Family
SET FamiliesWChildrenNumbers = -1
WHERE PK_FamilyIDs = 1;
UPDATE Family
SET FamiliesWChildrenPercents = -2
WHERE PK_FamilyIDs = 1;
UPDATE Family
SET FamiliesWOChildrenNumbers = -3
WHERE PK_FamilyIDs = 1;
UPDATE Family
SET FamiliesWOChildrenPercents = -4
WHERE PK_FamilyIDs = 1;

ROLLBACK;
