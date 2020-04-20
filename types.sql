-- drop type Address_objtyp force;
-- /

-- drop type Treatment_objtyp force;
-- /

-- drop type TreatmentList_vartyp force;
-- /

-- drop type Pet_objtyp force;
-- /

-- drop type PetList_pettyp force;
-- /

-- drop type Family_objtyp force;
-- /

create or replace type Address_objtyp as object (
    street    varchar(500),
    house     number,
    apartment varchar(500),
    zip       varchar(500)
);
/

create or replace type Treatment_objtyp as object (
    id number,
    treatmentDate date,
    treatmentType varchar(500)
    -- TODO treatmentType enum('Rabies vaccine',
    --                   'Vaccination against panleukopenia',
    --                   'Vaccination against rhinotracheid',
    --                   'Plague vaccine',
    --                   'Castration'),
);
/

create or replace type TreatmentList_vartyp as varray(500) Treatment_objtyp;
/

create or replace type Pet_objtyp as object (
    id number,
    name varchar(500),
    dateOfBirth date,
    gender NUMBER(1,0),
    isTaken NUMBER(1,0),
    dateOfArrivalShelter date,
    petType varchar(500),
    Treatments_List TreatmentList_vartyp,
    dateOfDeparture date
    -- TODO: Family_obj REF Family_objtyp,
);
/

create or replace type PetList_pettyp as varray(500) of Pet_objtyp;
/

create or replace type Family_objtyp as object (
    id number,
    familyName varchar(500),
    contactName varchar(500),
    contactEmail varchar(500),
    contactPhone varchar(500),
    Address_obj Address_objtyp,
    Pets_List PetList_pettyp
);
/