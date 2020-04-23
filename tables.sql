drop table Family_objtab force;

drop table TreatmentType_objtab force;

drop table Pet_objtab force;

drop table PetType_objtab force;


create table TreatmentType_objtab of TreatmentType_objtyp (id primary key) 
object identifier is primary key;

/

alter table TreatmentType_objtab
ADD CONSTRAINT unique_tr_type_title unique(treatmentTypeTitle);

/

alter table TreatmentType_objtab 
ADD CONSTRAINT treatmentType_notNull check ( treatmentType is not null );

/

create table PetType_objtab of PetType_objtyp (id primary key) 
object identifier is primary key;

/



alter table PetType_objtab
ADD CONSTRAINT unique_pet_type_title unique(petTypeTitle);

/


create table Pet_objtab of Pet_objtyp (id primary key) object identifier is primary key 
nested table Treatments_List store as Pets_Treatments;

/


alter table  Pet_objtab 
ADD CONSTRAINT petType_notNull check ( petType is not null );

/


create table Family_objtab of Family_objtyp (id primary key) object identifier is primary key 
nested table Pets_List store as Adopt_Pets
(nested table Treatments_List store as Adopted_Pet_Treatments);

/

