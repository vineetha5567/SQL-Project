-- First 10 actors name lengths along with their names
select first_name,last_name ,length(first_name)+length(last_name) as length from actor Limit 10 ;
-- Full names and their length who won the oscar award
select first_name,last_name ,length(first_name)+length(last_name) as length from actor_award where awards like '%Oscar%';
-- actors who have acted in the film ‘Frost Head.’
select first_name,last_name from film inner join film_actor on film.film_id=film_actor.film_id inner join actor on film_actor.actor_id=actor.actor_id where title='FROST HEAD';
-- films acted by the actor ‘Will Wilson
select title as films from film inner join film_actor on film.film_id=film_actor.film_id inner join actor on film_actor.actor_id=actor.actor_id where first_name='Will' and last_name='Wilson';
-- films which were rented and return them in the month of May.
select title as films from film inner join inventory on film.film_id=inventory.film_id inner join rental on inventory.inventory_id=rental.inventory_id where rental_date like '%-05-%' and return_date like '%-05-%';
--  films with ‘Comedy’ category.
select title as films from film inner join film_category on film.film_id=film_category.film_id inner join category on film_category.category_id=category.category_id where name='comedy';