select 
    lp.last_name,
    lp.first_name,
    lp.stage:user_id::string as PERSON_ID,
    first_accessed_time
from cdm_lms.session_activity lsa 
inner join cdm_lms.person lp
    on lp.id = lsa.person_id
where
 lp.stage:user_id = '100531580'
group by
    lp.last_name, 
    lp.first_name,
    lp.stage:user_id,
    first_accessed_time