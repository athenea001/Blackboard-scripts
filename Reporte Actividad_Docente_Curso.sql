with courses as
 (
select 
    t.id as Term_Surr_Key,
    t.Source_ID as Term_PK1,
    t.name as PERIODO,
    t.Start_Date as FECHA_INICIO,
    t.End_Date as FECHA_FIN,   
    c.id as Course_Surr_Key,
    c.source_id as Course_PK1,
    C.Course_Number as ID_CURSO, 
    C.Name as NOMBRE_CURSO,
    C.Start_Date as Course_Start,
    C.End_Date as Course_End,
    C.Available_Ind as HABILITADO,
    C.Available_to_Students_Ind as HABILITADO_A_ESTUDIANTES,
    case when c.design_mode_source_code = 'U' then 'Ultra' else 'Classic' end as VERSION_BB,
    case when gb.course_id is null then 'No Gradebook' else 'Has Gradebook' end as LIBRO_CALIFICACIONES,
    ifnull(pcc.Instr_Count, 0) as NUMERO_DOCENTES,
    count(ci.id) as TOTAL_ITEMS,
    sum(Case when ci.Item_Group = 'A' then 1 else 0 end) as NUMERO_EVALUACIONES,
    sum(Case when ci.Item_Group = 'C' then 1 else 0 end) as NUMERO_CONTENIDOS,
    sum(Case When ci.Item_Group = 'T' then 1 else 0 end) as NUMERO_HERRAMIENTAS,
    case 
        when  max(case when ci.Item_Type_source_code like '%assign%'then 1 else 0 end) = 1 then 'Has Assignments'
        else 'No Assignments'
    end        
        as EVALUACIONES,
    case 
        when  max(case  when ci.Item_Type_source_code like '%syll%' then 1 else 0 end)  = 1 then 'Has Syllabus'
        else 'No Syllabus'
    end        
        as SYLLABUS
from 
    cdm_lms.course c        
    left join
        cdm_lms.term t
        on  c.term_id = t.id
    left join
        (select 
            pca.course_id,
            count(*) as Instr_Count
         from  CDM_LMS.Person_Course pca
         where pca.Course_Role = 'I'
         group by pca.course_id
        ) as pcc
        on  pcc.course_id = c.id
    left join
        CDM_LMS.Course_Item ci
        on  ci.course_id = c.id
    left join
        (select course_id, 
                count(*) as Gradebook_Item_Count
         from  CDM_LMS.gradebook
        group by course_id) as gb
         on gb.course_id = c.id
where
    C.Course_Number in ('202125_20638',
'202125_20657')
group by 
    t.id,
    t.Source_ID,
    t.name,
    t.Start_Date,
    t.End_Date,   
    c.id,
    c.source_id,
    C.Course_Number,  
    C.Name,
    C.Start_Date,
    C.End_Date,
    C.Available_Ind,
    C.Available_to_Students_Ind,
    c.design_mode_source_code,
    gb.course_id,
    gb.Gradebook_Item_Count,
    pcc.Instr_Count
 ),
 instructor_activity as
 (
 select
    c.Course_Surr_Key,
    pc.Person_ID as Instructor_Surr_Key,
    p.Source_ID as Instructor_PK1,
    concat(p.last_name, ', ', p.first_name) as NOMBRE_DOCENTE,
    p.email as DOCENTE_CORREO,   
    p.stage:user_id::string as ID_BUAP,
    count(ca.id) as NUM_ACCESOS_DOCENTE_AL_CURSO,
    date_trunc('minute', max(ca.LAST_ACCESSED_TIME)) as ULTIMO_ACCESO_DOCENTE_AL_CURSO,
    round(sum(ca.duration_sum/3600),2) as HORAS_ACTIVIDAD_DOCENTE_EN_CURSO
 from
   courses c
   left join
        CDM_LMS.Person_Course pc
        on  pc.course_id = c.Course_Surr_Key and
            pc.Course_Role = 'I'
   left join CDM_LMS.Person P
        on P.ID = PC.Person_ID      
   left join
       CDM_LMS.COURSE_ACTIVITY ca
       on   ca.person_id =  pc.Person_ID and
            ca.course_id =  c.Course_Surr_Key
  group by
    c.Course_Surr_Key,
    pc.Person_ID,
    p.Source_ID,
    concat(p.last_name, ', ', p.first_name),
    p.email,
   p.STAGE:user_id
 ),
 student_activity as
 (
 select
    c.Course_Surr_Key,
    count(distinct pc.id) as NUMERO_ESTUDIANTES,
    count(distinct ca.person_Id) as NUMERO_ESTUDIANTES_ACTIVOS,
    count(ca.id) as TOTAL_ESTUDIANTES_INICIO_SESION,
    date_trunc('minute',max(ca.LAST_ACCESSED_TIME)) as Student_Last_Access,
    round(sum(ca.duration_sum/3600),2) as HORAS_ACTIVIDAD_ESTUDIANTES_EN_CURSO
 from
    courses c
    left join
        CDM_LMS.Person_Course pc
        on  pc.course_id = c.Course_Surr_Key and
            pc.Course_Role = 'S'
    left join 
        CDM_LMS.Person P
        on P.ID = PC.Person_ID     
    left join
        CDM_LMS.Course_Activity ca
        on  ca.person_course_id = pc.id 
  group by
    c.Course_Surr_Key
 ),
 course_rooms as
 (
 select
    cr.lms_course_id,
    ifnull(count(r.id), 0) as collab_room_count
 from 
    cdm_map.course_room cr
    inner join
        cdm_clb.room r
        on  r.id = cr.clb_room_id
 where
    cr.lms_course_id is not null
 group by
    cr.lms_course_id
 ),
 sess as
 (
 select
   cr.lms_course_id,
   count(s.id) as collab_session_count,
   round(sum(s.session_duration)/3600,2) as total_collab_room_use_hours,
   round(sum(s.attended_duration/3600),2) as total_collab_room_attended_hours
 from
    cdm_map.course_room cr
    inner join
        cdm_clb.session s
        on   s.room_id = cr.clb_room_id
 group by
   cr.lms_course_id
 ),
 attend as
 (
 select
   cr.lms_course_id,
   count(distinct a.person_id) as collab_participant_count,
   round(sum(a.duration/3600),2) as total_collab_attendee_hours
 from
    cdm_map.course_room cr
    inner join
        cdm_clb.session s
        on   s.room_id = cr.clb_room_id
     left join
        cdm_clb.attendance a
        on  a.session_id = s.id
 group by
   cr.lms_course_id
 ),
 collab_summary as
 (
 select
    cr.lms_course_id,
    cr.collab_room_count,
    s.collab_session_count,
    s.total_collab_room_use_hours,
    s.total_collab_room_attended_hours, 
    a.collab_participant_count,
    a.total_collab_attendee_hours
 from
    course_rooms cr
    left join
        sess s
        on  s.lms_course_id = cr.lms_course_id
    left join
        attend a
        on  a.lms_course_id = cr.lms_course_id
 )
select 
     courses.Term_PK1,
     courses.PERIODO,
     courses.FECHA_INICIO,
     courses.FECHA_FIN,   
     courses.Course_PK1,
     courses.ID_CURSO,    
     courses.NOMBRE_CURSO,
     courses.HABILITADO,
     courses.HABILITADO_A_ESTUDIANTES,
     courses.VERSION_BB,
     courses.LIBRO_CALIFICACIONES,
     courses.TOTAL_ITEMS,
     courses.NUMERO_EVALUACIONES,
     courses.NUMERO_CONTENIDOS,
     courses.NUMERO_HERRAMIENTAS,
     courses.EVALUACIONES,  
     courses.SYLLABUS,
     courses.NUMERO_DOCENTES,
     ia.Instructor_PK1,
     ia.NOMBRE_DOCENTE,
     ia.DOCENTE_CORREO, 
     ia.ID_BUAP,
     ia.NUM_ACCESOS_DOCENTE_AL_CURSO,
     ia.ULTIMO_ACCESO_DOCENTE_AL_CURSO,
     ia.HORAS_ACTIVIDAD_DOCENTE_EN_CURSO,
     sa.NUMERO_ESTUDIANTES,
     sa.NUMERO_ESTUDIANTES_ACTIVOS,
     sa.TOTAL_ESTUDIANTES_INICIO_SESION,
     sa.Student_Last_Access,
     sa.HORAS_ACTIVIDAD_ESTUDIANTES_EN_CURSO,
    case when sa.NUMERO_ESTUDIANTES_ACTIVOS >  0 
         then round(sa.TOTAL_ESTUDIANTES_INICIO_SESION / sa.NUMERO_ESTUDIANTES_ACTIVOS, 2)
         else null
    end as Avg_Logins_Per_Active_Student,
    case when sa.NUMERO_ESTUDIANTES_ACTIVOS >  0 
         then round(sa.HORAS_ACTIVIDAD_ESTUDIANTES_EN_CURSO / sa.NUMERO_ESTUDIANTES_ACTIVOS, 2)
         else null
    end as Avg_Course_Hours_Per_Active_Student,
    collab_summary.collab_room_count,
    collab_summary.collab_session_count,
    collab_summary.total_collab_room_use_hours,
    collab_summary.total_collab_room_attended_hours, 
    collab_summary.collab_participant_count,
    collab_summary.total_collab_attendee_hours
from 
    courses 
    left join
        instructor_activity ia
        on  ia.Course_Surr_Key = courses.Course_Surr_Key 
    left join
        student_activity sa
        on  sa.Course_Surr_Key = courses.Course_Surr_Key 
    left join
        collab_summary
        on  collab_summary.lms_course_id = courses.Course_Surr_Key
order by 
    ia.NOMBRE_DOCENTE
