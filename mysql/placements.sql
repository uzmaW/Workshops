SELECT name FROM (
SELECT f.ID,
         s_n.name,
          ROUND(CAST(p.Salary AS DECIMAL(10,2)),2) as candidate_sal,
          f.Friend_ID , ROUND(CAST(p1.Salary AS DECIMAL(10,2)),2) as friend_sal
          FROM Friends f
LEFT JOIN Packages p on p.ID = f.ID
LEFT JOIN Packages p1 on p1.ID = f.Friend_ID
LEFT JOIN  Students s_n on s_n.ID = f.ID
    ) s
WHERE candidate_sal <friend_sal                
ORDER BY friend_sal;
