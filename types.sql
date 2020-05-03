-- drop type Address_objtyp force;

-- drop type Treatment_objtyp force;

-- drop type TreatmentList_vartyp force;

drop type Family_objtyp force;

drop type TreatmentType_objtyp force;

drop type Pet_objtyp force;


create or replace type Address_objtyp FORCE as object (
    street    varchar(500),
    house     number,
    apartment varchar(500),
    zip       varchar(500),
    MEMBER PROCEDURE display
    
);

/

create or replace type TreatmentType_objtyp FORCE as object (
    id number,
    treatmentTypeTitle varchar(500)
);
/

create or replace type PetType_objtyp FORCE as object (
    petTypeTitle varchar(500),
    CONSTRUCTOR FUNCTION petType_objtyp( petTypeTitle varchar)
    RETURN SELF AS RESULT
);

-- forward declaration of Pet_objtyp
-- create or replace type Pet_objtyp;
/

create or replace type Treatment_objtyp FORCE as object (
    id number,
    treatmentDate date,
    treatmentType varchar(500),
    MEMBER PROCEDURE display);


/

create or replace type TreatmentList_vartyp FORCE as table of Treatment_objtyp;

/

create or replace type Family_objtyp FORCE as object (
    id number,
    familyName varchar(500),
    contactName varchar(500),
    contactEmail varchar(500),
    contactPhone varchar(500),
    Address_obj Address_objtyp,
    MEMBER PROCEDURE display, 
    MEMBER FUNCTION getContactPhone                     RETURN VARCHAR,
    MEMBER PROCEDURE findFamilyByPhone(phone varchar)
    );

/
create or replace type Pet_objtyp FORCE as object (
    id number,
    name varchar(500),
    dateOfBirth date,
    gender NUMBER(1,0),
    isTaken NUMBER(1,0),
    dateOfArrivalShelter date,
    petType varchar(200),
    Treatments_List TreatmentList_vartyp,
    dateOfDeparture date,
    FamilyRef REF Family_objtyp,
    --MEMBER FUNCTION getAllPetsByType(petType varchar)             return Pet_objtyp,
    --MEMBER FUNCTION getAllAvailablePets                           return Pet_objtyp,
    --MEMBER FUNCTION hasPetThisTreatment(treatmentType varchar)    return number,
      MEMBER PROCEDURE getALLTreatments,
      MEMBER PROCEDURE adoptByFamily(idFamily number),
      MEMBER PROCEDURE cancelAdoption,
      MEMBER PROCEDURE DISPLAY,
      MEMBER PROCEDURE addTreatment(treatmentType varchar, dateOfTr date)
    --MEMBER FUNCTION getAllAdoptedPetsByFamily(familyId number)                   RETURN number    
);

/

create or replace type PetsList_vartyp FORCE as table of Pet_objtyp;

/
