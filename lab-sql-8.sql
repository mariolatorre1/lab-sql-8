use sakila;

-- 1.Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, dense_rank() over (order by length desc) as "rank"
from film
where length > 0 and length is not null;

-- 2.Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
select title, length, rating, dense_rank() over (partition by rating order by length desc) as "rank"
from film
where length > 0 and length is not null;

-- 3.How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select c.category_id, count(f.film_id)
from category c
join film_category f using(category_id)
group by c.category_id;

-- 4.Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select a.first_name, a.last_name, count(f.film_id) as total_movies
from actor a
join film_actor f using(actor_id)
group by a.first_name, a.last_name
order by count(f.film_id) desc;

-- 5.Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer. 
select c.first_name, c.last_name, count(r.rental_id) as total_rentals
from customer c
join rental r using(customer_id)
group by c.first_name, c.last_name
order by count(r.rental_id) desc;

-- Bonus: Which is the most rented film? 
select f.title, count(r.rental_id) as total_rentals 
from film f
join inventory i using(film_id)
join rental r using(inventory_id)
group by f.title
order by count(r.rental_id) desc;

