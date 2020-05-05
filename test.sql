SET SERVEROUTPUT ON

INSERT ALL
INTO Family_objtab(familyName, contactName,contactEmail,contactPhone, Address_obj)
VALUES(
    'Sanches Garcia', 'Helena', 'helena_s@gmail.com', '662223554',
    Address_objtyp('Av. Ana de Viya', 1, '1A', '11010'))
INTO Family_objtab(familyName, contactName,contactEmail,contactPhone, Address_obj)
VALUES(
    'Gonzales Martinez', 'Maria Luisa', 'maria_l@gmail.com', '662778432',
    Address_objtyp('Av. Macroni', 32, '2B', '11011'))
INTO Family_objtab(familyName, contactName,contactEmail,contactPhone, Address_obj)
VALUES(
    'Ruiz Picasso', 'Pablo', 'pablo_p@gmail.com', '662990012',
    Address_objtyp('Av. Recreo', 14, '1A', '11008'))
INTO Family_objtab(familyName, contactName,contactEmail,contactPhone, Address_obj)
VALUES(
    'Perez Lopez', 'Rosario', 'rosario_p@gmail.com', '662888445',
    Address_objtyp('Av. de Peru', 3, '1A', '11007'))
INTO Family_objtab(familyName, contactName,contactEmail,contactPhone, Address_obj)
VALUES(
    'Martin Diaz', 'Teresa', 'teresa_m@gmail.com', '662334558',
    Address_objtyp('C. Santo Domingo', 16, '2A', '11006'))
 SELECT * FROM dual;

/

INSERT ALL
INTO TreatmentType_objtab VALUES('castration')
INTO TreatmentType_objtab VALUES('sterilization')
INTO TreatmentType_objtab VALUES('rabies')
INTO TreatmentType_objtab VALUES('rabies')
INTO TreatmentType_objtab VALUES('carnivores')
INTO TreatmentType_objtab VALUES('calvirus')
 SELECT * FROM dual;

/


