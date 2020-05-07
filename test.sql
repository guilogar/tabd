INSERT ALL
    INTO Family_objtab(familyName, contactName, contactEmail, contactPhone, Address_obj)
    VALUES(
        'Sanches Garcia', 'Helena', 'helena_s@gmail.com', '662223554',
        Address_objtyp('Av. Ana de Viya', 1, '4A', '11010'))
    INTO Family_objtab(familyName, contactName, contactEmail, contactPhone, Address_obj)
    VALUES(
        'Gonzales Martinez', 'Maria Luisa', 'maria_l@gmail.com', '662778432',
        Address_objtyp('Av. Macroni', 32, '2B', '11011'))
    INTO Family_objtab(familyName, contactName, contactEmail, contactPhone, Address_obj)
    VALUES(
        'Ruiz Picasso', 'Pablo', 'pablo_p@gmail.com', '662990012',
        Address_objtyp('Av. Recreo', 14, '1A', '11008'))
    INTO Family_objtab(familyName, contactName, contactEmail, contactPhone, Address_obj)
    VALUES(
        'Perez Lopez', 'Rosario', 'rosario_p@gmail.com', '662888445',
        Address_objtyp('Av. de Peru', 3, '1A', '11007'))
    INTO Family_objtab(familyName, contactName, contactEmail, contactPhone, Address_obj)
    VALUES(
        'Martin Diaz', 'Teresa', 'teresa_m@gmail.com', '662334558',
        Address_objtyp('C. Santo Domingo', 16, '2С', '11006'))
SELECT * FROM dual;

INSERT ALL
    INTO TreatmentType_objtab VALUES(1, 'castration')
    INTO TreatmentType_objtab VALUES(2, 'sterilization')
    INTO TreatmentType_objtab VALUES(3, 'rabies')
    INTO TreatmentType_objtab VALUES(4, 'carnivores')
    INTO TreatmentType_objtab VALUES(5, 'calvirus')
SELECT * FROM dual;

INSERT ALL 
    INTO Pet_objtab (name, dateOfBirth, gender, isTaken, dateOfArrivalShelter, petType, Treatments_List, dateOfDeparture, FamilyRef)
        VALUES('Domingo', TO_DATE('01/01/2018', 'MM/DD/YYYY'), 1, 0, sysdate, petType_objtyp('dog').petTypeTitle, TreatmentList_vartyp(), null, null)
    INTO Pet_objtab (name, dateOfBirth, gender, isTaken, dateOfArrivalShelter, petType, Treatments_List, dateOfDeparture, FamilyRef)
        VALUES('Kochi', TO_DATE('01/01/2017', 'MM/DD/YYYY'), 0, 0, sysdate, petType_objtyp('cat').petTypeTitle, TreatmentList_vartyp(), null, null)
    INTO Pet_objtab (name, dateOfBirth, gender, isTaken, dateOfArrivalShelter, petType, Treatments_List, dateOfDeparture, FamilyRef)
        VALUES('Simba', TO_DATE('01/06/2018', 'MM/DD/YYYY'), 1, 0, sysdate, petType_objtyp('cat').petTypeTitle, TreatmentList_vartyp(), null, null)
    INTO Pet_objtab (name, dateOfBirth, gender, isTaken, dateOfArrivalShelter, petType, Treatments_List, dateOfDeparture, FamilyRef)
        VALUES('Ringo', TO_DATE('01/06/2018', 'MM/DD/YYYY'), 1, 0, sysdate, petType_objtyp('dog').petTypeTitle, TreatmentList_vartyp(), null, null)
    INTO Pet_objtab (name, dateOfBirth, gender, isTaken, dateOfArrivalShelter, petType, Treatments_List, dateOfDeparture, FamilyRef)
        VALUES('Kiko', TO_DATE('01/06/2019', 'MM/DD/YYYY'), 1, 0, sysdate, petType_objtyp('dog').petTypeTitle, TreatmentList_vartyp(), null, null)
    INTO Pet_objtab (name, dateOfBirth, gender, isTaken, dateOfArrivalShelter, petType, Treatments_List, dateOfDeparture, FamilyRef)
        VALUES('Max', TO_DATE('01/01/2017', 'MM/DD/YYYY'), 1, 0, sysdate, petType_objtyp('dog').petTypeTitle, TreatmentList_vartyp(), null, null)
    INTO Pet_objtab (name, dateOfBirth, gender, isTaken, dateOfArrivalShelter, petType, Treatments_List, dateOfDeparture, FamilyRef)
        VALUES('Kora', TO_DATE('01/06/2019', 'MM/DD/YYYY'), 0, 0, sysdate, petType_objtyp('dog').petTypeTitle, TreatmentList_vartyp(), null, null)
    INTO Pet_objtab (name, dateOfBirth, gender, isTaken, dateOfArrivalShelter, petType, Treatments_List, dateOfDeparture, FamilyRef)
        VALUES('Greta', TO_DATE('01/01/2020', 'MM/DD/YYYY'), 0, 0, sysdate, petType_objtyp('cat').petTypeTitle, TreatmentList_vartyp(), null, null)
SELECT * FROM dual;

    





