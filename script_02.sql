/*******************************************
Actividad de Estudiantes 
   - Incluye fecha de primer y último acceso
********************************************/

SELECT  DISTINCT PERSON_ID,
        PER.SOURCE_ID,
        PER.FIRST_NAME,
        PER.LAST_NAME,
        PER.EMAIL,
        PER.STAGE:batch_uid,
        PER.STAGE:user_id,
        PER.INSTITUTION_ROLE_SOURCE_DESC,
        MIN(FIRST_ACCESSED_TIME),
        MAX(LAST_ACCESSED_TIME)
FROM    CDM_LMS.PERSON PER
LEFT    JOIN cdm_lms.ACTIVITY ACT  ON
        PER.ID = PERSON_ID
WHERE   PER.INSTITUTION_ROLE_SOURCE_DESC in ('preuniversitarios_bb','preuniversitarios')
GROUP BY PERSON_ID,
        PER.SOURCE_ID,
        PER.FIRST_NAME,
        PER.LAST_NAME,
        PER.EMAIL,
        PER.STAGE:batch_uid,
        PER.STAGE:user_id,
        PER.INSTITUTION_ROLE_SOURCE_DESC
ORDER BY 10 ASC  