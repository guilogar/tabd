drop type Address_objtyp force;

drop type Treatment_objtyp force;

drop type TreatmentList_vartyp force;

drop type Family_objtyp force;

drop type TreatmentType_objtyp force;

drop type Pet_objtyp force;


create or replace type Address_objtyp FORCE as object (
    street    varchar(500),
    house     number,
    apartment varchar(500),
    zip       varchar(500)
);

/

create or replace type TreatmentType_objtyp FORCE as object (
    id number,
    treatmentTypeTitle varchar(500)
);

/

create or replace type PetType_objtyp FORCE as object (
    id number,
    petTypeTitle varchar(500),
    CONSTRUCTOR FUNCTION petType_objtyp( petTypeTitle varchar)
    RETURN SELF AS RESULT
);

/

create or replace type Treatment_objtyp FORCE as object (
    id number,
    treatmentDate date,
    treatmentType_ref REF TreatmentType_objtyp
);

/

create or replace type TreatmentList_vartyp FORCE as table of Treatment_objtyp;

/

create or replace type Family_objtyp FORCE as object (
    id number,
    familyName varchar(500),
    contactName varchar(500),
    contactEmail varchar(500),
    contactPhone varchar(500),
    Address_obj Address_objtyp
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
    MEMBER FUNCTION getDateOfTreatmentType(treatmentType varchar) return date,
    MEMBER FUNCTION getAllPetsByType(petType varchar)             return Pet_objtyp,
    MEMBER FUNCTION getAllAvailablePets                           return Pet_objtyp,
    MEMBER FUNCTION hasPetThisTreatment(treatmentType varchar)    return number,
    MEMBER PROCEDURE addTreatment(treatment Treatment_objtyp),
    MEMBER PROCEDURE adoptByFamily(family Family_objtyp),
    MEMBER PROCEDURE cancelAdoption
);

/
