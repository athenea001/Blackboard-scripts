/******************************************
Obtener información de los lineamientos
******************************************/

SELECT  DISTINCT PER.ID,
        PER.SOURCE_ID,
        PER.FIRST_NAME,
        PER.LAST_NAME,
        PER.EMAIL,
        PER.STAGE:batch_uid,
        PER.STAGE:user_id,
        PER.INSTITUTION_ROLE_SOURCE_DESC,
        PER.ROW_INSERTED_TIME,
        PER.CREATED_TIME,
        PER.MODIFIED_TIME,
        PERCOU.ID PER_COUR_ID,
        PERCOU.COURSE_ID    COUR_ID,
        PERCOU.PERSON_ID    PER_ID,
        COU.ID,
        COU.NAME,
        COU.COURSE_NUMBER,
        GRAD.ID,
        GRAD.PERSON_COURSE_ID,
        GRAD.SCORE,
        GRAD.POSSIBLE_SCORE,
        GRAD.LAST_GRADED_TIME,
        GRAD.ATTEMPTED_TIME
FROM        CDM_LMS.PERSON PER
LEFT JOIN   cdm_lms.PERSON_COURSE PERCOU ON
            PER.ID = PERCOU.PERSON_ID
LEFT JOIN   cdm_lms.course COU ON
            COU.ID = PERCOU.COURSE_ID
LEFT JOIN   cdm_lms.grade GRAD ON
            GRAD.PERSON_COURSE_ID = PERCOU.ID            
WHERE       PERCOU.COURSE_ID IN (select ID
                                 from cdm_lms.course cou
                                 where cou.name like 'Lineami%'
                                 and   cou.course_number like '202036_%')            
AND         PER.INSTITUTION_ROLE_SOURCE_DESC LIKE 'preu%' 
ORDER BY    GRAD.SCORE DESC