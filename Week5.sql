use sakila;

show full tables;

-- Tasks based on filtering

select payment_ID
from payment 
where customer_id <> 5 and (amount > 8 or date(payment_date)='2005-08-23');

select payment_ID
from payment 
where customer_id = 5 and not (amount > 6 or date(payment_date)='2005-06-19');

-- Retrieve all rows from the Payment table where the amount is either 1.98, 7.98, or 9.98.
select *
from payment
where amount in (1.98, 7.98, 9.98);

-- Find customers whose last name contains an A in the second position and a W anywhere after the A.
select *
from customer
where last_name like '_A%W%';

-- Fill in the blanks to obtain the results that follow
select c.first_name, c.last_name, a.address, ct.city
from customer c
	inner join address a
    on c.address_id = a.address_id
    inner join city ct
    on a.city_id=ct.city_id
where a.district = 'California';

-- Write a query that returns the title of every film in which an actor with the
-- first name JOHN appeared

select f.title, a.first_name, a.last_name
from film f 
	inner join film_actor fa
	on f.film_id = fa.film_id
    inner join actor a
    on fa.actor_id = a.actor_id
where a.first_name = 'JOHN';

-- Construct a query that finds returns all addresses which are in the same city.
-- You will need to join the address table to itself, and each row should include 2 different addresses.
select a.address, b.address, a.city_id, b.city_id
from address a
	inner join address b
    on a.city_id = b.city_id
    where a.address <> b.address;
    

select substring('Please find the substring in this string', 17, 9);

select abs(-25.76823), sign(-25.76823);    

select extract(month from current_date());   

