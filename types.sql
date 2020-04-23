drop type Address_objtyp force;

drop type Treatment_objtyp force;

drop type TreatmentList_vartyp force;

drop type Pet_objtyp force;

drop type PetList_pettyp force;

drop type Family_objtyp force;

drop type TreatmentType_objtyp force;

drop type PetType_objtyp force;

create or replace type Address_objtyp as object (
    street    varchar(500),
    house     number,
    apartment varchar(500),
    zip       varchar(500)
);

/

create or replace type TreatmentType_objtyp as object (
    id number,
    treatmentTypeTitle varchar(500)
);

/

create or replace type PetType_objtyp as object (
    id number,
    petTypeTitle varchar(500)
);

/

create or replace type Treatment_objtyp as object (
    id number,
    treatmentDate date,
    treatmentType TreatmentType_objtyp
);

/

create or replace type TreatmentList_vartyp as table of Treatment_objtyp;

/

create or replace type Pet_objtyp as object (
    id number,
    name varchar(500),
    dateOfBirth date,
    gender NUMBER(1,0),
    isTaken NUMBER(1,0),
    dateOfArrivalShelter date,
    petType PetType_objtyp,
    Treatments_List TreatmentList_vartyp,
    dateOfDeparture date,
    MEMBER FUNCTION getDateOfTreatmentType(treatmentType varchar) return date,
    MEMBER FUNCTION getAllPetsByType(petType varchar)             return Pet_objtyp,
    MEMBER FUNCTION getAllAvailablePets                           return Pet_objtyp,
    MEMBER FUNCTION hasPetThisTreatment(treatmentType varchar)    return number,
    MEMBER PROCEDURE addTreatment(treatment Treatment_objtyp)
);

/

create or replace type PetList_pettyp as table of Pet_objtyp;

/

create or replace type Family_objtyp as object (
    id number,
    familyName varchar(500),
    contactName varchar(500),
    contactEmail varchar(500),
    contactPhone varchar(500),
    Address_obj Address_objtyp,
    Pets_List PetList_pettyp,
    MEMBER PROCEDURE cancelAdoption(pet Pet_objtyp),
    MEMBER PROCEDURE adopt(pet Pet_objtyp)
);

/