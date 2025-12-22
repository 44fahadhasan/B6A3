 -- create database
create database
  vehicle_rental_system;

-- create enum types
create type
  user_role as enum('Admin', 'Customer');

create type
  vehicle_type as enum('car', 'bike', 'truck');

create type
  vehicle_status as enum('available', 'rented', 'maintenance');

create type
  booking_status as enum('pending', 'confirmed', 'completed', 'cancelled');

-- create users table
create table
  users (
    user_id serial primary key,
    name varchar(150),
    email varchar(150) unique,
    phone varchar(15),
    role user_role,
    password varchar(200)
  );

-- create vehicles table
create table
  vehicles (
    vehicle_id serial primary key,
    name varchar(150),
    type
      vehicle_type,
      model varchar(30),
      registration_number varchar(100) unique,
      rental_price decimal(10, 2),
      vehicle_availability vehicle_status
  );

-- create bookings table
create table
  bookings (
    booking_id serial primary key,
    user_id int references users (user_id),
    vehicle_id int references vehicles (vehicle_id),
    start_date date,
    end_date date,
    booking_status booking_status,
    total_cost decimal(10, 2)
  );

 -- insert data into users table
insert into
  users (user_id, name, email, phone, role)
values
  (
    1,
    'Alice',
    'alice@example.com',
    '1234567890',
    'Customer'
  ),
  (
    2,
    'Bob',
    'bob@example.com',
    '0987654321',
    'Admin'
  ),
  (
    3,
    'Charlie',
    'charlie@example.com',
    '1122334455',
    'Customer'
  );

-- insert data into vehicles table
insert into
  vehicles (
    vehicle_id,
    name,
    type
,
      model,
      registration_number,
      rental_price,
      vehicle_availability
  )
values
  (
    1,
    'Toyota Corolla',
    'car',
    '2022',
    'ABC-123',
    50.00,
    'available'
  ),
  (
    2,
    'Honda Civic',
    'car',
    '2021',
    'DEF-456',
    60.00,
    'rented'
  ),
  (
    3,
    'Yamaha R15',
    'bike',
    '2023',
    'GHI-789',
    30.00,
    'available'
  ),
  (
    4,
    'Ford F-150',
    'truck',
    '2020',
    'JKL-012',
    100.00,
    'maintenance'
  );

-- insert data into bookings table
insert into
  bookings (
    booking_id,
    user_id,
    vehicle_id,
    start_date,
    end_date,
    booking_status,
    total_cost
  )
values
  (
    1,
    1,
    2,
    '2023-10-01',
    '2023-10-05',
    'completed',
    240.00
  ),
  (
    2,
    1,
    2,
    '2023-11-01',
    '2023-11-03',
    'completed',
    120.00
  ),
  (
    3,
    3,
    2,
    '2023-12-01',
    '2023-12-02',
    'confirmed',
    60.00
  ),
  (
    4,
    1,
    1,
    '2023-12-10',
    '2023-12-12',
    'pending',
    100.00
  );

   -- Query 1: JOIN
-- Retrieve booking information along with Customer name and Vehicle name.
select
  b.booking_id,
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.booking_status as status
from
  bookings as b
  inner join users as u on b.user_id = u.user_id
  inner join vehicles as v on b.vehicle_id = v.vehicle_id;

-- Query 2: EXISTS
-- Find all vehicles that have never been booked.
select
  vehicle_id,
  name,
type
,
  model,
  registration_number,
  rental_price,
  vehicle_availability as status
from
  vehicles as v
where
  not exists (
    select
      b.vehicle_id
    from
      bookings as b
    where
      b.vehicle_id = v.vehicle_id
  );

-- Query 3: WHERE
-- Retrieve all available vehicles of a specific type (e.g. cars).
select
  vehicle_id,
  name,
type
,
  model,
  registration_number,
  rental_price,
  vehicle_availability as status
from
  vehicles
where
type
  = 'car'
  and vehicle_availability = 'available';

-- Query 4: GROUP BY and HAVING
-- Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
select
  v.name as vehicle_name,
  count(b.*) as total_bookings
from
  bookings as b
  join vehicles as v on b.vehicle_id = v.vehicle_id
group by
  vehicle_name
having
  count(b.*) > 2;