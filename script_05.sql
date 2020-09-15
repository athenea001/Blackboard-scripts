/*******************************************
Generar registros de usuarios que ingresaron
en las últimas horas 
*******************************************/

select *
from cdm_lms.SESSION_ACTIVITY lsa
inner join cdm_lms.person lp
    on lp.id = lsa.person_id
where FIRST_ACCESSED_TIME >= TO_DATE('03/09/2020','DD/MM/YYYY')
ORDER BY LAST_ACCESSED_TIME DESC  