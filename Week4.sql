-- Create a relational database of your own choice It is must be a meaningful/thought out database
-- Your table must have a primary key, the correct datatypes, include a minimum of 5 fields 
-- View and show table structures and data to make sure they are setup correctly
-- Enter records into table and view them Make sure your tables has 10 records
-- Update a record
-- Delete a record
-- Create a second table that references the first tables primary key



create database HLT;

use HLT;

create table Customers(
customer_id smallint unsigned auto_increment,
fname varchar(20),
lname varchar(20) not null,
birth_date date,
street varchar(30),
city varchar(20),
country varchar(20),
post_code varchar(20) not null,
constraint pk_customers primary key(customer_id)
);

-- drop table Customers;

-- view table
desc Customers;
explain Customers;

-- enter records
insert into Customers
(customer_id, fname, lname, birth_date, street, city, country, post_code)
values (null, 'Jon', 'Snow', '1970-04-14', 'Chichester road', 'Bromley', 'UK', 'hd8763'),
	(null, 'Maria', 'Sharapova', '1985-12-10', 'Bardsley Close', 'Mayfair', 'UK', 'ct28jp'),
    (null, 'Mark', 'Ashdown', '1976-03-08', 'Pink Avenue', 'Clapham', 'UK', 'gh7sd3'),
    (null, 'Rohan', 'Kumar', '1980-07-06', 'Winchester Road', 'Beckenham', 'UK', 'br56os'),
    (null, 'Niel', 'Desia', '1979-09-19', 'Fitzjames Avenue', 'Wandsworth', 'UK', 'ws37kp'),
    (null, 'Pooja', 'Malhotra', '1989-01-30', 'Reynolds Crescent', 'Shirley', 'UK', 'f56h70'),
    (null, 'Jeffrey', 'Hinton', '1982-04-25', 'Blackhorse Lane', 'Beddington', 'UK', 'hy75ds'),
    (null, 'David', 'Smith', '1960-06-17', 'Peacock Lane', 'Addington', 'UK', 'gs65hj'),
    (null, 'Bharat', 'Patel', '1967-10-18', 'Harland Avenue', 'East Dulwich', 'UK', 'gh2as5'),
    (null, 'Selina', 'Jaitley', '1983-02-21', 'Farnborough Close', 'Islington', 'UK', 'bh25rd');
    
    -- view table
    SELECT * FROM Customers;
    
    -- update a record
    update Customers
    set post_code='cr07jt', city='Heston'
    where lname='Sharapova';
    
    select * from Customers where lname='Sharapova';
    
    -- delete a record
    delete from Customers
    where customer_id=2;
    select * from Customers;
    
    -- Create a second table that references the first table's primary key
create table Orders(
customer_id smallint unsigned,
order_id int not null,
product_id int not null,
number_of_units smallint,
bill_amount decimal,
order_date date,
constraint pk_orders primary key(customer_id, order_id, product_id),
constraint fk_orders_customer_id foreign key(customer_id)
references Customers (customer_id)
);

insert into orders
(customer_id, order_id, product_id, number_of_units, bill_amount, order_date)
values (1, '12456', '12', '2', '140.0', '2021-03-03'),
(1, '12456', '13', '5', '89.0', '2021-03-14'),
(3, '5678', '30', '1', '29.5', '2021-01-30'),
(3, '17890','19', '3', '230.0', '2021-02-14');

-- what version of sql is being used, who is active right now, what database are they using
select version(), user(), database();

use sakila;

show full tables;

-- Retrieve the actor ID, first name, and last name for all actors. 
-- Sort by last name and then by first name.
select actor_id, first_name, last_name
from actor
order by last_name, first_name;

-- Retrieve the actor ID, first name, and last name for all actors
-- whose last name equals 'WILLIAMS' or 'DAVIS’
select actor_id, first_name, last_name
from actor
where last_name='WILLIAMS' or 'DAVIS';

-- Write a query against the rental table that returns the IDs of
-- the customers who rented a film on July 5th 2005 (use the
-- rental.rental_date column, and you can use the date()
-- function to ignore the time component). Include a single
-- row for each distinct customer ID.

 select customer_id
 from rental
 where date(rental.rental_date)='2005-07-05';
 
-- fill in the blanks for this multi-table query to achieve the results shown
select c.email, r.return_date
from customer c
	inner join rental r
	on c.customer_id = r.customer_id
where date(r.rental_date)='2005-06-14'
order by date(r.return_date) desc, time(return_date) desc;