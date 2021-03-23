select
    distinct lc.stage:batch_uid::string as COURSE_NUMBER,
    lc.name as COURSE_NAME,
    lc.course_number,
    lp.stage:batch_uid::string as ID,
    lp.stage:user_id::string as USER_ID,
    concat(lp.first_name, ' ', lp.last_name) as PERSON_NAME,
    lcta.TOOL_SOURCE_ID,
    lcta.INTERACTION_CNT,
    lcta.ROW_INSERTED_TIME
from cdm_lms.course lc  
inner join cdm_lms.person_course lpc
    on lpc.course_id = lc.id
inner join cdm_lms.person lp
    on lp.id = lpc.person_id
inner join CDM_LMS.COURSE_TOOL_ACTIVITY lcta
    on lcta.course_id = lc.id
where lc.course_number in ('202125_20638',
'202125_20657',
'202125_20671')
order by 1,4,7,9
