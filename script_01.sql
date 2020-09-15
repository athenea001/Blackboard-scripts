/*******************************************
Información de los cursos
*******************************************/

SELECT  ID,
        TERM_ID,
        SOURCE_ID,
        NAME,
        COURSE_NUMBER,
        ENABLED_IND,
        ROW_INSERTED_TIME,
        ROW_DELETED_TIME,
        MODIFIED_TIME,
        CREATED_TIME
FROM    "CDM_LMS"."COURSE"
WHERE   COURSE_NUMBER LIKE '202036_%'


SELECT * FROM "CDM_LMS"."COURSE"
WHERE   NAME like '%PRFG 001 - Formacion General Universitaria - Oto20'