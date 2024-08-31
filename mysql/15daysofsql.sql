/*
Enter your query here.
*/
SELECT submission_date, hacker_submission_now,s_all.hacker_id,name FROM (
SELECT submission_date, hacker_submission_now,hacker_id,row_number FROM (
SELECT submission_date, hacker_id, hacker_submission_now,
        CASE
            WHEN @prev_date = submission_date THEN @row_number := @row_number + 1
            ELSE @row_number := 1
        END AS row_number,
        @prev_date := submission_date

FROM (
    SELECT ss1.submission_date, ss1.hacker_id, f0.hacker_submission_now, 
    ss1.day_submission_cnt
    FROM (
        SELECT submission_date, hacker_id, COUNT(hacker_id) AS day_submission_cnt
        FROM submissions
        GROUP BY submission_date, hacker_id
    ) AS ss1
    LEFT JOIN (
        SELECT submission_date,
        SUM(IF(hacker_submission_now = DAY(submission_date), 1, 0)) AS hacker_submission_now
        FROM (
            SELECT s.submission_date, s2.hacker_id, COUNT(s2.hacker_id) AS hacker_submission_now
            FROM (
                SELECT DISTINCT submission_date, hacker_id
                FROM submissions
                GROUP BY submission_date, hacker_id
            ) s
            LEFT JOIN (
                SELECT DISTINCT hacker_id, submission_date
                FROM submissions
            ) s2 ON s2.submission_date <= s.submission_date AND s2.hacker_id = s.hacker_id
            GROUP BY s.submission_date, s.hacker_id
            ORDER BY s.submission_date, s2.hacker_id ASC
        ) s_f
        GROUP BY submission_date
    ) f0 ON f0.submission_date = ss1.submission_date 
        ORDER BY submission_date, day_submission_cnt DESC, hacker_submission_now DESC, hacker_id
) l
CROSS JOIN (SELECT @row_number := 0, @prev_date := NULL) AS vars

ORDER BY submission_date, day_submission_cnt DESC, hacker_submission_now DESC, hacker_id
) last_l 
where row_number=1
order by submission_date
    ) s_all left join Hackers h on h.hacker_id = s_all.hacker_id  order by submission_date