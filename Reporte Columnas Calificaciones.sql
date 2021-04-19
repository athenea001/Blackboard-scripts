select
    lc.stage:batch_uid::string as COURSE_NUMBER,
    lc.name as COURSE_NAME,
    lc.course_number,
    lp.stage:batch_uid::string as ID,
    lp.stage:user_id::string as USER_ID,
    concat(lp.first_name, ' ', lp.last_name) as PERSON_NAME,
    lp.email,
    lgb.name as ACTIVITY_NAME,
    lci.item_type,
    lgb.final_grade_ind as FINAL_GRADE_IND,
    lgb.used_in_calculations_ind,
    lg.score,
    lg.possible_score,
    lg.normalized_score,
    round(lg.normalized_score*100,2) as PERCENT_SCORE,
    lg.attempted_cnt,
    lg.graded_cnt,
    lg.first_attempted_time,
    lg.first_graded_time
from cdm_lms.grade lg
inner join cdm_lms.gradebook lgb
    on lgb.id = lg.gradebook_id
inner join cdm_lms.person_course lpc
    on lpc.id = lg.person_course_id
inner join cdm_lms.course lc
    on lc.id = lpc.course_id
inner join cdm_lms.person lp
    on lp.id = lpc.person_id
inner join cdm_lms.course_item lci
    on lci.id = lgb.course_item_id
where 
lgb.name like '%Calif%'
--lgb.deleted_ind = 0
/*and   lc.course_number in ('202125_20638',
'202125_20657',
'202125_20671')*/
and   lc.course_number like '202036_%'
--lg.gradebook_id = '4082452'
ORDER BY 3,4
