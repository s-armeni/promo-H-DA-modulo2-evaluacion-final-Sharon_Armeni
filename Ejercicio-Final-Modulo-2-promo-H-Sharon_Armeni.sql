USE sakila;

/* Ejercicio 1
Selecciona todos los nombres de las películas sin que aparezcan duplicados.

Utilizamos la cláusula DISTINCT para identificar y mostrar los valores únicos de la columna "title" */

SELECT DISTINCT title 
FROM film;

/* Ejercicio 2
Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

Utilizamos la cláusula WHERE para filtrar los resultados según la condición específica dada,
junto con el operador de igualdad para realizar la comparación (=).
También utilizamos la palabra reservada AS para proporcionar alias a las columnas en el resultado de la consulta. */

SELECT title AS titulo_peliculas, rating AS clasificacion
FROM film
WHERE rating = 'PG-13';

/* Ejercicio 3
Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing"
en su descripción.

Utilizamos la cláusula LIKE para filtrar por coincidencias de palabra utilizando patrones de cadena de texto. */

SELECT title, description
FROM film
WHERE description LIKE '%amazing%';

/* Ejercicio 4
Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

Utilizamos el operador de comparación 'Mayor que' (>) en la cláusula WHERE. Utilizamos la cláusula ORDER BY para ordenar
los registros de la columna 'lenght'. No agregamos la palabra reservada ASC al final del campo, una vez que es opcional
y los registros se ordenarán por defecto en orden ascendente. */

SELECT title AS titulo, length AS duracion
FROM film
WHERE length > 120
ORDER BY length;

 /* Ejercicio 5
Recupera los nombres de todos los actores.

Consultamos la columna 'first_name para recuperar los nombres de los actores. Proporcionamos un alias a la columna
utilizando la palabra reservada AS.*/

SELECT first_name AS nombre_actor
FROM actor;

/* Ejercicio 6
Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

Buscamos coincidencias exactas utilizando IN o WHERE. La cláusula LIKE, nos permite buscar el valor que contenga
la palabra 'Gibson' en cualquier posición dentro de la columna 'apellido' */

-- Opción con WHERE --

SELECT first_name AS nombre_actor, last_name AS apellido_actor
FROM actor
WHERE last_name = 'Gibson';

-- Opción con IN --

SELECT first_name AS nombre_actor, last_name AS apellido_actor
FROM actor
WHERE last_name IN ('Gibson');

-- Opción con LIKE --

SELECT first_name AS nombre_actor, last_name AS apellido_actor
FROM actor
WHERE last_name LIKE '%Gibson%';

/* Ejercicio 7
Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

En la primera opción, utilizamos la cláusula BETWEEN para seleccionar los registros cuyos valores se encuentren
en el rango especificado. En la segúnda opción, utilizamos los operadores de comparación en la cláusula WHERE,
estableciendo que se cumplan las condiciones especificadas con el AND.*/

-- Opcion 1 --

SELECT first_name AS nombre, actor_id
FROM actor
WHERE actor_id BETWEEN 10 AND 20
ORDER BY actor_id;

-- Opción 2 --

SELECT first_name AS nombre, actor_id
FROM actor
WHERE actor_id >= 10 AND actor_id <= 20
ORDER BY actor_id;

/* Ejercicio 8
Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su 
clasificación.

En la primera opción, utilizamos la sentencia NOT IN para excluir los resultados que coincidan con
los valores especificados en la lista. En la segunda opción, utilizamos el operador de comparación
"distinto de" para indicar que los valores tienen que ser diferentes a los valores especificados. */

-- Opción 1 --

SELECT title, rating
FROM film
WHERE rating NOT IN ('R', 'PG-13');

-- Opción 2 --

SELECT title, rating
FROM film
WHERE rating <> 'R'
AND rating <> 'PG-13';

/* Ejercicio 9
Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la 
clasificación junto con el recuento.

Utilizamos la función agregada COUNT para obtener el numero de valores de las filas del grupo.
La sentencia GROUP BY nos permite agrupar las filas en función de los valores comunes en la columna.*/

SELECT COUNT(film_id) AS total_peliculas, rating AS clasificacion
FROM film
GROUP BY rating;

/* Ejercicio 10
Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su 
nombre y apellido junto con la cantidad de películas alquiladas.

Utilizamos un LEFT JOIN para que nos devuelva todas las filas de la tabla izquierda con las filas correspondientes
de la tabla derecha. */

SELECT C.customer_id, C.first_name, C.last_name, COUNT(R.rental_id) AS total_peliculas_alquiladas
FROM rental AS R
LEFT JOIN customer AS C
ON  R.customer_id = C.customer_id
GROUP BY customer_id
ORDER BY first_name;

/* Ejercicio 11
Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la 
categoría junto con el recuento de alquileres.

El INNER JOIN nos devuelve solo las filas en las que coinciden los valores en ambas tablas, basandose en una condición
de union especificada (ON).
El utilizo de diferentes INNER JOIN nos permite relacionar varias tablas. */

SELECT name AS categoria, COUNT(rental_id) AS total_peliculas_alquiladas
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film_category ON inventory.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY film_category.category_id
ORDER BY COUNT(rental_id) DESC;

/* Ejercicio 12
Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y 
muestra la clasificación junto con el promedio de duración.

Utilizamos la función de agregación 'AVG' para obtener el valor medio de las filas del grupo. */

SELECT ROUND(AVG(length)) AS promedio_duracion, rating
FROM film
GROUP BY rating
ORDER BY promedio_duracion;

/* Ejercicio 13
Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

El utilizo de INNER JOIN nos permite buscar coincidencias en las columnas especificadas de las tablas que estamos uniendo.
La cláusula ON nos permite especificar las condiciones de unión entre las tablas. Con el WHERE especificamos los registros
que queremos mantener en el conjunto de resultados.*/

SELECT first_name, last_name, title
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE title = 'Indian Love'
ORDER BY last_name;

/* Ejercicio 14
Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
Utilizamos la cláusula LIKE para filtrar por coincidencias de palabra utilizando patrones de cadena de texto.
En este caso, el valor a filtrar contiene 'dog' o 'cat' en cualquier posición. 
*/ 

SELECT title, description
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';
 
/* Ejercicio 15
Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor

Realizamos una subconsulta utilizando el operador NOT IN para identificar los registros que no tienen un
equivalente en la subconsulta. En este caso la consulta nos devuleve NULL una vez que no hay ningún actor
o actriz que no aparezca en ninguna pelicula en la tabla film_actor */

SELECT actor_id, first_name
FROM actor
WHERE actor_id NOT IN (SELECT actor_id
					   FROM film_actor);

/* Ejercicio 16
Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

Utilizamos la cláusula BETWEEN para seleccionar los registros cuyos valores se encuentren
en el rango especificado. */

SELECT title, release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010
ORDER BY release_year;

/* Ejercicio 17
Encuentra el título de todas las películas que son de la misma categoría que "Family".

Utilizamos INNER JOIN para relacionar tres tablas y las cruzamos en base a una condición de unión especificada (ON).
Con la cláusula WHERE filtramos el conjunto de resultados defieniendo las filas que queremos mantener. */

SELECT title AS titulo, name AS categoria
FROM film
INNER JOIN film_category ON film.film_ID = film_category.film_ID
INNER JOIN category ON film_category.category_ID = category.category_ID
WHERE name = 'Family'
ORDER BY titulo;

/* Ejercicio 18
Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

Después de utilizar INNER JOIN para combinar las tablas, el GROUP BY nos permite agrupar los datos. Utilizamos
HAVING para filtrar los grupos generados. Mostramos, por cada actor, el numero total de peliculas en el que aparece. */

SELECT first_name, last_name, COUNT(film_ID) AS num_film
FROM actor
INNER JOIN film_actor ON actor.actor_ID = film_actor.actor_ID
GROUP BY film_actor.actor_ID
HAVING num_film > 10
ORDER BY num_film;

/* Ejercicio 19
Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la  tabla film.

La columna lenght de la tabla film expresa la duración de las peliculas en minutos, 2 horas corresponden a 120 minutos.
En la cláusula WHERE definimos las condiciones de filtrado. */

SELECT title, rating, length
FROM film
WHERE rating = 'R' AND length > 120
ORDER BY length;

/* Ejercicio 20
Encuentra las categorías de películas que tienen un promedio de duración superior a 120 
minutos y muestra el nombre de la categoría junto con el promedio de duración.

Utilizamos la función de agregación 'AVG' para obtener el valor medio de las filas del grupo.
Tras utilizar INNER JOIN para combinar tres tablas, empleamos GROUP BY para agrupar los datos en grupos
que filtraremos con HAVING. */

SELECT name AS nombre_categoria, ROUND(AVG(length)) AS promedio_duracion
FROM film
INNER JOIN film_category ON film.film_ID = film_category.film_ID
INNER JOIN category ON film_category.category_ID = category.category_ID
GROUP BY category.category_ID
HAVING promedio_duracion > 120;

/* Ejercicio 21
Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor 
junto con la cantidad de películas en las que han actuado.

Utilizamos INNER JOIN para unir dos tablas relacionandolas en base a una condición y con el GROUP BY agrupamos los datos.
El uso de HAVING nos permite filtrar los grupos generados.
Mostramos el nombre completo de cada actor y el numero total de peliculas en el que aparece. */

SELECT CONCAT(actor.first_name, ' ',actor.last_name) AS nombre_completo, COUNT(film_id) AS cantidad_peliculas
FROM film_actor
INNER JOIN actor ON film_actor.actor_ID = actor.actor_ID
GROUP BY actor.actor_ID
HAVING COUNT(film_id) >= 5
ORDER BY COUNT(film_id);

/* Ejercicio 22
Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una 
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona 
las películas correspondientes.

Utilizamos la función DATEDIFF para calcular la diferencia entre las fechas y obtener los días que una película
estuvo alquilada. */

SELECT title
FROM film
WHERE film_id IN (SELECT film_id
				  FROM inventory
                  WHERE inventory_id IN (SELECT inventory_id
										 FROM rental
                                         WHERE DATEDIFF(return_date, rental_date)>5));
-- Opción utilizando INNER JOIN --                                         

SELECT DISTINCT title
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_ID
WHERE DATEDIFF(return_date, rental_date) > 5;
                                         
/* Ejercicio 23
Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la 
categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en 
películas de la categoría "Horror" y luego exclúyelos de la lista de actores.

Tras obtener, por medio de subconsultas, los actores que han actuado en la categoria 'Horror', utilizamos
el operador NOT IN para que nos devuelva los registros que no tienen equivalente en las subconsultas. */

SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (SELECT actor_id
						FROM film_actor
                        WHERE film_id IN (SELECT film_id
										  FROM film_category
										  WHERE category_id = (SELECT category_id
																FROM category
																WHERE  name = 'Horror')));

-- BONUS --

/* Ejercicio 24

BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 
minutos en la tabla film.

Utilizamos INNER JOIN para relacionar tres tablas. El WHERE nos permite filtrar las registros antes de agruparlos. Una vez
tengamos los datos agrupados (GROUP BY) empleamos HAVING para filtrar los grupos obtenidos. */

SELECT title AS titulo, name AS categoria, ROUND(AVG(length)) AS duración
FROM film
INNER JOIN film_category ON film.film_ID = film_category.film_ID
INNER JOIN category ON film_category.category_ID = category.category_ID
WHERE name = 'Comedy'
GROUP BY title, name
HAVING AVG(length) > 180
ORDER BY AVG(length);



