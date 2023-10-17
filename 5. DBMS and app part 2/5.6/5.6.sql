SELECT C.name, CE.year, R.total_papers, (R.accepted_papers::NUMERIC  / R.total_papers::NUMERIC )::NUMERIC(3,2) AS acceptance_ratio
FROM Conference C  
JOIN ConferenceEvent CE ON CE.conference_id = C.id
JOIN (
    SELECT P.event_id AS event_id, SUM(P.accepted::INT) AS accepted_papers, COUNT(*) AS total_papers
    FROM Paper P
    GROUP BY event_id) R ON CE.id = R.event_id
WHERE R.total_papers > 5 
AND (R.accepted_papers::NUMERIC/ R.total_papers::NUMERIC)::NUMERIC(3,2)  > 0.75;