-- 4. Construye las siguientes consultas: 

-- *4.1 Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor.
-- (Para que las consultas de Insertar, Modificar y Eliminar quedaran más claras, he decidido ingresar datos ficticios.) 

-- INSERTAR:
INSERT INTO public.customer (store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active)
VALUES (1, 'Juan', 'Pérez', 'juan.perez@correo.com', 432, true, '2023-06-08', NOW(), 1);

INSERT INTO public.staff (first_name, last_name, address_id, email, store_id, active, username, password, last_update, picture)
VALUES ('Lucas', 'Soto', 2, 'lucas.soto@correo.com', 2, true, 'Lucas', 'pass123', NOW(), 'picture');

INSERT INTO public.actor (first_name, last_name, last_update)
VALUES ('Ana', 'Reyes', NOW());


-- MODIFICAR:
UPDATE public.customer
SET email = 'nuevo.correo.barbara.j@correo.com'
WHERE first_name = 'Barbara' AND last_name = 'Jones';

UPDATE public.staff
SET username = 'Miguel'
WHERE staff_id = 1;

UPDATE public.actor
SET first_name = 'Pedro', last_name = 'Pascal'
WHERE actor_id = 6;

-- ELIMINAR:
-- Al momento de ELIMINAR datos, es necesario tener presente que en esta Base de Datos especifica los datos dependen de otras tablas, 
-- por lo que para evitar modificar las RELACIONES entre tablas, las siguientes consultas de ELIMINAR se harán de forma simulada, evitando así 
-- conflictos entre ellas. 
DELETE FROM public.customer
WHERE customer_id = 1;

DELETE FROM public.staff
WHERE staff_id = 1;

-- Eliminando actor (la tabla 'actor' al solo tener dependencia de una sola tabla 'film_actor', es posible borrar directamente el dato en la 
-- tabla 'actor' si primero se borra el mismo dato en la tabla 'film_actor').
DELETE FROM public.film_actor
WHERE actor_id = 6;
DELETE FROM public.actor
WHERE actor_id = 6;




-- * 4.2 Listar todas las “rental” con los datos del “customer” dado un año y mes. 
SELECT rental.rental_id, rental.rental_date, customer.customer_id, customer.first_name, customer.last_name
FROM rental 
JOIN customer ON rental.customer_id = customer.customer_id
WHERE rental.rental_date IN (
    SELECT rental_date
    FROM rental
    WHERE EXTRACT(YEAR FROM rental_date) = '2005'
    AND EXTRACT(MONTH FROM rental_date) = '08'
)
ORDER BY rental.rental_id;



-- * 4.3 Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”. 
SELECT payment_id AS "numero", payment_date AS "fecha", amount AS "total"
FROM public.payment
ORDER BY amount;



-- * 4.4 Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.
SELECT film_id, title as nombre_film, release_year, rental_rate
FROM public.film
WHERE release_year = 2006 AND rental_rate > 4.0
ORDER BY film_id;



--* 5. Realiza  un  Diccionario  de  datos  que  contenga  el  nombre  de  las  tablas  y  columnas,  si éstas pueden ser nulas, y su tipo de dato correspondiente.
SELECT
    cols.TABLE_NAME AS tabla_nombre,
    cols.COLUMN_NAME AS columna_nombre,
    cols.IS_NULLABLE AS columna_nulo,
    cols.DATA_TYPE AS columna_tipo_dato
FROM 
    INFORMATION_SCHEMA.COLUMNS cols
    INNER JOIN PG_CLASS tablas ON (tablas.RELNAME = cols.TABLE_NAME)
WHERE cols.TABLE_SCHEMA = 'public'
ORDER BY cols.TABLE_NAME;
	