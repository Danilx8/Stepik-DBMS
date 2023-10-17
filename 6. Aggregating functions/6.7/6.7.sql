WITH DynamicsTable AS (
  SELECT prices.name AS company_name, prices.week AS week, prices.current_price - prices.previous_price AS diff 
  FROM (
    SELECT sq.company AS name, sq.week AS week, 
      lag(sq.share_price) OVER (PARTITION BY sq.company ORDER BY week ASC) AS previous_price, 
      sq.share_price AS current_price
    FROM StockQuotes AS sq) AS prices
)

SELECT rc.company_name, COUNT(case when rc.rowed = 3 then 1 else null end)
FROM (
  SELECT stats.company_name, SUM(stats.is_thriving) OVER (PARTITION BY stats.company_name ROWS 2 PRECEDING) AS rowed
  FROM (
    SELECT DynamicsTable.company_name AS company_name, DynamicsTable.week AS week, CASE
        WHEN DynamicsTable.diff > avg.value
        THEN 1
        ELSE 0
        END AS is_thriving
    FROM (
      SELECT DynamicsTable.week AS week, AVG(DynamicsTable.diff) AS value 
      FROM DynamicsTable
      GROUP BY DynamicsTable.week
      ORDER BY DynamicsTable.week ASC) AS avg LEFT JOIN
      DynamicsTable ON DynamicsTable.week = avg.week) AS stats) rc
GROUP BY rc.company_name;