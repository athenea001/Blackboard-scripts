SELECT  ci.name,
        ci.description,
        ci.item_type,
        ci.ROW_INSERTED_TIME,
        ci.ROW_UPDATED_TIME,
        ci.ROW_DELETED_TIME,
        ci.MODIFIED_TIME,
        ci.CREATED_TIME,
        ci.AVAILABLE_START_TIME,
        ci.AVAILABLE_END_TIME,
        COU.ID,
        COU.TERM_ID,
        COU.SOURCE_ID,
        COU.NAME,
        COU.COURSE_NUMBER,
        COU.ENABLED_IND,
        COU.ROW_INSERTED_TIME,
        COU.ROW_DELETED_TIME,
        COU.MODIFIED_TIME,
        COU.CREATED_TIME
from    CDM_LMS.COURSE_ITEM ci,"CDM_LMS"."COURSE" COU   --Tablas
where   CI.item_type = 'ANNOUNCEMENT'                   --Tipo de herramienta
and     CI.NAME lIKE 'Bien%'                            --Nombre
AND     COU.ID = CI.COURSE_ID                           --Join
AND     COU.COURSE_NUMBER LIKE '202125%'                --Periodo

SELECT  ci.name,
        ci.description,
        ci.item_type,
        ci.ROW_INSERTED_TIME,
        ci.ROW_UPDATED_TIME,
        ci.ROW_DELETED_TIME,
        ci.MODIFIED_TIME,
        ci.CREATED_TIME,
        ci.AVAILABLE_START_TIME,
        ci.AVAILABLE_END_TIME,
        COU.ID,
        COU.TERM_ID,
        COU.SOURCE_ID,
        COU.NAME,
        COU.COURSE_NUMBER,
        COU.ENABLED_IND,
        COU.ROW_INSERTED_TIME,
        COU.ROW_DELETED_TIME,
        COU.MODIFIED_TIME,
        COU.CREATED_TIME
from    CDM_LMS.COURSE_ITEM ci,"CDM_LMS"."COURSE" COU   --Tablas
where     CI.NAME lIKE 'Crono%'                    --Nombre
AND       COU.ID = CI.COURSE_ID                    --Join
--AND     COU.COURSE_NUMBER LIKE '202125%'         --Periodo


SELECT  ci.name,
        ci.description,
        ci.item_type,
        ci.ROW_INSERTED_TIME,
        ci.ROW_UPDATED_TIME,
        ci.ROW_DELETED_TIME,
        ci.MODIFIED_TIME,
        ci.CREATED_TIME,
        ci.AVAILABLE_START_TIME,
        ci.AVAILABLE_END_TIME,
        COU.ID,
        COU.TERM_ID,
        COU.SOURCE_ID,
        COU.NAME,
        COU.COURSE_NUMBER,
        COU.ENABLED_IND,
        COU.ROW_INSERTED_TIME,
        COU.ROW_DELETED_TIME,
        COU.MODIFIED_TIME,
        COU.CREATED_TIME
from    CDM_LMS.COURSE_ITEM ci,"CDM_LMS"."COURSE" COU   --Tablas
where   CI.item_type = 'ANNOUNCEMENT'                   --Tipo de herramienta
and     CI.NAME lIKE 'Acti%'                            --Nombre
AND     COU.ID = CI.COURSE_ID                           --Join
--AND     COU.COURSE_NUMBER LIKE '202125%'              --Periodo

SELECT  ci.name,
        ci.description,
        ci.item_type,
        ci.ROW_INSERTED_TIME,
        ci.ROW_UPDATED_TIME,
        ci.ROW_DELETED_TIME,
        ci.MODIFIED_TIME,
        ci.CREATED_TIME,
        ci.AVAILABLE_START_TIME,
        ci.AVAILABLE_END_TIME,
        COU.ID,
        COU.TERM_ID,
        COU.SOURCE_ID,
        COU.NAME,
        COU.COURSE_NUMBER,
        COU.ENABLED_IND,
        COU.ROW_INSERTED_TIME,
        COU.ROW_DELETED_TIME,
        COU.MODIFIED_TIME,
        COU.CREATED_TIME
from    CDM_LMS.COURSE_ITEM ci,"CDM_LMS"."COURSE" COU   --Tablas
where   CI.item_type = 'ANNOUNCEMENT'                   --Tipo de herramienta
and     CI.NAME lIKE 'Cierr%'                           --Nombre
AND     COU.ID = CI.COURSE_ID                           --Join
AND     COU.COURSE_NUMBER LIKE '202125%'                --Periodo
  

SELECT  ci.name,
        ci.description,
        ci.item_type,
        ci.ROW_INSERTED_TIME,
        ci.ROW_UPDATED_TIME,
        ci.ROW_DELETED_TIME,
        ci.MODIFIED_TIME,
        ci.CREATED_TIME,
        ci.AVAILABLE_START_TIME,
        ci.AVAILABLE_END_TIME,
        COU.ID,
        COU.TERM_ID,
        COU.SOURCE_ID,
        COU.NAME,
        COU.COURSE_NUMBER,
        COU.ENABLED_IND,
        COU.ROW_INSERTED_TIME,
        COU.ROW_DELETED_TIME,
        COU.MODIFIED_TIME,
        COU.CREATED_TIME
from    CDM_LMS.COURSE_ITEM ci,"CDM_LMS"."COURSE" COU   --Tablas
where   CI.item_type = 'DISCUSSION_FORUM'               --Tipo de herramienta
--and     CI.NAME lIKE 'Foro de Dudas y Preguntas%'     --Nombre
AND     COU.ID = CI.COURSE_ID                           --Join
AND     COU.COURSE_NUMBER LIKE '202125%'                --Periodo


SELECT  ci.name,
        ci.description,
        ci.item_type,
        ci.ROW_INSERTED_TIME,
        ci.ROW_UPDATED_TIME,
        ci.ROW_DELETED_TIME,
        ci.MODIFIED_TIME,
        ci.CREATED_TIME,
        ci.AVAILABLE_START_TIME,
        ci.AVAILABLE_END_TIME,
        COU.ID,
        COU.TERM_ID,
        COU.SOURCE_ID,
        COU.NAME,
        COU.COURSE_NUMBER,
        COU.ENABLED_IND,
        COU.ROW_INSERTED_TIME,
        COU.ROW_DELETED_TIME,
        COU.MODIFIED_TIME,
        COU.CREATED_TIME
from    CDM_LMS.COURSE_ITEM ci,"CDM_LMS"."COURSE" COU   --Tablas
where   CI.item_type = 'CONTACTS'                       --Tipo de herramienta
--and     CI.NAME lIKE 'Bien%'                          --Nombre
AND     COU.ID = CI.COURSE_ID                           --Join
AND     COU.COURSE_NUMBER LIKE '202125%'                --Periodo


/*Obtener los diferentes tipos de herramientas*/
SELECT  distinct item_type
from    CDM_LMS.COURSE_ITEM
order by 1