SELECT MAX(e.number)::BIGINT + COUNT(e) 
FROM (
	SELECT p.id, COUNT(*) number 
	FROM Planet p 
	JOIN Flight f ON f.planet_id = p.id
        WHERE p.galaxy = 2
    	GROUP BY p.id) e;
