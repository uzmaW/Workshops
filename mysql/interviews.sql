/*
Enter your query here.
*/
select c.contest_id,c.hacker_id,c.name,
IFNULL(sum(ss.total_submissions_1),0) as total_submissions,IFNULL(sum(ss.total_accepted_submissions_1),0)
as total_accepted_submissions,
IFNULL(sum(vs.total_views_1),0) as total_views,IFNULL(sum(vs.total_unique_views_1),0) as total_unique_views
from Contests c
left join Colleges cl on cl.contest_id=c.contest_id 
left join Challenges chal on chal.college_id = cl.college_id
left join (
    select sum(total_views) as total_views_1, sum(total_unique_views) as total_unique_views_1,challenge_id from View_Stats group by challenge_id
) vs on vs.challenge_id = chal.challenge_id
left join (
    select sum(total_submissions) as total_submissions_1,sum(total_accepted_submissions) as total_accepted_submissions_1,challenge_id from Submission_Stats group by challenge_id
) ss on ss.challenge_id = chal.challenge_id
group by c.contest_id,c.hacker_id,c.name
having total_views>0 AND total_unique_views>0 AND total_submissions>0 AND total_accepted_submissions>0 
order by c.contest_id