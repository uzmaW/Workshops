/*SELECT DISTINCT LEAST(field1, field2), GREATEST(field1, field2)
FROM   t*/

  SELECT f.X,f.Y    
    FROM Functions f  JOIN Functions f1 ON f.X=f1.Y AND f.Y = f1.X
    GROUP BY f.x, f.y
    having count(f.x) > 1 or f.x<f.y
    ORDER BY f.X, f.Y;
