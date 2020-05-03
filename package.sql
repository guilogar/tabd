CREATE OR REPLACE PACKAGE SHELTER AS
     FUNCTION getAllPetsByType(petType varchar)             return PetsList_vartyp;
     FUNCTION getAllAvailablePets                           return PetsList_vartyp;
     FUNCTION getAllFamilies                                return FamilyList_vartyp;
     FUNCTION getPetById(id number)                          RETURN Pet_objtyp;
     FUNCTION getFamilyById(id number)                          RETURN Family_objtyp;
     PROCEDURE addTreatmentToPet(petId number, treatmentName varchar);
    --  PROCEDURE addTreatmentToPet(petId number, treatmentId number);
     PROCEDURE deletePet(petId number);
     PROCEDURE deleteFamily(familyId number);
     --PROCEDURE deleteFamily(familyPhoneNum varchar); 
     --PROCEDURE addTreatmentType(nameOfTreatment varchar);
    --  FUNCTION hasPetThisTreatment(petId number, treatmentType varchar)    return number,
    --  FUNCTION getALLTreatments(petId number)                              return TreatmentList_vartyp,
    PROCEDURE adoptByFamily(idPet number, idFamily number);
    PROCEDURE cancelAdoption(idPet number);

END SHELTER;
/

CREATE OR REPLACE PACKAGE BODY SHELTER IS
    FUNCTION getAllPetsByType(petType varchar) return PetsList_vartyp IS
        pet Pet_objtyp;

        pets PetsList_vartyp := PetsList_vartyp();

        CURSOR allPetByType IS
		SELECT  *
		FROM Pet_objtab
        WHERE petType = petType_objtyp(petType).petTypeTitle;

        BEGIN 
		    FOR petRow IN allPetByType LOOP
                
                SELECT VALUE(p) INTO pet
                FROM Pet_objtab p
                WHERE id = petRow.id;

                 pets.extend();
                 pets(pets.count) := pet;
                 pet.display();

            END LOOP;

            RETURN pets;
        END;


    FUNCTION getAllAvailablePets return PetsList_vartyp IS
        pet Pet_objtyp;
        pets PetsList_vartyp := PetsList_vartyp();

        CURSOR allPetByType IS
		SELECT  *
		FROM Pet_objtab
        WHERE isTaken = 0;

        BEGIN 
		    FOR petRow IN allPetByType LOOP
                
                SELECT VALUE(p) INTO pet
                FROM Pet_objtab p
                WHERE id = petRow.id;

                 pets.extend();
                 pets(pets.count) := pet;
                 pet.display();

            END LOOP;

            RETURN pets;
        END;

    FUNCTION getAllFamilies  return FamilyList_vartyp IS
        family Family_objtyp;
        families FamilyList_vartyp := FamilyList_vartyp();

        CURSOR allFamilies IS
		SELECT  *
		FROM Family_objtab;

        BEGIN 
		    FOR familyRow IN allFamilies LOOP
                
                SELECT VALUE(f) INTO family
                FROM Family_objtab f
                WHERE id = familyRow.id;

                 families.extend();
                 families(families.count) := family;
                 family.display();

            END LOOP;

            RETURN families;
        END;

    FUNCTION getPetById(id number)  RETURN Pet_objtyp IS
        pet Pet_objtyp;
        BEGIN
            BEGIN
            SELECT VALUE(p) INTO pet
                FROM Pet_objtab p
                WHERE p.id = id;

            EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 raise_application_error (-20001, 'No such pet ');
            END;
            BEGIN
               RETURN pet;
            END; 
    END;

    FUNCTION getFamilyById(id number)  RETURN Family_objtyp IS
        family family_objtyp;
        BEGIN
            BEGIN
            SELECT VALUE(f) INTO family
                FROM Family_objtab f
                WHERE f.id = id;

            EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 raise_application_error (-20001, 'No such family ');
            END;

            BEGIN
               RETURN family;
            END; 
    END;

    PROCEDURE addTreatmentToPet(petId number, treatmentName varchar) IS
        pet Pet_objtyp;
        BEGIN
           pet := getPetById(petId);
           pet.addTreatment(treatmentName, sysdate);
        END; 

    PROCEDURE deletePet(petId number) IS
        pet Pet_objtyp;
    BEGIN
        pet := getPetById(petId);
        pet.deletePet();
    END;

    PROCEDURE deleteFamily(familyId number) IS
        family Family_objtyp;
    BEGIN
         family := getFamilyById(familyId);
        family.deleteFamily();
    END; 
     


    PROCEDURE adoptByFamily(idPet number, idFamily number) IS
        pet Pet_objtyp;
        BEGIN
            pet := getPetById(idPet);
            pet.adoptByFamily(idFamily); 
        END; 

    PROCEDURE cancelAdoption(idPet number) IS
        pet Pet_objtyp;
        BEGIN
            pet := getPetById(idPet);
            pet.cancelAdoption(); 
        END; 

END;
/