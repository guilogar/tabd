
drop keyspace ecommerce;
create keyspace ecommerce
with replication = { 'class': 'SimpleStrategy', 'replication_factor': 3 };

create table ecommerce.users (
    user_id  uuid,
    name     text,
    lastname text,
    email    text,
    age      tinyint,
    zone     text,
    primary key ((user_id), name, lastname, email, age, zone)
);


insert into ecommerce.users (user_id, name, lastname, email, age, zone)
values (uuid(), 'Juan', 'Martínez', 'juan@email.com', 18, 'Norte');

insert into ecommerce.users (user_id, name, lastname, email, age, zone)
values (uuid(), 'María', 'García', 'maria@email.com', 25, 'Sur');

insert into ecommerce.users (user_id, name, lastname, email, age, zone)
values (uuid(), 'Domingo', '', 'domingo@email.com', 32, 'Norte');

insert into ecommerce.users (user_id, name, lastname, email, age, zone)
values (uuid(), 'Roberto', 'Luján', 'roberto@email.com', 21, 'Norte');

insert into ecommerce.users (user_id, name, lastname, email, age, zone)
values (uuid(), 'Mario', 'García', 'mario@email.com', 25, 'Sur');