use sakila;
show  tables;
-- task 1
select concat(first_name,'_',last_name) as 'full name'  from actor;
select count(*) from actor;

-- task 2
select  count(first_name) ,first_name from actor group by first_name ;

-- task 2.2
select count(first_name) as 'unique names',first_name from actor group by first_name having count(first_name) = 1;
select count(*) as 'count of unique names' from (
    Select first_name
    from actor group by first_name having count(first_name) = 1
) as unique_names;

-- Task 3-- 
select  count(last_name) ,last_name from actor group by last_name ;
select count(last_name) as 'unique names2', last_name from actor group by last_name having count(last_name) = 1;
select last_name as 'unique names2' from actor group by last_name having count(last_name) = 1;
select count(*) as 'count of unique names' from (
    Select last_name
    from actor group by last_name having count(last_name) = 1
) as unique_names;

-- Task 4.1
select * from film where rating="R";
select count(*) from film where rating="R";

-- Task 4.2
select * from film where rating!="R";
select count(*) from film where rating!="R";

-- Task 4.3
select * from film where rating="PG-13";
select count(*) from film where rating="PG-13";
select * from film where rating='G' OR rating = 'PG';
select count(*) from film where rating='G' OR rating = 'PG';
-- or 

select film.title as 'Children movies',category.name as 'Children category' 
from film join film_category join category 
on film.film_id=film_category.film_id and category.category_id=film_category.category_id 
where category.name in ('children') ; 

select count(*)
from film join film_category join category 
on film.film_id=film_category.film_id and category.category_id=film_category.category_id 
where category.name in ('children') ; 
 
-- Task 5.1
select *  from film  where replacement_cost <=11  ;
select count(*)  from film  where replacement_cost <=11  ;
-- Task 5.2
select *  from film  where replacement_cost between 11 and 20  ;
select count(*)  from film  where replacement_cost between 11 and 20  ;

-- Task 5.3
select * from film order by replacement_cost desc;
select count(*) from film order by replacement_cost desc;

-- Task 6
select film.title ,count(actor_id) as 'number of actors' 
from film join film_actor 
on film.film_id =film_actor.film_id 
group by film.film_id order by count(actor_id) desc limit 3 ;

-- Task 7
select title from film where title like'K%' or title like'Q%';
select count(title) from film where title like'K%' or title like'Q%';
 -- K movies 12 and Q movies 3

-- Task 8
select  actor.first_name,actor.last_name,concat(first_name,'_',last_name) as 'full name' 
from film join actor join film_actor 
on film.film_id =film_actor.film_id and film_actor.actor_id=actor.actor_id 
where title="Agent Truman";

select  count(*)
from film join actor join film_actor 
on film.film_id =film_actor.film_id and film_actor.actor_id=actor.actor_id 
where title="Agent Truman";

-- Task 9
select film.title as 'Family movies',category.name as 'Family category' 
from film join film_category join category 
on film.film_id=film_category.film_id and category.category_id=film_category.category_id 
where category.name in ('Family') ;

select count(*) 
from film join film_category join category 
on film.film_id=film_category.film_id and category.category_id=film_category.category_id 
where category.name in ('Family') ;

-- Task 10
select rating,max(rental_rate),min(rental_rate),avg(rental_rate)  
from film group by rating order by avg(rental_rate) desc;

-- Task 10.2

select film.title,count(rental.rental_id) as 'rental_frequencies'
from film join inventory join rental 
on  film.film_id =inventory.film_id and inventory.inventory_id=rental.inventory_id 
group by film.film_id order by count(rental.rental_id)   desc ;

-- Task 11-- 
select category.name , avg(replacement_cost),avg(rental_rate),( avg(replacement_cost) - avg(rental_rate) ) as 'avg difference' 
from film join category join film_category 
on film.film_id=film_category.film_id and category.category_id=film_category.category_id 
group by (category.name) having (select ( avg(replacement_cost) - avg(rental_rate) ) as 'avg difference' from film)>15;


-- Task 12
-- ### The movie categories in which the number of movies greater than 70

select count(film_id) as Movie_count,category.name 
from category join film_category
on film_category.category_id=category.category_id 
group by category.name having count(film_id) >70;


-- Extra Analysis
-- Count of the movies for each Category
select count(film_id) as 'count of movies' ,rating from film group by rating;

-- which genre has highest number of movies
select category.name ,count(film.title) as 'Number_of_movies'
from film join category join film_category
on film.film_id=film_category.film_id and category.category_id=film_category.category_id
group by category.name  order by count(film.title)  desc;





