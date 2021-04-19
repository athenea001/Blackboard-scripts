select
    distinct lc.stage:batch_uid::string as COURSE_NUMBER,
    lc.name as COURSE_NAME,
    lc.course_number,
    lp.stage:batch_uid::string as ID,
    lp.stage:user_id::string as USER_ID,
    concat(lp.first_name, ' ', lp.last_name) as PERSON_NAME
from cdm_lms.course lc  
inner join cdm_lms.person_course lpc
    on lpc.course_id = lc.id
inner join cdm_lms.person lp
    on lp.id = lpc.person_id
where lc.course_number in ('202125_20638',
'202125_20657',
'202125_20671',
'202125_20676')
order by 1,4
