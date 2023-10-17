SELECT conference 
FROM Paper 
WHERE NOT EXISTS(
	SELECT 1 
	FROM conference 
	WHERE Paper.conference = conference.value)
UNION
SELECT Counts.conference 
FROM (
	SELECT Paper.conference AS conference, COUNT(*) AS amount 
	FROM Paper 
	GROUP BY conference 
	HAVING COUNT(DISTINCT location) > 1) AS Counts;