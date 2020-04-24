CREATE OR REPLACE TYPE BODY PetType_objtyp AS 
    CONSTRUCTOR FUNCTION petType_objtyp( petTypeTitle varchar)
        RETURN SELF AS RESULT IS
            BEGIN
                IF LOWER(TRIM(petTypeTitle)) IN ('dog', 'cat')
                    THEN 
                        SELF.petTypeTitle := LOWER(TRIM(petTypeTitle));
                ELSE
                    RAISE_APPLICATION_ERROR(-20999,'Unknown type "' || LOWER(TRIM(petTypeTitle)) || '"');
                END IF;
        RETURN;
    END;
END;        

/
