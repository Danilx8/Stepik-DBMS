WITH RECURSIVE dtf AS (
  SELECT k.id AS id, ARRAY(SELECT sub_k.parent_id FROM Keyword sub_k WHERE k.id = sub_k.id) AS parents
  FROM Keyword k 
  WHERE k.parent_id is NULL
  
  UNION ALL 
  
  SELECT k.id AS id, array_append(sub_k.parents, k.parent_id) 
  FROM Keyword k join dtf AS sub_k ON k.parent_id = sub_k.id
  )
  
SELECT d.id, (SELECT COUNT(*) + 1 FROM dtf AS sub_d WHERE d.id = ANY(sub_d.parents)) AS subtree_size
	FROM dtf AS d;