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

CREATE OR REPLACE TYPE BODY Pet_objtyp AS 
-- add treatment to the pet
    MEMBER PROCEDURE addTreatment(treatmentType varchar, dateOfTreatment date) IS
        NULL_TABLE EXCEPTION;
        BEGIN
            INSERT INTO TABLE
            (SELECT Pets_Treatments FROM Pet_objtab WHERE id = self.id)
            VALUES(Treatment_objtyp(treatmentType, dateOfTreatment));
            EXCEPTION
                WHEN NULL_TABLE THEN
                UPDATE Pet_objtab SET Pets_Treatments = TreatmentList_vartyp()
                WHERE id = self.id;
                --TODO:
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
END;
         
    
