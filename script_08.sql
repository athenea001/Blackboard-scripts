SELECT      PER.STAGE:batch_uid,
            GRD.SCORE,
            GRDB.NAME,
            COU.NAME,
            COU.COURSE_NUMBER
from        CDM_LMS.PERSON PER 
LEFT JOIN   cdm_lms.PERSON_COURSE PERCOU ON
            PER.ID = PERCOU.PERSON_ID
LEFT JOIN   CDM_LMS.GRADE GRD ON
            GRD.PERSON_COURSE_ID = PERCOU.ID         
LEFT JOIN   CDM_LMS.GRADEBOOK GRDB ON 
            GRD.GRADEBOOK_ID = GRDB.ID
LEFT JOIN   cdm_lms.course COU ON
            COU.ID = PERCOU.COURSE_ID            
WHERE       PER.INSTITUTION_ROLE_SOURCE_DESC IN ('preuniversitarios_bb','preuniversitarios')