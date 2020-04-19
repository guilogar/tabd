create type Address_objtyp as object (
    street    varchar(500),
    house     number,
    apartment varchar(500),
    zip       varchar(500)
);

create type Family_objtyp as object (
    id number,
    familyName varchar(500),
    contactName varchar(500),
    contactEmail varchar(500),
    contactPhone varchar(500),,
    Address_obj Address_objtyp
    -- TODO: pets : List<pet>
);

create type Pet_objtype as object (
    id number,
    name varchar(500),
    dateOfBirth date,
    gender boolean,
    isTaken boolean,
    dateOfArrivalShelter date,
    -- TODO petType : PetType
    
);