/*******************************************
Minutos que los usuarios pasaron en la 
plataforma por día
*******************************************/

select 
    lp.last_name,
    lp.first_name,
    lp.stage:user_id::string as PERSON_ID,
    round(sum(duration_sum)/60,0) as DURATION_MINUTES
from cdm_lms.session_activity lsa 
inner join cdm_lms.person lp
    on lp.id = lsa.person_id
where
YEAR(first_accessed_time)   = 2021  and     --AÑO
MONTH(first_accessed_time)  = 02    and     --MES
DAY(first_accessed_time)    = 03            --DÍA
group by
    lp.last_name, 
    lp.first_name, 
    lp.stage:user_id