USE WeVote3;

INSERT INTO CandidateName
VALUES	(201,'Dup1',1),
		(202,'Dup1',2),
		(203,'Dup1',1)

SELECT *
FROM CandidateName;

exec spFindDuplicates_SelectOneColumn CandidateName,CandidateNames

exec spFindDuplicates_SelectTwoColumns CandidateName,FK_CandidateTypeIDs,CandidateNames

SELECT *
FROM CandidateName;

exec spDeleteDuplicates_SelectOneColumn CandidateName,CandidateNames

SELECT *
FROM CandidateName;

exec spDeleteDuplicates_SelectTwoColumns CandidateName,FK_CandidateTypeIDs,CandidateNames

SELECT *
FROM CandidateName;



