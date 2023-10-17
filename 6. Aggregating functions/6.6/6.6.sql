SELECT w.planet, w.political_system, 
rank() OVER (PARTITION BY w.political_system ORDER BY flights DESC),
rank() OVER (ORDER BY flights DESC)
FROM (SELECT p.name AS planet, ps.value AS political_system, COUNT(*) AS flights 
    FROM Flight f RIGHT JOIN Planet p ON f.planet_id = p.id
    JOIN PoliticalSystem ps ON p.psystem_id = ps.id
    GROUP BY p.name, ps.value
) w;