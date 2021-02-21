USE WeVote;

DROP VIEW CommunityDemographics2017Number_vw
DROP VIEW CommunityDemographics2017Percent_vw


SELECT * FROM CommunityDemographics2017Number_vw;

-- determine if correct number of distinct records are present based on Community Name --

SELECT COUNT( DISTINCT CommunityNames) as "Unique Communities"
FROM CommunityDemographics2017Number_vw;

-- ensure only Seton has NULL values as per Master Data Table --

SELECT *
FROM CommunityDemographics2017Number_vw
WHERE CommunityPopulations IS NULL;


SELECT * FROM CommunityDemographics2017Percent_vw;

-- determine if correct number of distinct records are present based on Community Name --

SELECT COUNT( DISTINCT CommunityNames) as "Unique Communities"
FROM CommunityDemographics2017Percent_vw;

-- ensure only Seton has NULL values as per Master Data Table --

SELECT *
FROM CommunityDemographics2017Percent_vw
WHERE CommunityPopulations IS NULL;




