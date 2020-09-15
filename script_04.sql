/*******************************************
Minutos que los usuarios pasaron en la 
plataforma por día
*******************************************/

select 
    lp.last_name,
    lp.first_name,
    lp.stage:user_id,
    round(sum(duration_sum)/60,0) as duration_minutes
from cdm_lms.session_activity lsa 
inner join cdm_lms.person lp
    on lp.id = lsa.person_id
where
YEAR(first_accessed_time) = 2020 and
MONTH(first_accessed_time) = 09 and
DAY(first_accessed_time) = 10
group by
    lp.last_name, 
    lp.first_name, 
    lp.stage:user_id