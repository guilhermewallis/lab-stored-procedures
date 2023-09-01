-- 1.
DELIMITER //
CREATE PROCEDURE GetCustomersRentedAction()
BEGIN
    select first_name, last_name, email
	from customer
	join rental on customer.customer_id = rental.customer_id
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on film.film_id = inventory.film_id
	join film_category on film_category.film_id = film.film_id
	join category on category.category_id = film_category.category_id
	where category.name = "Action"
	group by first_name, last_name, email;
END //
DELIMITER ;

CALL GetCustomersRentedAction;


-- 2.
DELIMITER //
CREATE PROCEDURE GetCustomersRentedCategory(IN cat_name varchar(25))
BEGIN
    select first_name, last_name, email
	from customer
	join rental on customer.customer_id = rental.customer_id
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on film.film_id = inventory.film_id
	join film_category on film_category.film_id = film.film_id
	join category on category.category_id = film_category.category_id
	where category.name = cat_name
	group by first_name, last_name, email;
END //
DELIMITER ;

CALL GetCustomersRentedCategory("Action");
CALL GetCustomersRentedCategory("Animation");


-- 3.
DELIMITER //
CREATE PROCEDURE GetNumMoviesByCat(IN min_num int)
BEGIN
	select category_id, count(*) num_movies from film_category
	group by category_id
	having num_movies >= min_num
	order by num_movies;
END //
DELIMITER ;

CALL GetNumMoviesByCat(59);
CALL GetNumMoviesByCat(73);