
-- Q1
drop materialized view ecommerce.Q1;

create materialized view ecommerce.Q1 AS
select *
from ecommerce.users
where age < 25
      and
      zone = 'Norte'
      and
      name is not null
      and
      email is not null
      and
      lastname is not null
primary key (user_id, name, email, lastname, age, zone)
with comment = 'Q1';

select * from ecommerce.Q1;

-- Q2
drop materialized view ecommerce.Q2;

create materialized view ecommerce.Q2 AS
select *
from ecommerce.users
where age is not null
      and
      zone is not null
      and
      name is not null
      and
      email = 'juan@email.com'
      and
      lastname is not null
primary key (user_id, name, email, lastname, age, zone)
with comment = 'Q2';

select * from ecommerce.Q2;

/*
-- Q3
select count(*) as Q3
from ecommerce.users
where zone = 'Norte';

-- Q4
select *
from ecommerce.users
where age = (select max(age)
             from ecommerce.users
             where zone = 'Norte');

-- Q5
select avg(age)
from ecommerce.users
where zone = 'Norte';

-- Q6
select *
from ecommerce.users
where name = 'Juan'
order by lastname asc;

-- Q7
select *
from ecommerce.users
where name = 'Juan' and age = 18;
*/