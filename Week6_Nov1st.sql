use sakila;

select count(*) num_payments
from payment;

-- count the number of payments made by each customer. 
-- Show the customer ID and the total amount paid for each customer.
select customer_id, 
	sum(amount) tot_amt_payed, 
	count(*) num_payments
from payment
group by customer_id;

-- Modify your query from to include only customers who made at least 5 payments
select customer_id, 
	sum(amount) tot_amt_payed, 
	count(*) num_payments
from payment
group by customer_id
having count(*)>=5;

-- create Table Slaes_Fact in database HLT
use HLT;

create table Sales_Fact(
year_no smallint,
month_no smallint,
tot_sales int
);

insert into Sales_Fact
(year_no, month_no, tot_sales)
values (2019, 1, 19228),
	(2019, 2, 18554),
    (2019, 3, 17325),
    (2019, 4, 13221),
    (2019, 5, 9964),
    (2019, 6, 12658),
    (2019, 7, 14233),
    (2019, 8, 17342),
    (2019, 9, 16853),
    (2019, 10, 17121),
    (2019, 11, 19095),
    (2019, 12, 21436),
    (2020, 1, 20347),
    (2020, 2, 17434),
    (2020, 3, 16225),
    (2020, 4, 13853),
    (2020, 5, 14589),
    (2020, 6, 13248),
    (2020, 7, 8728),
    (2020, 8, 9378),
    (2020, 9, 11467),
    (2020, 10, 13842),
    (2020, 11, 15742),
    (2020, 12, 18636);
select *
from Sales_Fact;

-- Write a query that retrieves every row from Sales_Fact
-- Add a column to generate a ranking based on the tot_sales column values. 
-- The highest value should receive a ranking of 1, and the lowest a ranking of 24.
select *, 
    rank() over (order by tot_sales desc) sales_rank
from Sales_fact
order by year_no, month_no;

-- Modify the query above to generate two sets of rankings from 1 to 12, one for
-- 2019 data and one for 2020
select *,
    rank() over (partition by year_no  order by tot_sales desc) sales_rank_yr
from Sales_Fact
order by year_no, month_no;

-- Write a query that retrieves all 2020 data, and include a column which will 
-- contain the tot_sales value from the previous month.
select *,
	lag(tot_sales, 1) over (order by month_no) prev_month_tot_sales	
from Sales_Fact
where year_no=2020
order by month_no;

-- Create a view definition that can be used by the given query to generate given results

use sakila;
create view film_ctgry_actor
as
select c.name as category_name, f.title, a.first_name, a.last_name
from category c
	inner join film_category fc
    on c.category_id = fc.category_id
    inner join film f
    on fc.film_id = f.film_id
    inner join film_actor fa
    on fa.film_id = f.film_id
    inner join actor a
    on fa.actor_id = a.actor_id;

-- check created view
select *
from film_ctgry_actor
where last_name = 'FAWCETT';

-- run query on view to get desired results
select title, category_name, first_name, last_name
from film_ctgry_actor
where last_name = 'FAWCETT';

-- The film rental company manager would like to have a report that includes 
-- the name of every country, along with the total payments for all customers 
-- who live in each country.
-- Generate a view definition that queries the country table and uses a scalar 
-- subquery to calculate a value for a column named tot_payments

-- this is my working / testing
create view full_table
as
select p.amount, c.country
	from payment p
    inner join customer cust
    on p.customer_id=cust.customer_id
    inner join address ad
    on cust.address_id=ad.address_id
    inner join city cit
    on ad.city_id = cit.city_id
    inner join country c
    on cit.country_id = c.country_id;
    
select *
from full_table;

select country, sum(amount) 
from full_table
group by country;

-- putting it together into the final script
create view rentals_by_country 
as
select country, sum(amt) tot_payments
from 
  (select p.amount as amt, c.country
	from payment p
    inner join customer cust
    on p.customer_id=cust.customer_id
    inner join address ad
    on cust.address_id=ad.address_id
    inner join city cit
    on ad.city_id = cit.city_id
    inner join country c
    on cit.country_id = c.country_id
    ) full_table
group by country
order by 2;

select *
from rentals_by_country;