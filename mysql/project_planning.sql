/*
Enter your query here.
*/

set @n:=0;
set @last_ci:='';

select p1.start_date,ifnull(p1.end_date,p2.end_date) from (  
  select MIN(p01.start_date) as start_date,
  (CASE WHEN MAX(p4.end_date)>MIN(p4.end_date) THEN MAX(p4.end_date)  END) as end_date
  ,g from 
   ( select  end_date,CASE WHEN start_date =@last_ci+INTERVAL 1 DAY THEN @n ELSE @n:=@n+1 END AS g,
    
    @last_ci := start_date As start_date from 
projects p, (SELECT @n:=0) r
    ORDER BY
    start_date
   ) p01 left join projects p4 on p4.start_date =p01.start_date
    group  by g
    )p1 left join projects p2 on p2.start_date = p1.start_date
    order by datediff(ifnull(p1.end_date,p2.end_date),p1.start_date),p1.start_date;
   
    