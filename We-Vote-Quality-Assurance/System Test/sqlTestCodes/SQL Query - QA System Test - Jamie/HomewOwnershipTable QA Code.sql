USE WeVote;

SELECT * FROM HomeOwnership;

-- determine if records can be inserted into existing PK --

BEGIN TRAN;

INSERT INTO HomeOwnership (FK5_CommunityIDs, PK_HomeOwnershipIDs)
VALUES (3, 3);

ROLLBACK;

-- determine if record can be updated using an existing PK --

BEGIN TRAN;

UPDATE HomeOwnership
SET PK_HomeOwnershipIDs = 8
WHERE PK_HomeOwnershipIDs = 3;

ROLLBACK;

-- determine if a non-existant record can be retrieved --

SELECT * FROM HomeOwnership
WHERE PK_HomeOwnershipIDs = 623;

-- determine if new record can be inserted into non-existent PK --

BEGIN TRAN;

INSERT INTO HomeOwnership (FK5_CommunityIDs, PK_HomeOwnershipIDs)
VALUES (222, 222);

-- determine if a null PK value can be inserted into table with Identity Insert on --

SET IDENTITY_INSERT HomeOwnership ON;
SET IDENTITY_INSERT HomeOwnership OFF;

BEGIN TRAN;

INSERT INTO HomeOwnership (FK5_CommunityIDs, PK_HomeOwnershipIDs)
VALUES (100, NULL);

ROLLBACK;

-- determine if a null PK value can be update into existing record with Identity Insert on --

SET IDENTITY_INSERT HomeOwnership ON;
SET IDENTITY_INSERT HomeOwnership OFF;

BEGIN TRAN;

UPDATE HomeOwnership
SET PK_HomeOwnershipIDs = NULL
WHERE PK_HomeOwnershipIDs = 3;

ROLLBACK;

-- determine if negative values can be inserted into any non-key field --

BEGIN TRAN;

UPDATE HomeOwnership
SET HomeOwnersNumbers = -1
WHERE PK_HomeOwnershipIDs = 1;
UPDATE HomeOwnership
SET HomeOwnersPercents = -2
WHERE PK_HomeOwnershipIDs = 1;
UPDATE HomeOwnership
SET RentersNumbers = -3
WHERE PK_HomeOwnershipIDs = 1;
UPDATE HomeOwnership
SET RentersPercents = -4
WHERE PK_HomeOwnershipIDs = 1;

ROLLBACK;
