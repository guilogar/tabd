--Pet type body
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

--Address type body--
CREATE OR REPLACE TYPE BODY Address_objtyp AS
    MEMBER PROCEDURE display IS
        BEGIN
            DBMS_OUTPUT.PUT_LINE ('address: street: ' || self.street || ', house: '||
            self.house || ', apartment: ' || self.apartment  ||
            ', zip: ' || self.zip) ;
        END;
END;
/

--Family type body--
CREATE OR REPLACE TYPE BODY Family_objtyp AS
    MEMBER PROCEDURE display IS
        BEGIN
            DBMS_OUTPUT.PUT_LINE ('id: ' || self.id || ', family name: '||
            self.familyName || ', contact name: ' || self.contactName ||
            ', email: ' || self.contactEmail || ', phone: ' || self.contactPhone);
            self.Address_obj.display;
            --TODO: adopted pets list

        END;

    MEMBER FUNCTION getContactPhone RETURN VARCHAR IS
        BEGIN
            RETURN self.contactPhone;
        END; 

    MEMBER PROCEDURE findFamilyByPhone(phone varchar) IS
        BEGIN
            DBMS_OUTPUT.PUT_LINE('f');
        END;     
END;
         
/

CREATE OR REPLACE TYPE BODY Treatment_objtyp AS
    MEMBER PROCEDURE display IS
        BEGIN
            DBMS_OUTPUT.PUT_LINE ('id: ' || self.id || ', date: '||
            self.treatmentDate || ', type: ' || self.treatmentType);
            
        END;
END;        
/

CREATE OR REPLACE TYPE BODY Pet_objtyp AS 
-- add treatment to the pet
    MEMBER PROCEDURE addTreatment(treatmentType varchar, dateOfTr date) IS
        treatmentType_title VARCHAR(200);
        NULL_TABLE EXCEPTION;
        PRAGMA EXCEPTION_INIT (NULL_TABLE, -22908);
    BEGIN
        BEGIN
            SELECT t.treatmentTypeTitle INTO 
            treatmentType_title 
            FROM TreatmentType_objtab t
            WHERE t.treatmentTypeTitle = treatmentType;
    
        EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 raise_application_error (-20001, 'No such treatment ' || treatmentType ||
                 ' check treatments type with getAllTypeTreatments function');
    
        END;
        BEGIN
        INSERT INTO TABLE (
            SELECT p.Treatments_List
            FROM Pet_objtab p
            WHERE p.id = self.id
        )
        SELECT treatmentTab_id_seq.nextval, dateOfTr, t.treatmentTypeTitle
        FROM TreatmentType_objtab t
        WHERE t.treatmentTypeTitle = LOWER(treatmentType);

        EXCEPTION
                WHEN NULL_TABLE THEN
                UPDATE Pet_objtab SET Treatments_List = TreatmentList_vartyp()
                     WHERE id = self.id;
                INSERT INTO TABLE (
                    SELECT p.Treatments_List
                    FROM Pet_objtab p
                    WHERE p.id = self.id)
                SELECT treatmentTab_id_seq.nextval, dateOfTr, 
                    t.treatmentTypeTitle
                    FROM TreatmentType_objtab t
                    WHERE t.treatmentTypeTitle = LOWER(treatmentType);
        
        END;      
    END;
    MEMBER PROCEDURE DISPLAY IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Pet: ');
    END;


     MEMBER PROCEDURE getALLTreatments IS
        i INTEGER;
        pet_treatments  TreatmentList_vartyp; 

        BEGIN
            FOR i in 1..SELF.Treatments_List.COUNT LOOP
                 DBMS_OUTPUT.PUT_LINE('id: ' || self.Treatments_List(i).id 
                 || 'procedure: '  || self.Treatments_List(i).treatmentType
                 || 'date: ' || self.Treatments_List(i).treatmentDate);
            END LOOP; 
    END; 

    MEMBER PROCEDURE cancelAdoption IS
    BEGIN
            UPDATE Pet_objtab 
            SET isTaken = 0,
                FamilyRef = NULL
            WHERE id = self.id;
    END;          

    MEMBER PROCEDURE adoptByFamily(idFamily number) IS
        familyRef_obj ref Family_objtyp;
        BEGIN
            SELECT REF (f) INTO familyRef_obj 
            FROM Family_objTab f
            WHERE f.id = idFamily;

            UPDATE Pet_objtab
            SET isTaken = 1,
                FamilyRef = familyRef_obj 
            WHERE id = self.id;

        END;        
END;

/


