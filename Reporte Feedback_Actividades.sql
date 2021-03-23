select  lp.stage:user_id::string as USER_ID,
        concat(lp.first_name, ' ', lp.last_name) as PERSON_NAME,
        lpc.COURSE_ROLE_SOURCE_DESC,
        le.name,
        le.type,
        le.feedback, 
        le.score,
        le.possible_score,
        lc.name,
        lc.course_number
from        CDM_LMS.EVALUATION le
left join   CDM_LMS.person_course lpc
    on      le.person_course_id = lpc.id
left join   CDM_LMS.course lc
    on      lc.id = lpc.course_id
left join   cdm_lms.person lp
    on      lp.id = lpc.person_id    
where       lc.course_number in ('202125_20638',
'202125_20657',
'202125_20671')    
order by 9
